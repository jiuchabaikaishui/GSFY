//
//  GPDayModel.h
//  GPFX
//
//  Created by apple on 2021/2/22.
//  Copyright © 2021 QSP. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GPDayModel : NSObject

@property (copy, nonatomic) NSString *date;
@property (copy, nonatomic) NSString *code;
@property (copy, nonatomic) NSString *name;
@property (assign, nonatomic) float close;
@property (assign, nonatomic) float max;
@property (assign, nonatomic) float min;
@property (assign, nonatomic) float open;
@property (assign, nonatomic) float lastClose;
@property (assign, nonatomic) float chageAmount;
@property (assign, nonatomic) float chageRate;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
