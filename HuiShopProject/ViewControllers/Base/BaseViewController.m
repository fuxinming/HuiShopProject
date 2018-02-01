//
//  BaseViewController.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/2.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "BaseViewController.h"
#import "MBProgressHUD.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "UIScrollView+PopGesture.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize navHidden = _navHidden;
- (id)init{
    self = [super init];
    if (self) {
        // Custom initialization
        _navHidden = NO;
        self.hiddenBack = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.fd_prefersNavigationBarHidden = YES;
   	self.automaticallyAdjustsScrollViewInsets = NO;
//    self.backGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    [self.view addSubview:self.backGroundView];
    [self initNav];
    [self.view setBackgroundColor:COLOR_BACKGROUND];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fd_prefersNavigationBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    
}
-(void)vcPop{
    RootNavPop(YES);
}

#pragma mark - Private
- (void)initNav{
    WS(bself);
    if (!self.navHidden) {
        _navBar = [[FMNavBar alloc] init];
        if (bself.navigationController){
            NSArray *array = bself.navigationController.viewControllers;
            if ([array count] > 0) {
                id rootVC = [self.navigationController.viewControllers objectAtIndex:0];
                id topVC = self.navigationController.topViewController;
                if (self != rootVC && self == topVC && !self.hiddenBack) {
                    _navBar.leftItemList = [NSArray arrayWithObject:[FMBarItem itemImg:@"back" withClick:^(id it) {
                        [bself vcPop];
                    }]];
                }
            }
        }
        [self.view addSubview:_navBar];
    }
}


- (void)popToViewController:(NSString *)cls{
    NSMutableArray *ar = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
        id ttt = [self.navigationController.viewControllers objectAtIndex:i];
        [ar addObject:ttt];
        if ([ttt isKindOfClass:[NSClassFromString(cls) class]]) {
            break;
        }
    }
    [self.navigationController setViewControllers:ar animated:YES];
}

#pragma mark - Private
- (void)hiddenLoading {
    [MBProgressHUD hideHUDForView:Window animated:YES];
}

- (void)showLoading {
    [MBProgressHUD showHUDAddedTo:Window animated:YES];
}
@end
