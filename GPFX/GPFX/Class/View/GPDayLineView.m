//
//  GPDayLineView.m
//  GPFX
//
//  Created by 綦 on 2021/9/4.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPDayLineView.h"
#import "GPDayLineModel.h"

#define GPGreenClolor           [UIColor colorWithRed:42/255.0f green:147/255.0f blue:42/255.0f alpha:1.0f]
#define GPRedClolor             [UIColor redColor]
#define GPGrayClolor            [UIColor lightGrayColor]
#define GPOrangeClolor          [UIColor orangeColor]
#define GPBaseFont              [UIFont systemFontOfSize:10.0f]


@interface GPDayLineView ()

@property (strong, nonatomic) GPDayModel *maxModel;
@property (strong, nonatomic) GPDayModel *minModel;

@end

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
    [self handleDatas];
    if (self.maxModel && self.minModel) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGFloat spacing = 2.0f;
        CGFloat marginH = 5.0f;
        CGFloat marginV = 15.0f;
        CGFloat lineW = 1.0f;
        CGFloat scale = (rect.size.height - 2*marginV)/(self.maxModel.HIGH - self.minModel.LOW);
        CGFloat W = (rect.size.width - spacing*(self.datas.count - 1) - marginH*2)/self.datas.count;
        
        // 边框
        CGContextAddRect(context, rect);
        [GPGrayClolor setStroke];
        CGContextSetLineWidth(context, lineW);
        CGContextDrawPath(context, kCGPathStroke);
        
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
            CGFloat Y = 0.0f;
            CGFloat H = 0.0f;
            
            // 下跌（绿色）
            if (down) {
                [GPGreenClolor setFill];
                [GPGreenClolor setStroke];
                
                // 实体
                Y = rect.size.height - marginV - (model.TOPEN - self.minModel.LOW)*scale;
                H = (model.TOPEN - model.TCLOSE)*scale;
                CGContextAddRect(context, CGRectMake(X, Y, W, H));
                CGContextDrawPath(context, kCGPathFill);
                
                // 上影线
                CGContextMoveToPoint(context, X + W/2.0f, Y);
                CGContextAddLineToPoint(context, X + W/2, Y - (model.HIGH - model.TOPEN)*scale);
                
                // 下影线
                CGContextMoveToPoint(context, X + W/2.0f, Y + H);
                CGContextAddLineToPoint(context, X + W/2.0f, Y + H + (model.TCLOSE - model.LOW)*scale);
                CGContextDrawPath(context, kCGPathFillStroke);
                
                // 最大文案
                if (model.max) {
                    NSString *max = [NSString stringWithFormat:@"%.2f", model.HIGH];
                    NSDictionary *attributues = @{NSForegroundColorAttributeName: GPOrangeClolor, NSFontAttributeName: GPBaseFont};
                    CGSize size = [max sizeWithAttributes:attributues];
                    CGFloat maxY = Y - (model.HIGH - model.TOPEN)*scale;
                    // 文案在左边
                    if (index < self.datas.count/2.0) {
                        CGContextMoveToPoint(context, X + W/2, maxY);
                        CGContextAddLineToPoint(context, X - marginH, maxY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [max drawAtPoint:CGPointMake(X - size.width - marginH - W, maxY - size.height/2.0f) withAttributes:attributues];
                        
                    // 文案在右边
                    } else {
                        CGContextMoveToPoint(context, X + W/2, maxY);
                        CGContextAddLineToPoint(context, X + W/2 + marginH, maxY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [max drawAtPoint:CGPointMake(X + marginH + W, maxY - size.height/2.0f) withAttributes:attributues];
                    }
                }
                // 最小文案
                if (model.min) {
                    NSString *min = [NSString stringWithFormat:@"%.2f", model.LOW];
                    NSDictionary *attributues = @{NSForegroundColorAttributeName: GPOrangeClolor, NSFontAttributeName: GPBaseFont};
                    CGSize size = [min sizeWithAttributes:attributues];
                    CGFloat minY = Y + H + (model.TCLOSE - model.LOW)*scale;
                    // 文案在左边
                    if (index < self.datas.count/2.0) {
                        CGContextMoveToPoint(context, X + W/2, minY);
                        CGContextAddLineToPoint(context, X - marginH, minY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [min drawAtPoint:CGPointMake(X - size.width - marginH - W, minY - size.height/2.0f) withAttributes:attributues];
                        
                    // 文案在右边
                    } else {
                        CGContextMoveToPoint(context, X + W/2, minY);
                        CGContextAddLineToPoint(context, X + W/2 + marginH, minY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [min drawAtPoint:CGPointMake(X + marginH + W, minY - size.height/2.0f) withAttributes:attributues];
                    }
                }
                
                // 上涨（红色）
            } else {
                // 实体
                Y = rect.size.height - marginV - (model.TCLOSE - self.minModel.LOW)*scale;
                H = (model.TCLOSE - model.TOPEN)*scale;
                [GPRedClolor setStroke];
                CGContextAddRect(context, CGRectMake(X, Y, W, H));
                CGContextDrawPath(context, kCGPathStroke);
                
                // 上影线
                CGContextMoveToPoint(context, X + W/2.0f, Y);
                CGContextAddLineToPoint(context, X + W/2, Y - (model.HIGH - model.TCLOSE)*scale);
                
                // 下影线
                CGContextMoveToPoint(context, X + W/2.0f, Y + H);
                CGContextAddLineToPoint(context, X + W/2.0f, Y + H + (model.TOPEN - model.LOW)*scale);
                [GPRedClolor setStroke];
                CGContextDrawPath(context, kCGPathStroke);
                
                // 最大文案
                if (model.max) {
                    NSString *max = [NSString stringWithFormat:@"%.2f", model.HIGH];
                    NSDictionary *attributues = @{NSForegroundColorAttributeName: GPOrangeClolor, NSFontAttributeName: GPBaseFont};
                    CGSize size = [max sizeWithAttributes:attributues];
                    CGFloat maxY = Y - (model.HIGH - model.TCLOSE)*scale;
                    // 文案在左边
                    if (index < self.datas.count/2.0) {
                        CGContextMoveToPoint(context, X + W/2, maxY);
                        CGContextAddLineToPoint(context, X - marginH, maxY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [max drawAtPoint:CGPointMake(X - size.width - marginH - W, maxY - size.height/2.0f) withAttributes:attributues];
                        
                    // 文案在右边
                    } else {
                        CGContextMoveToPoint(context, X + W/2, maxY);
                        CGContextAddLineToPoint(context, X + W/2 + marginH, maxY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [max drawAtPoint:CGPointMake(X + marginH + W, maxY - size.height/2.0f) withAttributes:attributues];
                    }
                }
                // 最小文案
                if (model.min) {
                    NSString *min = [NSString stringWithFormat:@"%.2f", model.LOW];
                    NSDictionary *attributues = @{NSForegroundColorAttributeName: GPOrangeClolor, NSFontAttributeName: GPBaseFont};
                    CGSize size = [min sizeWithAttributes:attributues];
                    CGFloat minY = Y + H + (model.TOPEN - model.LOW)*scale;
                    // 文案在左边
                    if (index < self.datas.count/2.0) {
                        CGContextMoveToPoint(context, X + W/2, minY);
                        CGContextAddLineToPoint(context, X - marginH, minY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [min drawAtPoint:CGPointMake(X - size.width - marginH - W, minY - size.height/2.0f) withAttributes:attributues];
                        
                    // 文案在右边
                    } else {
                        CGContextMoveToPoint(context, X + W/2, minY);
                        CGContextAddLineToPoint(context, X + W/2 + marginH, minY);
                        [GPOrangeClolor setStroke];
                        CGContextDrawPath(context, kCGPathStroke);
                        
                        [min drawAtPoint:CGPointMake(X + marginH + W, minY - size.height/2.0f) withAttributes:attributues];
                    }
                }
            }
        }
        
    }
}

- (void)handleDatas {
    if (self.datas && self.datas.count > 0) {
        for (GPDayModel *model in self.datas) {
            if (model.HIGH > self.maxModel.HIGH) {
                self.maxModel.max = NO;
                self.maxModel = model;
                self.maxModel.max = YES;
            }
            if (model.LOW < self.minModel.LOW) {
                self.minModel.min = NO;
                self.minModel = model;
                self.minModel.min = YES;
            } else if (self.minModel == nil) {
                self.minModel = model;
                self.minModel.min = YES;
            }
        }
    }
}

@end
