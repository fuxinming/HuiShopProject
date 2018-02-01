//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "PingTagListCell.h"


@implementation PingTagListItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 68;
		self.evalListArray = [NSMutableArray array];
    }
    return self;
}
@end

@interface PingTagListCell ()
{
    CGRect previousFrame;
	UIView *lineView2;
    int totalHeight ;
	int offNums;
}
@end
@implementation PingTagListCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
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

	
	lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0,10, SCREEN_WIDTH, 50)];
	lineView2.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:lineView2];
	totalHeight = 0;
	offNums = 0;
    previousFrame = CGRectZero;
    [self.item.tagListArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL *stop) {
		NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
		CGSize Size_str=[[NSString stringWithFormat:@"%@",dict[@"tag"]] sizeWithAttributes:attrs];
		Size_str.width = ceil(Size_str.width);
		Size_str.height = ceil(Size_str.height);
		Size_str.width += 4;
		Size_str.height += 4;
		
		UIButton *btn = [bself createBtn:dict[@"tag"] color:COLOR_333 font:Font_Size_14 tag:100+idx];
		btn.userinfo = dict;
		btn.frame=CGRectZero;
		[btn setTitleColor:COLOR_RED_ forState:UIControlStateSelected];
		btn.backgroundColor=COLOR_BACKGROUND;
		[btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
		CGRect newRect = CGRectZero;
		
		if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + 18 + 18*offNums > lineView2.width) {
			
			newRect.origin = CGPointMake(18, previousFrame.origin.y + Size_str.height + 10);
			totalHeight +=Size_str.height + 10;
			offNums = 0;
		}else {
			newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + 18, previousFrame.origin.y);
			offNums+=1;
		}
		newRect.size = Size_str;
		[btn.layer setCornerRadius:(2)];
		[btn.layer setMasksToBounds:YES];
		[btn setFrame:newRect];
		previousFrame=btn.frame;
		[lineView2 addSubview:btn];
		
		[self setHight:lineView2 andHight:totalHeight+Size_str.height + 10];
		
		for (int i = 0; i < self.item.evalListArray.count; i++) {
			if ([StrRelay(dict[@"id"]) isEqualToString:StrRelay([ self.item.evalListArray objectAtIndex:i])]) {
				btn.selected  = YES;
				break;
			}
		}
		
		
    }];
	self.item.cellHeight = lineView2.bottom + 10;
}

- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    view.height = hight;
}

-(void)tagBtnClick:(UIButton *)btn{
	btn.selected = !btn.selected;
	[self.item.evalListArray removeAllObjects];
	for (UIView *view in lineView2.subviews) {
		if ([view isKindOfClass:[UIButton class]]) {
			UIButton *button = (UIButton *)view;
			if (button.selected) {
				[self.item.evalListArray addObject:StrRelay(button.userinfo[@"id"])];
			}
		}
	}
}
@end
