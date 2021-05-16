//
//  GPCodeManager.m
//  GPFX
//
//  Created by apple on 2021/1/19.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPCodeManager.h"
#import "GPDayModel.h"

//#define kGPFXCachePath             @"$(PROJECT_DIR)/GPCodeCache"
#define kGPFXCachePath      @"/Users/apple/MyWork/GSFY/GPFX/GPFX/GPCodeCache"

@interface GPCodeManager ()

@property (strong, nonatomic) NSMutableArray *allCode;
@property (strong, nonatomic) NSMutableArray *allUp;
@property (strong, nonatomic) NSMutableArray *allDown;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) int readErrorCount;
@property (strong, nonatomic) NSURLSession *session;


@end

@implementation GPCodeManager

- (NSMutableArray *)allCode {
    if (_allCode == nil) {
        _allCode = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _allCode;
}
- (NSMutableArray *)allUp {
    if (_allUp == nil) {
        _allUp = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _allUp;
}
- (NSMutableArray *)allDown {
    if (_allDown == nil) {
        _allDown = [NSMutableArray arrayWithCapacity:1];
    }
    
    return _allDown;
}

- (instancetype)init {
    if (self = [super init]) {
        self.count = 0;
        self.readErrorCount = 0;
        self.session = [NSURLSession sharedSession];
    }
    
    return self;
}

//在上海证券交易所挂牌的交易品种皆由6位数字来进行编码的，而深圳皆由4位数字来进行编码的。其编码范围如下：

//沪市A股票买卖的代码是以600、601、603打头，如：运盛实业，股票代码是600767，中国国航(7.72,0.32,4.32%)是601111。
//沪市新股申购的代码是以730打头。如：中信证券(40.89,-0.88,-2.11%)申购的代码是730030。
//深市A股票买卖的代码是以000打头，如：顺鑫农业(10.66,-0.05,-0.47%)，股票代码是000860。
//深市新股申购的代码与深市股票买卖代码一样，如：中信证券在深市市值配售代码是003030。
//中小板股票代码以002打头，如：东华合创(33.06,0.27,0.82%)代码是002065。
//创业板股票代码以300打头，如：探路者股票代码是：300005。 [3]

//B股买卖的代码是以900打头，如：上电B股(0.448,0.00,0.90%)，代码是900901。

//B股买卖的代码是以200打头，如：深中冠B(4.04,-0.03,-0.74%)股，代码是200018。
//配股代码，沪市以700打头，深市以080打头。如：运盛实业配股代码是700767。深市草原兴发配股代码是080780。


//创业板股票代码以300打头，如：探路者股票代码是：300005。 [3]


- (NSArray *)searchSHCodeFromCache:(BOOL)cache {
    [self search600CodeFromCache:cache];
    return nil;
}
- (NSArray *)search600CodeFromCache:(BOOL)cache {
    [self requestData:@"600000" first:YES];
    
    return nil;
}

/// 请求数据
/// @param code 股票代码
/// @param first 是否为第一次请求
- (void)requestData:(NSString *)code first:(BOOL)first {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSString *labelCode = [self labelCode:code first:first];
        if (labelCode == nil) {
            return;
        }
        
//        NSString *path = [NSString stringWithFormat:@"http://quotes.money.163.com/service/chddata.html?code=%@&start=20210208&end=20210221&fields=TCLOSE;HIGH;LOW;TOPEN;LCLOSE;CHG;PCHG", labelCode];
        NSString *path = [NSString stringWithFormat:@"http://quotes.money.163.com/service/chddata.html?code=%@&start=20210208&end=20210221", labelCode];
        NSURL *url = [NSURL URLWithString:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self readData:code from:location first:first];
            });
        }];
        [task resume];
    });
}

/// 错误或者完成处理
/// @param code 股票代码
- (void)errorAndCompletionControl:(NSString *)code {
    self.count++;
    NSString *nextCode = nil;
    if (self.count < 1000) {
        nextCode = [NSString stringWithFormat:@"%06i", [code intValue] + 1];
    } else {
        [self.allCode writeToFile:[NSString stringWithFormat:@"%@/AllCode.plist", kGPFXCachePath] atomically:YES];
        [self.allUp writeToFile:[NSString stringWithFormat:@"%@/AllUp.plist", kGPFXCachePath] atomically:YES];
        [self.allDown writeToFile:[NSString stringWithFormat:@"%@/AllDown.plist", kGPFXCachePath] atomically:YES];
        self.count = 0;
        if ([code hasPrefix:@"600"]) {
            nextCode = [NSString stringWithFormat:@"601%03i", self.count];
        } else if ([code hasPrefix:@"601"]) {
            nextCode = [NSString stringWithFormat:@"602%03i", self.count];
        } else if ([code hasPrefix:@"602"]) {
            nextCode = [NSString stringWithFormat:@"603%03i", self.count];
        } else if ([code hasPrefix:@"603"]) {
            nextCode = [NSString stringWithFormat:@"000%03i", self.count];
        } else if ([code hasPrefix:@"000"]) {
            nextCode = [NSString stringWithFormat:@"002%03i", self.count];
        } else if ([code hasPrefix:@"002"]) {
            nextCode = [NSString stringWithFormat:@"300%03i", self.count];
        }
    }
    
    if (nextCode) {
        [self requestData:nextCode first:YES];
    }
}

/// 获取带标签的股票代码（备注股票代码首位是0则需添加一个1，非0则需添加一个0）
/// @param code 股票代码
/// @param first 是否为第一次获取
- (NSString *)labelCode:(NSString *)code first:(BOOL)first {
    NSString *labelCode = nil;
    if ([code hasPrefix:@"6"] || [code hasPrefix:@"7"]) { // 上海
        if (first) {
            labelCode = [NSString stringWithFormat:@"0%@", code];
        } else {
            labelCode = [NSString stringWithFormat:@"1%@", code];
        }
    } else if ([code hasPrefix:@"0"]) { // 深圳
        if (first) {
            labelCode = [NSString stringWithFormat:@"1%@", code];
        } else {
            labelCode = [NSString stringWithFormat:@"0%@", code];
        }
    } else if ([code hasPrefix:@"002"] || [code hasPrefix:@"300"]) { // 中小板/创业板
        if (first) { // 上海
            labelCode = [NSString stringWithFormat:@"0%@", code];
        } else { // 深圳
            labelCode = [NSString stringWithFormat:@"1%@", code];
        }
    }
    
    return labelCode;
}

/// 解析数据
/// @param url 数据地址
/// @param first 是否第一次请求数据
- (NSArray *)readData:(NSString *)code from:(NSURL *)url first:(BOOL)first {
    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSError *readError = nil;
    NSString *str = [[NSString alloc] initWithContentsOfURL:url encoding:encode error:&readError];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:1];
    if (readError) {
        NSLog(@"%@读取失败！", code);
        if (self.readErrorCount < 3) {
            self.readErrorCount++;
            [self requestData:code first:first];
        } else {
            self.readErrorCount = 0;
            [self errorAndCompletionControl:code];
        }
    } else {
        NSArray *days = [str componentsSeparatedByString:@"\n"];
        if (days.count > 2) { // 取出第一排表头
            NSLog(@"----%@----", code);
            [self.allCode addObject:code];
            for (int i = 2; i < days.count; i++) {
                NSString *day = [days objectAtIndex:i];
                NSArray *data = [day componentsSeparatedByString:@","];
                if (data.count >= 10) {
                    GPDayModel *model = [[GPDayModel alloc] init];
                    model.date = [data objectAtIndex:0];
                    model.code = [data objectAtIndex:1];
                    model.name = [data objectAtIndex:2];
                    model.TCLOSE = [[data objectAtIndex:3] floatValue];
                    model.HIGH = [[data objectAtIndex:4] floatValue];
                    model.LOW = [[data objectAtIndex:5] floatValue];
                    model.TOPEN = [[data objectAtIndex:6] floatValue];
                    model.LCLOSE = [[data objectAtIndex:7] floatValue];
                    model.CHG = [[data objectAtIndex:8] floatValue];
                    model.PCHG = [[data objectAtIndex:9] floatValue];
                    model.TURNOVER = [[data objectAtIndex:10] floatValue];
                    model.VOTURNOVER = [[data objectAtIndex:11] floatValue];
                    model.VATURNOVER = [[data objectAtIndex:12] floatValue];
                    model.TCAP = [[data objectAtIndex:13] floatValue];
                    model.MCAP = [[data objectAtIndex:14] floatValue];
                    [result addObject:model];
                    float up;
                    float down;
                    if (model.TOPEN > model.TCLOSE) {
                        up = model.TOPEN;
                        down = model.TCLOSE;
                    } else {
                        up = model.TCLOSE;
                        down = model.TOPEN;
                    }
                    float value = up - down;
                    if (value > 0 && down - model.LOW > value*3) {
                        [self.allUp addObject:code];
                        break;
                    }
                    if (value > 0 && model.HIGH - up > value*3) {
                        [self.allDown addObject:code];
                        break;
                    }
                }
            }
            [self errorAndCompletionControl:code];
        } else {
            if (first) {
                [self requestData:code first:NO];
            } else {
                [self errorAndCompletionControl:code];
            }
        }
    }
    
    return result;
}

@end
