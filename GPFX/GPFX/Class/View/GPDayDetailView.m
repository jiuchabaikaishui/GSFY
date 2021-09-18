//
//  GPDayDetailView.m
//  GPFX
//
//  Created by 綦 on 2021/9/18.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPDayDetailView.h"
#import "Masonry.h"


#define GPDayDetailMaxFont          [UIFont systemFontOfSize:24.0f]
#define GPDayDetailMidFont          [UIFont systemFontOfSize:12.0f]
#define GPDayDetailMinFont          [UIFont systemFontOfSize:10.0f]

#define GPGreenClolor               [UIColor colorWithRed:42/255.0f green:147/255.0f blue:42/255.0f alpha:1.0f]
#define GPRedClolor                 [UIColor redColor]
#define GPLightGrayClolor           [UIColor lightGrayColor]
#define GPGrayClolor                [UIColor grayColor]

@interface GPDayDetailView ()

@property (weak, nonatomic) UILabel *TCLOSELabel;
@property (weak, nonatomic) UILabel *CHGLabel;
@property (weak, nonatomic) UILabel *PCHGLabel;
@property (weak, nonatomic) UILabel *HIGHTitleLabel;
@property (weak, nonatomic) UILabel *HIGHLabel;
@property (weak, nonatomic) UILabel *LOWTitleLabel;
@property (weak, nonatomic) UILabel *LOWLabel;
@property (weak, nonatomic) UILabel *TOPENTitleLabel;
@property (weak, nonatomic) UILabel *TOPENLabel;

@end

@implementation GPDayDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildSubViews];
    }
    
    return self;
}

- (void)buildSubViews {
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    UILabel *label = [[UILabel alloc] init];
    label.font = GPDayDetailMaxFont;
    label.textColor = GPRedClolor;
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.TCLOSELabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.0f);
        make.top.equalTo(self);
        make.width.equalTo(@(floorf((screenWith - 50)/4)));
        make.height.equalTo(@(floorf(self.bounds.size.height/3*2)));
    }];
    
    label = [[UILabel alloc] init];
    label.font = GPDayDetailMinFont;
    label.textColor = GPRedClolor;
    label.textAlignment = NSTextAlignmentLeft;
    [self addSubview:label];
    self.TCLOSELabel = label;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10.0f);
        make.top.equalTo(self);
        make.width.equalTo(@(floorf((screenWith - 50)/4)));
        make.height.equalTo(@(floorf(self.bounds.size.height/3*2)));
    }];
}

@end
