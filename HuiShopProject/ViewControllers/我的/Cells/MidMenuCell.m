//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "MidMenuCell.h"

@implementation MidMenuItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 69;
    
    }
    return self;
}

@end

@interface MidMenuCell()
{
}
@end

@implementation MidMenuCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
  
    UIButton *settBtn1 = [self createImgBtn:@"" tag:100];
    settBtn1.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 60);
    [self.contentView addSubview:settBtn1];
    
    UIButton *settBtn2 = [self createImgBtn:@"" tag:100];
    settBtn2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 60);
    [self.contentView addSubview:settBtn2];

    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.contentView removeAllSubviews];
    
    int count = (int)self.item.titleArr.count;
    
    float width = SCREEN_WIDTH/count;
    float leftSpace = (width - 24)/2;
    for (int i=0; i < count; i++) {
        NSDictionary *dict = [self.item.titleArr objectAtIndex:i];
        
        UIImageView *tImage = [[UIImageView alloc]initWithFrame:CGRectMake(leftSpace + width*i, 14, 24, 24)];
        tImage.image = [UIImage imageNamed:dict[@"image"]];
        [self.contentView addSubview:tImage];
        
        UILabel *lab1 = [self createLabel:dict[@"title"] color:COLOR_333 font:Font_Size_13];
        lab1.frame = CGRectMake(width*i, tImage.bottom + 6, width, 18);
        lab1.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:lab1];
        
		
		
		for (int j = 0; j < self.item.countArr.count; j++) {
			NSDictionary *dict = self.item.countArr[j];
			NSInteger stat = IntegerRelay(dict[@"state"]);
			NSInteger cnt = IntegerRelay(dict[@"cnt"]);
			
			if (i == 0 && stat == 1 && cnt> 0) {
				[self addCirlcleLabe:[NSString stringWithFormat:@"%ld",(long)cnt] andImage:tImage];
			}
			if (i == 1 && stat == 2 && cnt> 0) {
				[self addCirlcleLabe:[NSString stringWithFormat:@"%ld",(long)cnt]andImage:tImage];
			}
			if (i == 2 && stat == 4 && cnt> 0) {
				[self addCirlcleLabe:[NSString stringWithFormat:@"%ld",(long)cnt]andImage:tImage];
			}
			if (i == 3 && stat == 5 && cnt> 0) {
				[self addCirlcleLabe:[NSString stringWithFormat:@"%ld",(long)cnt]andImage:tImage];
			}
			if (i == 4 && stat == 10 && cnt> 0) {
				[self addCirlcleLabe:[NSString stringWithFormat:@"%ld",(long)cnt]andImage:tImage];
			}
			if (i == 5 && stat == 11 && cnt> 0) {
				[self addCirlcleLabe:[NSString stringWithFormat:@"%ld",(long)cnt]andImage:tImage];
			}
		}
		
		UIButton *settBtn1 = [self createImgBtn:@"" tag:100+i];
		settBtn1.frame = CGRectMake(width*i, 0, width, 69);
		[self.contentView addSubview:settBtn1];
		
    }
}


-(void)addCirlcleLabe:(NSString *)str andImage:(UIImageView *)tImage {
	UILabel *circleLabel = [[UILabel alloc]initWithFrame:CGRectMake(tImage.right- 5, tImage.top-2, 14, 14)];
	circleLabel.font = Font_Size_10;
	circleLabel.text = str;
	circleLabel.textColor = COLOR_RED_;
	circleLabel.textAlignment = NSTextAlignmentCenter;
	View_Border_Radius(circleLabel, 7, 1, COLOR_RED_);
	[self.contentView addSubview:circleLabel];
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
