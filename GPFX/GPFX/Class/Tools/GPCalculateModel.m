//
//  GPCalculateModel.m
//  GPFX
//
//  Created by 綦 on 2022/6/12.
//  Copyright © 2022 QSP. All rights reserved.
//

#import "GPCalculateModel.h"

@implementation GPCalculateModel

/*
 
 RSV = (5.5-4.58)/(6.52-4.58)*100 = 0.92/1.94*100 = 47.42
 
 */
+ (void)calculateKDJ:(NSArray<GPDayModel *> *)models {
    for (NSInteger i = models.count - 1; i >= 0; i--) {
        GPDayModel *model = [models objectAtIndex:i];
        if (i == models.count - 1) {
            model.k = 50.0f;
            model.d = 50.0f;
            model.j = 50.0f;
        } else {
            // 1、找最大/小值
            GPHighLowModel *highLowModel = [self calculateHighLow:models targetIndex:i];
            
            // 2、计算RSV：RSV=(Close(当日值)-Low(9日最低值)) / (High(9日最高值)-Low(9日最低值))
            float rsv = 100.0f*(model.TCLOSE - highLowModel.LOW)/(highLowModel.HIGH - highLowModel.LOW);
            
            // 3、计算K值：2/3前一日K值+1/3RSV
            GPDayModel *yesterdayModel = [models objectAtIndex:i + 1];
            model.k = 2.0f*yesterdayModel.k/3.0f + rsv/3.0f;
            
            // 3、计算D值：2/3前一日D值+1/3当日K值
            model.d = 2.0f*yesterdayModel.d/3.0f + model.k/3.0f;
            
            // 4、计算J值：3当日K值 - 2当日D值
            model.j = 3.0f*model.k - 2.0f*model.d;
        }
    }
}

+ (GPHighLowModel *)calculateHighLow:(NSArray<GPDayModel *> *)models targetIndex:(NSInteger)targetIndex {
    GPDayModel *targetModel = [models objectAtIndex:targetIndex];
    GPHighLowModel *result = [[GPHighLowModel alloc] init];
    
    if (targetIndex > 0) {
        NSInteger endIndex = targetIndex < models.count - 9 ? targetIndex + 8 :models.count - 1 ;
        for (NSInteger i = targetIndex; i <= endIndex; i++) {
            GPDayModel *model = [models objectAtIndex:i];
            if (i == targetIndex) {
                result.HIGH = model.HIGH;
                result.LOW = model.LOW;
            } else {
                if (model.HIGH > result.HIGH) {
                    result.HIGH = model.HIGH;
                }
                if (model.LOW < result.LOW) {
                    result.LOW = model.LOW;
                }
            }
        }
    } else {
        result.HIGH = targetModel.HIGH;
        result.LOW = targetModel.LOW;
    }
    
    return result;
}

@end


@implementation GPHighLowModel

+ (instancetype)modelWithHigh:(float)high low:(float)low {
    return [[self alloc] initWithHigh:high low:low];
}
- (instancetype)initWithHigh:(float)high low:(float)low {
    if (self = [super init]) {
        self.HIGH = high;
        self.LOW = low;
    }
    
    return self;
}

@end
