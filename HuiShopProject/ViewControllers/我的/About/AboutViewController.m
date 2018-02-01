//
//  AboutViewController.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/20.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()<NSStreamDelegate>{
	UIView *bgView;
	UIImageView *img21;
}

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"关于惠七天";
    
    [self initMyViews];
}


-(void)initMyViews{
    bgView = [[UIView alloc]initWithFrame:CGRectMake(15,NavigationBarH + 15, SCREEN_WIDTH - 30, 120)];
    bgView.backgroundColor = [UIColor whiteColor];
    View_Border_Radius(bgView, 3, 0, Color_Clear);
    [self.view addSubview:bgView];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake((bgView.width - 100)/2, 37, 114, 32)];
    img1.image = [UIImage imageNamed:@"img_sign"];
    [bgView addSubview:img1];
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.text = [NSString stringWithFormat:@"V%@",[AppUtil getAppVersion]];
    label1.textColor = COLOR_999;
    label1.font = Font_Size_13;
    label1.frame = CGRectMake(0, img1.bottom + 14, bgView.width, 15);
    label1.textAlignment = NSTextAlignmentCenter;
    [bgView addSubview:label1];
    
	NSString *str = @"我们是谁?惠七天(www.huiqitian) 连锁超市是安徽芸聚网络科技有限公司，下属运营品牌，产品主打“便捷、优惠、优质”的运营理念。公司致力于改变中国食品安全现状。同时通过发展加盟店，使惠七天连锁超市成为连锁超市的领航者在食品安全(假冒产品)每况愈下的今天，人们普遍说的很多却做得很少，而我们的想法很简单，就是想大家能快速购买到自己需要的商品。互联网时代到来，人们喜欢在网上购买自己的商品，但是由于地域的限制，下单后需等3~5天才可以收到货物，通过惠七天手机APP下单，下单后商品1个小时内送达! 联系我们您对惠七天连锁超市在运营过程中有任何建议或意见，您都可以通过以下方式和我们取得联系:联系电话:4006433369 客服邮箱: service@yunjukj.com";
    float height = [CommonUtil sizeForFont:str Font:Font_Size_13 CtrlSize:CGSizeMake(SCREEN_WIDTH, MAXFLOAT)].height;
    UILabel *label = [[UILabel alloc] init];
    label.text = str;
    label.textColor = COLOR_333;
    label.font = Font_Size_13;
    label.numberOfLines = 0;
    label.adjustsFontSizeToFitWidth = YES;
    label.frame = CGRectMake(15, bgView.bottom + 15, SCREEN_WIDTH - 30, height + 20);
    [self.view addSubview:label];

	
	
	img21 = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 150)/2, label.bottom + 20, 150, 150)];
	img21.image = [UIImage imageNamed:@"liantu"];
	[self.view addSubview:img21];
	
	UILabel *label2 = [[UILabel alloc] init];
	label2.text = [NSString stringWithFormat:@"分享二维码给好友"];
	label2.textColor = COLOR_333;
	label2.font = Font_Size_13;
	label2.frame = CGRectMake(0, img21.bottom + 10, SCREEN_WIDTH, 15);
	label2.textAlignment = NSTextAlignmentCenter;
	[self.view addSubview:label2];
	
	
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake((SCREEN_WIDTH - 200)/2, img21.top, 200, 200);
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    

    
}

-(void)btnClick:(UIButton *)btn{

	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"保存到相册？" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
		NSLog(@"action = %@", action);
	}];
	UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
		 UIImageWriteToSavedPhotosAlbum(img21.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
	}];
	
	[alert addAction:cancelAction];
	[alert addAction:deleteAction];
	[self presentViewController:alert animated:YES completion:nil];
}


//回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
	NSString *msg = nil ;
	if(error != NULL){
		msg = @"保存图片失败" ;
	}else{
		msg = @"保存图片成功" ;
	}
	
	Toast(msg);
}
@end
