//
//  GPCalculateModel.h
//  GPFX
//
//  Created by 綦 on 2022/6/12.
//  Copyright © 2022 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPDayModel.h"

@interface GPCalculateModel : NSObject

/// 计算KDJ
/// @param models 股票数据模型数组
+ (void)calculateKDJ:(NSArray<GPDayModel *> *)models;

@end


@interface GPHighLowModel : NSObject

@property (assign, nonatomic) float HIGH;
@property (assign, nonatomic) float LOW;

+ (instancetype)modelWithHigh:(float)high low:(float)low;
- (instancetype)initWithHigh:(float)high low:(float)low;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
