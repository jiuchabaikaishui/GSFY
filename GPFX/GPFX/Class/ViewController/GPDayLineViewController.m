//
//  GPDayLineViewController.m
//  GPFX
//
//  Created by 綦 on 2021/9/4.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPDayLineViewController.h"
#import "GPDayLineView.h"
#import "Masonry.h"

@interface GPDayLineViewController ()

@end

@implementation GPDayLineViewController

- (NSArray *)models {
    if (_models == nil) {
        _models = [NSArray array];
    }
    
    return _models;
}

+ (instancetype)controllerWithDayModels:(NSArray *)models {
    return [[self alloc] initWithDayModels:models];
}
- (instancetype)initWithDayModels:(NSArray *)models {
    if (self = [super init]) {
        self.models = models;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    GPDayModel *model = [self.models firstObject];
    self.title = [NSString stringWithFormat:@"%@%@", model.name, model.code];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    GPDayLineView *view = [[GPDayLineView alloc] init];
    view.datas = self.models;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5.0f);
        make.right.equalTo(self.view).offset(-5.0f);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(5.0f);
        make.height.equalTo(@(200.0f));
    }];
}

@end
