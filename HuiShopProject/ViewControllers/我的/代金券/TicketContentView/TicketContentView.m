//
//  CXMatchContentView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "TicketContentView.h"
#import "OrderInfoCell.h"
#import "EmptyDataCell.h"
#import "TicketInfoCell.h"
@implementation TicketContentView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        self.formManager[@"OrderInfoItem"] = @"OrderInfoCell";
        self.formManager[@"EmptyDataItem"] = @"EmptyDataCell";
		self.formManager[@"TicketInfoItem"] = @"TicketInfoCell";
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self initForm];
}

- (void)initForm {
    WS(bself);
	if(self.myArr1.count == 0){
		[self initEmptyForm:self.formTable.height andType:1];
		return;
	}
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection sectionWithHeaderTitle:@""];
	for (int i = 0; i < self.myArr1.count; i ++ ) {
		NSDictionary *dict = [self.myArr1 objectAtIndex:i];
		TicketInfoItem *item0 = [[TicketInfoItem alloc]init];
		item0.userinfo = dict;
		[section0 addItem:item0];
	}
	[sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}



@end
