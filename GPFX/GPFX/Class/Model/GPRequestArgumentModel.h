//
//  GPRequestArgumentModel.h
//  GPFX
//
//  Created by 綦 on 2021/5/24.
//  Copyright © 2021 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPRequestArgumentModel : NSObject

/// 股票代码
@property (copy, nonatomic) NSString *code;
/// 开始日期
@property (copy, nonatomic) NSString *startDate;
/// 结束日期
@property (copy, nonatomic) NSString *endDate;


@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
