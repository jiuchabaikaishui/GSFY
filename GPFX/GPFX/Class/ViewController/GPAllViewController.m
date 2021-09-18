//
//  GPAllViewController.m
//  GPFX
//
//  Created by 綦 on 2021/5/17.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPAllViewController.h"
#import "GPCodeManager.h"
#import "Masonry.h"
#import "GPDayModel.h"
#import "MJExtension.h"
#import "GPDayLineViewController.h"

@interface GPAllViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray<GPDayModel *> *models;

@end

@implementation GPAllViewController

- (NSArray<GPDayModel *> *)models {
    if (_models == nil) {
        _models = [GPDayModel mj_objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:kGPFXAllCodePath]];
    }
    
    return _models;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"全部";
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStylePlain target:self action:@selector(updateAction:)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.bottom.equalTo(self.view);
    }];
}

- (void)updateAction:(UIBarButtonItem *)sender {
    NSLog(@"%s", __FUNCTION__);
    
    GPCodeManager *manager = [[GPCodeManager alloc] init];
    [manager searchSHCodeFromCache:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    GPDayModel *model = [self.models objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@%@", model.name, model.code];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    GPDayModel *model = [self.models objectAtIndex:indexPath.row];
    GPCodeManager *manager = [[GPCodeManager alloc] init];
    [manager requestData:[model.code substringFromIndex:1] startDate:@"20210601" endDate:@"20210906" successful:^(NSArray<GPDayModel *> *models) {
        NSLog(@"请求成功");
        GPDayLineViewController *controller = [[GPDayLineViewController alloc] init];
        if (models.count >= 67) {
            controller.models = [models subarrayWithRange:NSMakeRange(0, 67)];
        } else {
            controller.models = models;
        }
        [self.navigationController pushViewController:controller animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"请求失败");
    }];
}

@end
