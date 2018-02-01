//
//  WJHelpViewController.m
//  阳光好车 SunnyCar
//
//  Created by jienliang on 2017/6/15.
//  Copyright © 2017年 jienliang. All rights reserved.
//

#import "CXOpenIndexViewController.h"

@interface CXOpenIndexViewController ()
{
    UIButton *btnGoToUser;
    NSArray *arr;
}
@end

@implementation CXOpenIndexViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    arr = @[@"1",@"2",@"3"];
    self.navBar.hidden = YES;
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self initView];
}

#pragma mark - Private
- (void)initView {
    self.helpScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
    [self.helpScrollView setDelegate:self];
    [self.helpScrollView setDirectionalLockEnabled:YES];
    [self.helpScrollView setAlwaysBounceHorizontal:YES];
    [self.helpScrollView setAlwaysBounceVertical:NO];
    [self.helpScrollView setPagingEnabled:YES];
    self.helpScrollView.bounces = NO;
    [self.helpScrollView setShowsHorizontalScrollIndicator:NO];
    [self.helpScrollView setShowsVerticalScrollIndicator:NO];
    [self.helpScrollView setContentOffset:CGPointZero];
    [self.view addSubview:self.helpScrollView];
    
    for (int i = 0; i < arr.count; i++) {
        NSString *imgHeaderName = arr[i];
        UIImageView *leadView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        leadView.image = [UIImage imageNamed:imgHeaderName];
        leadView.contentMode = UIViewContentModeScaleToFill;
        [self.helpScrollView addSubview:leadView];
        
    }
    [self.helpScrollView setContentSize:CGSizeMake(self.helpScrollView.width * arr.count, self.helpScrollView.height)];
    
//    [self createBtn];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    int index = fabs(scrollView.contentOffset.x) /self.view.frame.size.width;
    if (index == arr.count - 1) {
        [self goToUser:nil];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView1 {
    [scrollView1 setContentOffset:CGPointMake(scrollView1.contentOffset.x, 0)];
    int index = fabs(scrollView1.contentOffset.x) /SCREEN_WIDTH;
    if (index == arr.count - 1) {
        btnGoToUser.hidden = NO;
    } else {
        btnGoToUser.hidden = YES;
    }
}

- (void)createBtn {
    float btnWidth = SCREEN_WIDTH;
    float top = 300;
    float height = SCREEN_HEIGHT-top;

    btnGoToUser = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH-btnWidth)/2, top , btnWidth, height)];
    btnGoToUser.hidden = YES;
    btnGoToUser.backgroundColor = [UIColor clearColor];
    [btnGoToUser addTarget:self action:@selector(goToUser:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnGoToUser];
}

#pragma mark-用户
- (void)goToUser:(UIButton *)btn {
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"GoToClient"];
    [(AppDelegate *)[CommonUtil appDelegate] goToRoot:0];
}

- (void)btnPress {

}

@end
