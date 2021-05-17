//
//  GPDayModel.h
//  GPFX
//
//  Created by apple on 2021/2/22.
//  Copyright © 2021 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPDayModel : NSObject

/// 日期
@property (copy, nonatomic) NSString *date;
/// 股票代码
@property (copy, nonatomic) NSString *code;
/// 名称
@property (copy, nonatomic) NSString *name;
/// 收盘价
@property (assign, nonatomic) float TCLOSE;
/// 最高价
@property (assign, nonatomic) float HIGH;
/// 最低价
@property (assign, nonatomic) float LOW;
/// 开盘价
@property (assign, nonatomic) float TOPEN;
/// 前收盘
@property (assign, nonatomic) float LCLOSE;
/// 涨跌额
@property (assign, nonatomic) float CHG;
/// 涨跌幅
@property (assign, nonatomic) float PCHG;
/// 换手率
@property (assign, nonatomic) float TURNOVER;
/// 成交量
@property (assign, nonatomic) float VOTURNOVER;
/// 成交金额
@property (assign, nonatomic) float VATURNOVER;
/// 总市值
@property (assign, nonatomic) float TCAP;
/// 流通市值
@property (assign, nonatomic) float MCAP;

//TCLOSE收盘价
//HIGH最高价
//LOW最低价
//TOPEN开盘价
//LCLOSE前收盘价
//CHG涨跌额
//PCHG涨跌幅
//TURNOVER换手率
//VOTURNOVER成交量
//VATURNOVER成交金额
//TCAP总市值
//MCAP流通市值

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
