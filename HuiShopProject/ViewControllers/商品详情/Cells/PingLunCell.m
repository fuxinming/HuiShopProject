//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "PingLunCell.h"
#import "ShowBigPicViewController.h"
@implementation PingLunItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 70;
    }
    return self;
}

@end

@interface PingLunCell()
{

}
@end

@implementation PingLunCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.contentView removeAllSubviews];
	
	
	UIImageView *iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 38, 38)];
	[iconImage sd_setImageWithURL:[NSURL URLWithString:StrRelay(self.item.userinfo[@"avatarPicUrl"]) ] placeholderImage:[UIImage imageNamed:@"defaltplayer"]];
	View_Border_Radius(iconImage, 19, 0, Color_Clear);
	[self.contentView addSubview:iconImage];
	
	
	UILabel*tLab = [self createLabel:StrRelay(self.item.userinfo[@"evalUser"]) color:COLOR_333 font:Font_Size_14];
	[tLab sizeToFit];
	tLab.frame = CGRectMake(62, 10, tLab.width + 1, 38);
	[self.contentView addSubview:tLab];
	
	UILabel*t1Lab = [self createLabel:StrRelay(self.item.userinfo[@"evalLevelDesc"]) color:COLOR_999 font:Font_Size_14];
	[t1Lab sizeToFit];
	t1Lab.frame = CGRectMake(SCREEN_WIDTH - t1Lab.width - 15, 10, t1Lab.width + 1, 38);
	[self.contentView addSubview:t1Lab];
	
	
	CGSize sz = [CommonUtil sizeForFont:StrRelay(self.item.userinfo[@"evalText"]) Font:Font_Size_13 CtrlSize:CGSizeMake(SCREEN_WIDTH - 30, 2000)];
	
	UILabel* infoLabel = [self createLabel:StrRelay(self.item.userinfo[@"evalText"]) color:COLOR_333 font:Font_Size_13];
	infoLabel.numberOfLines = 0;
	infoLabel.frame = CGRectMake(15, 58,SCREEN_WIDTH - 30, sz.height);
	[self.contentView addSubview:infoLabel];
	
    
	float offsetX = 10;
	float offsetY = 10;
	float picBtnWH = (SCREEN_WIDTH - 60)/5;
	NSArray *picArr = self.item.userinfo[@"pics"];
	if (picArr.count > 0) {
		for (int i = 0; i < picArr.count; i++) {
			NSDictionary *dict = picArr[i];
			
			UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, infoLabel.bottom + 10, picBtnWH, picBtnWH)];
			picBtn.layer.borderColor = COLOR_ddd.CGColor;
			picBtn.layer.borderWidth = 0.5;
			picBtn.backgroundColor = [UIColor whiteColor];
			picBtn.tag = i;
			picBtn.userinfo = dict[@"picUrl"];
			[picBtn addTarget:self action:@selector(picBtnPress:) forControlEvents:UIControlEventTouchUpInside];
			[self.contentView addSubview:picBtn];
			
			UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,picBtnWH,picBtnWH)];
			img.userInteractionEnabled = NO;
			[img sd_setImageWithURL:[NSURL URLWithString:StrRelay(dict[@"picUrl"])] placeholderImage:[UIImage imageNamed:@""]];
			[picBtn addSubview:img];
			
			offsetX = picBtn.right + 10;
		}
	}else{
		picBtnWH = 0;
		offsetY = 0;
	}
	

	UILabel*timeLab = [self createLabel:StrRelay(self.item.userinfo[@"stCreateTime"]) color:COLOR_999 font:Font_Size_13];
	[timeLab sizeToFit];
	timeLab.frame = CGRectMake(15, infoLabel.bottom + 10 + picBtnWH + offsetY, timeLab.width + 1, 15);
	[self.contentView addSubview:timeLab];
	
	
    
    self.item.cellHeight = timeLab.bottom + 10;
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.item.cellHeight - 0.5, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)btnClick:(UIButton *)btn{
	FMBlock(self.item.buttonClick,btn.tag,self.item);
}

-(void)picBtnPress:(UIButton *)butn{
	ShowBigPicViewController *vc = [[ShowBigPicViewController alloc]init];
	vc.picUrl = butn.userinfo;
	RootNavPush(vc);
	
}
@end
