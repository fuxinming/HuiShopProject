//
//  FMSwipeCell.h
//  SwipeCell
//
//  Created by Steven on 15/12/17.
//  Copyright © 2015年 Steven. All rights reserved.
//

#import <RETableViewManager/RETableViewManager.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "UIButton+WebCache.h"
@interface FMBaseItem : RETableViewItem
@property (nonatomic,copy)void (^btnClick)(NSInteger tag);
@property (nonatomic,assign)NSInteger tag;
@end

@interface FMBaseCell : RETableViewCell
@property (nonatomic,readwrite,strong) FMBaseItem *item;
@property (nonatomic,copy)void (^btnClick)(NSInteger tag);
- (UILabel *)createLabel:(NSString *)text color:(UIColor *)color font:(UIFont *)font;
- (UIButton *)createBtn:(NSString *)title  color:(UIColor *)color font:(UIFont *)font tag:(int)tag;
- (UIButton *)createImgBtn:(NSString *)img tag:(int)tag;

-(void)btnClick:(UIButton *)btn;
@end
