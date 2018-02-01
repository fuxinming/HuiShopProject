//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "AllEvalTagListCell.h"


@implementation AllEvalTagListItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 68;
    }
    return self;
}
@end

@interface AllEvalTagListCell ()
{
    CGRect previousFrame;
    int totalHeight ;
    NSMutableArray*_tagArr;
	int offNums;
}
@end
@implementation AllEvalTagListCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    _tagArr=[[NSMutableArray alloc]init];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    WS(bself);
    [self.contentView removeAllSubviews];
	
	UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0,10, SCREEN_WIDTH, 50)];
	lineView2.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:lineView2];
	totalHeight = 0;
	offNums = 0;
    previousFrame = CGRectZero;
    [_tagArr addObjectsFromArray:self.item.tagListArray];
    [self.item.tagListArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
		NSString *str = [NSString stringWithFormat:@"%@(%@)",dict[@"tag"],dict[@"total"]];
		NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:15]};
		CGSize Size_str=[[NSString stringWithFormat:@"%@",str] sizeWithAttributes:attrs];
		Size_str.width = ceil(Size_str.width);
		Size_str.height = ceil(Size_str.height);
		Size_str.width += 4;
		Size_str.height += 4;
		
		UILabel *tagLabel = [self createLabel:@"" color:COLOR_333 font:Font_Size_15];
		tagLabel.frame=CGRectZero;
		tagLabel.backgroundColor=COLOR_LIGHT_RED;
		tagLabel.textAlignment = NSTextAlignmentCenter;
		
		CGRect newRect = CGRectZero;
		
		if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + 18 + 18*offNums > lineView2.width) {
			
			newRect.origin = CGPointMake(18, previousFrame.origin.y + Size_str.height + 10);
			totalHeight +=Size_str.height + 10;
			offNums = 0;
		}
		else {
			newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + 18, previousFrame.origin.y);
			offNums+=1;
		}
		newRect.size = Size_str;
		[tagLabel.layer setCornerRadius:(newRect.size.height/2)];
		[tagLabel.layer setMasksToBounds:YES];
		[tagLabel setFrame:newRect];
		previousFrame=tagLabel.frame;
		[lineView2 addSubview:tagLabel];
		
		NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:StrRelay(dict[@"tag"]).color(COLOR_333).font(Font_Size_14)];
		str1.append(@"(".color(COLOR_333).font(Font_Size_14));
		str1.append([NSString stringWithFormat:@"%@",StrRelay(dict[@"total"])].color(COLOR_RED_).font(Font_Size_14));
		str1.append(@")".color(COLOR_333).font(Font_Size_14));
		tagLabel.attributedText = str1;
		
		[self setHight:lineView2 andHight:totalHeight+Size_str.height + 10];
		
    }];
	
		self.item.cellHeight = lineView2.bottom + 10;
}

- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    view.height = hight;
}

-(void)tagBtnClick:(UIButton *)btn{
    if (self.item.tagBtnClick) {
        self.item.tagBtnClick(btn.titleLabel.text);
    }
}
@end
