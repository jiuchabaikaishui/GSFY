//
//  GPCodeManager.h
//  GPFX
//
//  Created by apple on 2021/1/19.
//  Copyright © 2021 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPDayModel.h"

@interface GPCodeManager : NSObject

/// 检索沪市A股票代码（600、601或603打头）
/// @param cache 是否从缓存检索
- (NSArray *)searchSHCodeFromCache:(BOOL)cache;
/// 检索深市A股票代码（000打头）
/// @param cache 是否从缓存检索
- (NSArray *)searchSZCodeFromCache:(BOOL)cache;
/// 检索中小板股票代码（002打头）
/// @param cache 是否从缓存检索
- (NSArray *)searchMNCodeFromCache:(BOOL)cache;
/// 检索深市新股股票代码（003打头）
/// @param cache 是否从缓存检索
- (NSArray *)searchSZNCodeFromCache:(BOOL)cache;

/// 请求数据
/// @param code 代码
/// @param start 开始日期
/// @param end 结束日期
/// @param success 成功回调
/// @param fail 失败回调
- (void)requestData:(NSString *)code startDate:(NSString *)start endDate:(NSString *)end successful:(void(^)(NSArray<GPDayModel *> *models))success failure:(void (^)(NSError *error))fail;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
