//
//  GPMainViewController.m
//  GPFX
//
//  Created by apple on 2021/2/21.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPMainViewController.h"
#import "GPCodeManager.h"
#import "Masonry.h"
#import "GPDayLineViewController.h"

@interface GPMainViewController ()

@end

@implementation GPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"主要功能";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"更新数据" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(updateActoin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(15.0f);
        make.left.equalTo(self.view).offset(15.0f);
        make.right.equalTo(self.view).offset(-15.0f);
        make.height.equalTo(@(44.0f));
    }];
}

- (void)updateActoin:(UIButton *)sender {
    GPCodeManager *manager = [[GPCodeManager alloc] init];
//    [manager searchSHCodeFromCache:NO];
    [manager requestData:@"600031" startDate:@"20210801" endDate:@"20210904" successful:^(NSArray<GPDayModel *> *models) {
        NSLog(@"请求成功");
        GPDayLineViewController *controller = [[GPDayLineViewController alloc] init];
        controller.models = models;
        [self.navigationController pushViewController:controller animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

@end
