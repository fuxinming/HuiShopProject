//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "SignWeekDayCell.h"

@implementation SignWeekDayItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 82;
    }
    return self;
}

@end

@interface SignWeekDayCell()
{
}
@end

@implementation SignWeekDayCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.contentView removeAllSubviews];
	
	float ofx = (SCREEN_WIDTH - 32*7)/8;
	NSArray *arr = self.item.userinfo;
	for(int i = 0;i < arr.count;i++){
		NSDictionary *dict = [arr objectAtIndex:i];
		
		UILabel *titleLabel = [self createLabel:StrRelay(dict[@"settingsValue"]) color:COLOR_333 font:Font_Size_14];
		titleLabel.frame = CGRectMake(ofx + (ofx + 32)*i, 25, 32, 32);
		titleLabel.textAlignment = NSTextAlignmentCenter;
		View_Border_Radius(titleLabel, 16, 1, COLOR_ddd);
		if (i == 1) {
			titleLabel.backgroundColor = [UIColor whiteColor];
			View_Border_Radius(titleLabel, 16, 1, COLOR_999);
			if (self.item.isSign) {
				titleLabel.backgroundColor = COLOR_RED_;
			}
		}
		[self.contentView addSubview:titleLabel];
	
		NSDate * date = [NSDate date];//当前时间
		NSDate *nextDay = [NSDate dateWithTimeInterval:24*60*60*(i-1) sinceDate:date];
		NSString *dateToMDString = [DateUtil dateToMDString:nextDay];
		if (i == 1) {
			dateToMDString = @"今日";
		}
		if (i == 2) {
			dateToMDString = @"明日";
		}
		
		UILabel *t1Label = [self createLabel:dateToMDString color:COLOR_999 font:Font_Size_12];
		[t1Label sizeToFit];
		t1Label.frame = CGRectMake(0,titleLabel.bottom + 5, t1Label.width, 12);
		t1Label.centerX = titleLabel.centerX;
		[self.contentView addSubview:t1Label];
		
	}
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
@end
