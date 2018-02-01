//
//  ATLLotteryController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/16.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "ATLLotteryController.h"
#import "LotteryRouletteView.h"
#import "LuckyRecordViewController.h"
@interface ATLLotteryController (){
	NSMutableArray *initArr;
	UIScrollView *_scrollView;
}
@property (nonatomic, strong) LotteryRouletteView * lotteryRouletteView;
@end


@implementation ATLLotteryController

- (void)viewDidLoad {
	[super viewDidLoad];
	self.navBar.title = @"幸运大转盘";
	self.navBar.rightItemList = [NSArray arrayWithObject:[FMBarItem itemWith:@"中奖纪录" withClick:^(id it) {
		LuckyRecordViewController *vc = [[LuckyRecordViewController alloc]init];
		RootNavPush(vc);
	}]];
	[self getData];
}


-(void)getData{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:@"1" forKey:@"curpage"];
	[param setObject:@"10" forKey:@"rp"];
	[param setObject:@"0" forKey:@"state"];
	[param setObject:@"1" forKey:@"type"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_luckygood_list Param:param isCache:NO success:^(id json) {
		NSArray *arr = json[@"obj"];
		initArr = [NSMutableArray array];
		for (int i = arr.count - 1; i >= 0 ; i--) {
			[initArr addObject:arr[i]];
		}
		[bself initViews];
	} fail:^(id json) {
		_scrollView.hidden = YES;
		Toast(@"网络错误");
		[self initEmptyForm:self.formTable.height andType:2];
	}];
}


-(void)initViews{
	if (_scrollView == nil) {
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH)];
		_scrollView.delegate = self;
		[_scrollView setDirectionalLockEnabled:YES];
		[_scrollView setAlwaysBounceHorizontal:YES];
		[_scrollView setAlwaysBounceVertical:NO];
		[_scrollView setPagingEnabled:YES];
		_scrollView.bounces = NO;
		[_scrollView setShowsHorizontalScrollIndicator:NO];
		[_scrollView setShowsVerticalScrollIndicator:NO];
		_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 750);
	}
	[self.view addSubview:_scrollView];
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 750)];
	img1.image = [UIImage imageNamed:@"drawbackground"];
	[_scrollView addSubview:img1];
	
	UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
	img2.image = [UIImage imageNamed:@"yun"];
	[_scrollView addSubview:img2];
	
	UIImageView *img3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 750 - 65, SCREEN_WIDTH, 65)];
	img3.image = [UIImage imageNamed:@"shan"];
	[_scrollView addSubview:img3];

	self.lotteryRouletteView = [[LotteryRouletteView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, 50, 300, 300) prizeArr:initArr progress:^(NSInteger currentProgress, NSInteger totalProgress) {
		
	} completion:^(NSInteger index) {
		NSLog(@"%d",index);
	}];

	self.lotteryRouletteView.prizeBgColor = COLOR_RED_;
	[_scrollView addSubview:self.lotteryRouletteView];
	
	
	UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 300)/2, 400, 300, 300)];
	bgView.backgroundColor = UIColorFromRGB(0xdde8b6);
	[_scrollView addSubview:bgView];
	
	UILabel *label = [[UILabel alloc] init];
	label.text = @"活动规则";
	label.backgroundColor = [UIColor greenColor];
	label.textColor = [UIColor whiteColor];
	label.font = Font_Size_14;
	label.frame = CGRectMake(0, 10,80 , 40);
	[bgView addSubview:label];
	
	UILabel *label1 = [[UILabel alloc] init];
	label1.text = @"1、点击本本页的抽奖按钮进行抽奖，每次抽奖扣除10个金币(参与抽奖不需要支付任何费用)。\n2、本抽奖无次数限制，金币消耗完毕将不能抽奖。\n3、中奖的商品请到就近惠七天加盟超市领取。\n4、活动解释权归安徽芸聚科技所有。\n5、本活动和设备生产商Apple无关。";
	label1.numberOfLines = 0;
	label1.textColor = COLOR_333;
	label1.font = Font_Size_14;
	label1.frame = CGRectMake(15, 50,bgView.width - 30 , 200);
	[bgView addSubview:label1];
}




@end
