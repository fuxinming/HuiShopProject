//
//  FMButton.h
//  OMengMerchant
//
//  Created by jienliang on 15-2-5.
//  Copyright (c) 2015年 jienliang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface FMLabel : UILabel
{
    @private
    VerticalAlignment _verticalAlignment;
}
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) UITapGestureRecognizer *tap;
@property (nonatomic,copy) UILongPressGestureRecognizer *longPress;
@property (nonatomic,copy) void (^onTap)(void);
@property (nonatomic,copy) void (^onLongPress)(UILongPressGestureRecognizer *longPress);
- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic,assign) VerticalAlignment verticalAlignment;

-(void)txtArr:(NSArray *)txtArr colorArr:(NSArray *)colorArr fontArr:(NSArray *)fontArr;
@end

@interface FMButton : UIButton
@property (nonatomic,copy) id userInfo;
@property (nonatomic,weak) id bbbb;
@property (nonatomic,copy) void (^onClick)(void);
- (instancetype)init;
@end

@interface FMBarButtonItem : UIBarButtonItem
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) void (^onClick)(void);
@end

@interface FMLongPressGestureRecognizer : UILongPressGestureRecognizer
@property (nonatomic,copy) id userInfo;
@property (nonatomic,assign) int tag;
@end

@interface FMView : UIView
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) void (^onTap)(void);
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
@end

@interface FMImageView : UIImageView
@property (nonatomic,copy) id userInfo;
@property (nonatomic,copy) void (^onTap)(void);
@property (nonatomic,copy) void (^onTapParam)(UITapGestureRecognizer *sender); /// 点击事件
@property (nonatomic,copy) void (^onImageViewTap)(FMImageView *user);
- (instancetype)init;
- (instancetype)initWithFrame:(CGRect)frame;
@end
