//
//  GPDayLineView.h
//  GPFX
//
//  Created by 綦 on 2021/9/4.
//  Copyright © 2021 QSP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GPDayModel.h"

@interface GPDayLineView : UIView

/// 数据
@property (copy, nonatomic) NSArray<GPDayModel *> *datas;

+ (instancetype)viewWithDayDatas:(NSArray<GPDayModel *> *)datas;
- (instancetype)initWithDayDatas:(NSArray<GPDayModel *> *)datas;

@end

NS_ASSUME_NONNULL_BEGIN

NS_ASSUME_NONNULL_END
