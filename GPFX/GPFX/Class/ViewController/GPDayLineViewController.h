//
//  GPDayLineViewController.h
//  GPFX
//
//  Created by 綦 on 2021/9/4.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPBaseViewController.h"

@interface GPDayLineViewController : GPBaseViewController

@property (copy, nonatomic) NSArray *models;

+ (instancetype)controllerWithDayModels:(NSArray *)models;
- (instancetype)initWithDayModels:(NSArray *)models;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
