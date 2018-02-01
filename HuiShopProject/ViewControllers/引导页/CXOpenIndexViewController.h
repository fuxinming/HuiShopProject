//
//  WJHelpViewController.h
//  阳光好车 SunnyCar
//
//  Created by jienliang on 2017/6/15.
//  Copyright © 2017年 jienliang. All rights reserved.
//


#import "BaseViewController.h"
@interface CXOpenIndexViewController : BaseViewController<UIScrollViewDelegate>
/**
 *	@brief	滚动视图.
 */
@property (nonatomic, strong) UIScrollView *helpScrollView;
@end
