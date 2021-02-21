//
//  ViewController.m
//  GPFX
//
//  Created by apple on 2021/1/18.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "ViewController.h"
#import "GPCodeManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[GPCodeManager alloc] init] searchSHCodeFromCache:YES];
    
//    int i = 1;
//    NSString *s = [NSString stringWithFormat:@"%03i", i];
//    NSLog(@"%@", s);
//
//    unsigned long encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"000001" ofType:@"csv"];
//    NSError *error = nil;
//    NSString *str = [[NSString alloc] initWithContentsOfFile:path encoding:encode error:&error];
//    if (error) {
//        NSLog(@"读取失败！");
//    }
//
//    NSLog(@"%@", str);
//    http://quotes.money.163.com/service/chddata.html?code=1002546&start=20210101&end=20210118&fields=TCLOSE;HIGH;LOW;TOPEN;LCLOSE;CHG;PCHG
}


@end
