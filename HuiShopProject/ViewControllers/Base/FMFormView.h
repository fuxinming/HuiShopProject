//
//  FMFormView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "MBProgressHUD.h"

//球赛类型


@interface FMFormView : UIView <RETableViewManagerDelegate>
@property (nonatomic, strong) UITableView *formTable;
@property (nonatomic, strong) RETableViewManager *formManager;

- (void)showLoading;
- (void)hiddenLoading;
- (void)addHeader;
-(void)getData;
- (void)beginRefrash;
- (void)endRefrash;

-(void)initEmptyForm:(float)height andType:(int)type;;
@end
