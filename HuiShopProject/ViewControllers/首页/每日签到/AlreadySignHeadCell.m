//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "AlreadySignHeadCell.h"

@implementation AlreadySignHeadItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 226;
    }
    return self;
}

@end

@interface AlreadySignHeadCell()
{
}
@end

@implementation AlreadySignHeadCell
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
	
	UIImageView *bgImage = [[UIImageView alloc]init];
	bgImage.image = [UIImage imageNamed:@"bkg_sign_in"];
	bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 226);
	[self.contentView addSubview:bgImage];
	
	
	UILabel *label1 = [self createLabel:@"已连续签到" color:COLOR_333 font:Font_Size_14];
	label1.frame = CGRectMake(0, 40, SCREEN_WIDTH, 22);
	label1.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:label1];
	
	UIImageView *kImage = [[UIImageView alloc]init];
	kImage.image = [UIImage imageNamed:@"bkg_day"];
	kImage.frame = CGRectMake((SCREEN_WIDTH - 70)/2, label1.bottom + 5, 70, 60);
	[self.contentView addSubview:kImage];
	
	
	UILabel *label2 = [self createLabel:[NSString stringWithFormat:@"%@天",StrRelay(self.item.userinfo[@"seriesDay"])] color:COLOR_333 font:Font_Size_16];
	label2.frame = CGRectMake(0, 25, 70, 22);
	label2.textAlignment = NSTextAlignmentCenter;
	[kImage addSubview:label2];
	
	NSArray *arr = self.item.userinfo[@"settings"];
	NSDictionary *dict;
	if (arr.count > 3) {
		dict = [arr objectAtIndex:2];
	}
    UILabel *titleLabel = [self createLabel:[NSString stringWithFormat:@"明日签到可领%@金币",StrRelay(dict[@"settingsValue"])] color:COLOR_333 font:Font_Size_16];
    titleLabel.frame = CGRectMake(0, kImage.bottom + 20, SCREEN_WIDTH, 22);
	titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    UILabel *t1Label = [self createLabel:@"连续签到有更多惊喜" color:COLOR_333 font:Font_Size_14];
	[t1Label sizeToFit];
    t1Label.frame = CGRectMake((SCREEN_WIDTH - t1Label.width)/2,titleLabel.bottom + 15, t1Label.width, 22);
    [self.contentView addSubview:t1Label];
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
