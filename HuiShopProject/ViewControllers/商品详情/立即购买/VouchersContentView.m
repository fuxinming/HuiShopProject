//
//  CXMatchContentView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "VouchersContentView.h"

#import "VouchersSelectCell.h"


@interface VouchersContentView (){
	RETableViewSection *section0;
	

}

@end


@implementation VouchersContentView

- (id)initWithFrame:(CGRect)frame withUserInfo:(id)myInfo andDealtSel:(NSDictionary *)selInfo andLimit:(double)price{
    self = [super initWithFrame:frame];
    if (self) {
		self.userinfo = myInfo;
		self.selectInfo = selInfo;
		self.price = price;
        self.formManager[@"VouchersSelectItem"] = @"VouchersSelectCell";
        
        self.backgroundColor = [UIColor whiteColor];
		[self initForm];
		
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		btn.backgroundColor = COLOR_RED_;
		[btn setTitle:@"完成" forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[btn.titleLabel setFont:Font_Size_15];
		btn.tag = 100;
		btn.frame = CGRectMake(0, self.height - 45, SCREEN_WIDTH, 45);
		[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
    }
    return self;
}


- (void)initForm {
	WS(bself);
	
	self.formTable.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.height - 45);
	NSMutableArray *sectionArray = [NSMutableArray array];
	section0 = [RETableViewSection section];
	
	NSArray *arr = self.userinfo;
	for (int i = 0; i < arr.count; i++) {
		NSDictionary *dict = [arr objectAtIndex:i];
		VouchersSelectItem *item1 =[[VouchersSelectItem alloc]init];
		item1.userinfo = dict;
		item1.price = self.price;
		item1.btnSelect = ^(VouchersSelectItem * item) {
			bself.selectInfo = item.userinfo;
			[bself initForm];
		};
		if([StrRelay(dict[@"id"]) isEqualToString:StrRelay(bself.selectInfo[@"id"])]){
			item1.isdeSelect = YES;
		}else{
			item1.isdeSelect = NO;
		}
		[section0 addItem:item1];
	}
	[sectionArray addObject:section0];
	[self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
	[self.formTable reloadData];
	
}

-(void)btnClick:(UIButton*)btn{
	if (!self.selectInfo) {
		Toast(@"请选择代金券");
		return;
	}
	if (self.btnSelect) {
		self.btnSelect(self.selectInfo);
	}
}

@end
