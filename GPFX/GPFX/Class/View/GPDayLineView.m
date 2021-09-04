//
//  GPDayLineView.m
//  GPFX
//
//  Created by 綦 on 2021/9/4.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPDayLineView.h"
#import "GPDayLineModel.h"

@implementation GPDayLineView

//- (void)setDatas:(NSArray<GPDayModel *> *)datas {
//    _datas = datas;
//
//    [self setNeedsDisplay];
//}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self buildView];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self buildView];
    }
    return self;
}
+ (instancetype)viewWithDayDatas:(NSArray<GPDayModel *> *)datas {
    return [[self alloc] initWithDayDatas:datas];
}
- (instancetype)initWithDayDatas:(NSArray<GPDayModel *> *)datas {
    if (self = [self init]) {
        self.datas = datas;
    }
    
    return self;
}

- (void)buildView {
    self.backgroundColor = [UIColor whiteColor];
}

- (void)drawRect:(CGRect)rect {
    GPDayLineModel *lineModel = [self handleDatas];
    if (lineModel) {
        CGFloat spacing = 2.0f;
        CGFloat marginH = 4.0f;
        CGFloat marginV = 5.0f;
        CGFloat scale = (rect.size.height - 2*marginH)/(lineModel.HIGH - lineModel.LOW);
        CGFloat W = (rect.size.width - spacing*(self.datas.count - 1) - marginH*2)/self.datas.count;
        for (GPDayModel *model in self.datas) {
            NSInteger index = [self.datas indexOfObject:model];
            BOOL down = NO;
            if (model.TCLOSE < model.TOPEN) {
                down = YES;
            } else if (model.TCLOSE == model.TOPEN) {
                if (model.TCLOSE < model.LCLOSE) {
                    down = YES;
                }
            }
            
            CGFloat X = rect.size.width - marginH - W - (spacing + W)*index;
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGFloat Y = 0.0f;
            CGFloat H = 0.0f;
            
            if (down) { // 下跌（绿色）
                // 实体
                Y = rect.size.height - marginV - (model.TOPEN - lineModel.LOW)*scale;
                H = (model.TOPEN - model.TCLOSE)*scale;
                [[UIColor greenColor] setStroke];
                CGContextAddRect(context, CGRectMake(X, Y, W, H));
                
                // 影线
                CGContextAddLineToPoint(context, X + W/2.0f, Y);
                CGContextMoveToPoint(context, X + W/2, Y + (model.HIGH - model.TOPEN)*scale);
                
                CGContextAddLineToPoint(context, X + W/2.0f, Y + H);
                CGContextMoveToPoint(context, X + W/2, Y + (model.TCLOSE - model.LOW)*scale);
            } else { // 上涨（红色）
                // 实体
                Y = rect.size.height - marginV - (model.TCLOSE - lineModel.LOW)*scale;
                H = (model.TCLOSE - model.TOPEN)*scale;
                [[UIColor redColor] setStroke];
                CGContextAddRect(context, CGRectMake(X, Y, W, H));
            }
            CGContextSetLineWidth(context, 1.0f);
            CGContextDrawPath(context, kCGPathStroke);
        }
    }
}

- (GPDayLineModel *)handleDatas {
    if (self.datas && self.datas.count > 0) {
        GPDayLineModel *result = [[GPDayLineModel alloc] init];
        for (GPDayModel *model in self.datas) {
            if (model.HIGH > result.HIGH) {
                result.HIGH = model.HIGH;
            }
            if (model.LOW < result.LOW) {
                result.LOW = model.LOW;
            } else if (model == [self.datas firstObject]) {
                result.LOW = model.LOW;
            }
        }
        
        return result;
    }
    
    return nil;
}

@end
