//
//  RestoreMenuView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/9.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "RestoreMenuView.h"
#import "TitleSelectCell.h"
@implementation RestoreMenuView

- (id)initWithFrame:(CGRect)frame withArr:(NSArray *)arr1 {
    self = [super initWithFrame:frame];
    if (self) {
        self.arr1 = arr1;
        self.formManager[@"TitleSelectItem"] = @"TitleSelectCell";
        self.formTable.bounces = NO;
        [self initForm];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)initForm {
    WS(bself);

    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection sectionWithHeaderTitle:@""];
    
    for(int i = 0;i < self.arr1.count;i++){
        TitleSelectItem *it = [[TitleSelectItem alloc]init];
        it.t1 = self.arr1[i];
        it.tag = i;
        it.selectionHandler = ^(TitleSelectItem * item) {
			if (bself.selectItem) {
				bself.selectItem(1, item.tag, item.t1);
			}
				
        };
        [section0 addItem:it];
    }
    
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

-(void)resetForm{
    WS(bself);
    
    
    CGPoint startPoint = CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2);
    self.layer.position = startPoint;
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.layer.position = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
                     } completion:^(BOOL finished) {
                         if (finished){
                         }
                     }];
}

- (void)initForm2 {
    WS(bself);
    self.top = (SCREEN_HEIGHT - self.arr2.count * 60)/2;
    self.height = self.arr2.count * 60;
    self.formTable.frame = CGRectMake(0, 0, self.width, self.height);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection sectionWithHeaderTitle:@""];
    
    for(int i = 0;i < self.arr2.count;i++){
        TitleSelectItem *it = [[TitleSelectItem alloc]init];
        it.t1 = self.arr2[i];
        it.tag = i;
        it.selectionHandler = ^(TitleSelectItem * item) {
			if (bself.selectItem) {
				bself.selectItem(2, item.tag, item.t1);
			}
        };
        [section0 addItem:it];
    }
    
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
    [self resetForm ];
}
@end
