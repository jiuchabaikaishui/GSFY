//
//  GPMainViewController.m
//  GPFX
//
//  Created by apple on 2021/2/21.
//  Copyright © 2021 QSP. All rights reserved.
//

#import "GPMainViewController.h"
#import "GPCodeManager.h"

@interface GPMainViewController ()

@end

@implementation GPMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[[GPCodeManager alloc] init] searchSHCodeFromCache:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
