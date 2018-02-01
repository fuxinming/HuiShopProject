//
//  WSTabBar.m
//  SunnyCar
//
//  Created by jienliang on 16/10/20.
//  Copyright © 2016年 jienliang. All rights reserved.
//

#import "FMTabBar.h"
#import "LoginViewController.h"
#define btnWidth self.bounds.size.width

@implementation TabarItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self != nil) {
        
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    dictM[NSFontAttributeName] = self.titleLabel.font;
    CGRect frame = [self.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dictM context:nil];
    CGFloat imageX = (btnWidth - 22) * 0.5;
    self.imageView.frame = CGRectMake(imageX, 6, 22, 22);
    self.titleLabel.frame = CGRectMake((self.center.x - frame.size.width) * 0.5, 34, frame.size.width, 14);
    CGPoint labelCenter = self.titleLabel.center;
    labelCenter.x = self.imageView.center.x;
    self.titleLabel.center = labelCenter;
}
@end


@interface FMTabBar ()
{
    UIButton *_lastButton;
}
@end

@implementation FMTabBar

- (id)init
{
    self = [super init];
    if (self) {
        [self.tabBar setHidden:YES];//将原来的UITabBarController中的UITabBar隐藏起来；
        self.navigationController.navigationBarHidden = YES;
        self.cIndex = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.fd_prefersNavigationBarHidden = YES;
	self.automaticallyAdjustsScrollViewInsets = NO;
    [self _initViewController];//初始化UITabBarController中的控制器
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.tabBarView==nil) {
        [self _initTabbarView];
    }
}

//初始化子控制器
- (void)_initViewController {
    _main = [[MainViewController alloc] init];
    _cat = [[CategoryViewController alloc] init];
    _cart = [[CartViewController alloc] init];
    _mine = [[MineViewController alloc] init];
    self.viewControllers = @[_main,_cat,_cart,_mine];
}

//创建自定义tabBar
- (void)_initTabbarView {
    _tabBarView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - TabBarH, SCREEN_WIDTH, TabBarH)];
    _tabBarView.tag = 1111;
    _tabBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tabBarView];
    
    NSArray *backgroud = @[@"icon_home",@"icon_classification",@"icon_shoppingCart",@"icon_my"];
    NSArray *heightBackground=@[@"icon_home_sel",@"icon_classification_sel",@"icon_shoppingCart_sel",@"icon_my_sel"];
    NSArray *VCname = @[@"首页",@"分类",@"购物车",@"我的"];

    float width = SCREEN_WIDTH/backgroud.count;
    for (int i=0; i<backgroud.count; i++) {
        NSString *backImage = backgroud[i];
        NSString *heightImage = heightBackground[i];
        
        TabarItem *button = [TabarItem buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i*width, 0, width, TabBarH);
        button.tag = 100+i;
        button.titleLabel.font = [UIFont systemFontOfSize:11];
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [button setTitle:VCname[i] forState:UIControlStateNormal];
        [button setTitleColor:COLOR_333 forState:UIControlStateNormal];
        [button setTitleColor:COLOR_333 forState:UIControlStateHighlighted];
        [button setTitleColor:COLOR_RED_ forState:UIControlStateSelected];
        [button setImage:[UIImage imageNamed:backImage] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateHighlighted];
        [button setImage:[UIImage imageNamed:heightImage] forState:UIControlStateSelected];
        if (self.cIndex==i) {
            button.selected = YES;
            self.selectedIndex = self.cIndex;
            _lastButton = button;
        }
        [button addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [_tabBarView addSubview:button];
    }
    UIImageView *linee = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    linee.backgroundColor = COLOR_ddd;
    [_tabBarView addSubview:linee];
}

//点击按钮后显示哪个控制器界面
- (void)selectedTab:(UIButton *)button {
    int idx = button.tag-100;
	if (idx == 2) {
		if (!IsLogin) {
			LoginViewController *vc = [[LoginViewController alloc]init];
			RootNavPush(vc);
			return;
		}
		
	}
    
    if (_lastButton!=nil&&![_lastButton isKindOfClass:[NSNull class]]) {
        _lastButton.selected = NO;
    }
    button.selected = YES;
    self.selectedIndex = button.tag-100;
    _lastButton = button;
}

- (void)setTabIndex:(int)idx {
    UIButton *btn = (UIButton *)[_tabBarView viewWithTag:100+idx];
    if (btn&&[btn isKindOfClass:[UIButton class]]) {
        [self selectedTab:btn];
    }
}
@end
