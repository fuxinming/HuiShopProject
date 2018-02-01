//
//  FMButton.m
//  OMengMerchant
//
//  Created by jienliang on 15-2-5.
//  Copyright (c) 2015年 jienliang. All rights reserved.
//

#import "FMButton.h"

@implementation FMLabel
@synthesize verticalAlignment = verticalAlignment_;
- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}
- (void)tapGesture
{
    if (self.onTap) {
        self.onTap();
    }
}
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.verticalAlignment = VerticalAlignmentMiddle;
    }
    return self;
}

- (void)setVerticalAlignment:(VerticalAlignment)verticalAlignment {
    verticalAlignment_ = verticalAlignment;
    [self setNeedsDisplay];
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect textRect = [super textRectForBounds:bounds limitedToNumberOfLines:numberOfLines];
    switch (self.verticalAlignment) {
        case VerticalAlignmentTop:
            textRect.origin.y = bounds.origin.y;
            break;
        case VerticalAlignmentBottom:
            textRect.origin.y = bounds.origin.y + bounds.size.height - textRect.size.height;
            break;
        case VerticalAlignmentMiddle:
            // Fall through.
        default:
            textRect.origin.y = bounds.origin.y + (bounds.size.height - textRect.size.height) / 2.0;
    }
    return textRect;
}

-(void)drawTextInRect:(CGRect)requestedRect {
    CGRect actualRect = [self textRectForBounds:requestedRect limitedToNumberOfLines:self.numberOfLines];
    [super drawTextInRect:actualRect];
}

- (void)dealloc
{
    [self removeGestureRecognizer:_tap];
}

-(void)txtArr:(NSArray *)txtArr colorArr:(NSArray *)colorArr fontArr:(NSArray *)fontArr {
    
    NSInteger okCount = 0;
    okCount = txtArr.count < colorArr.count ? txtArr.count : colorArr.count;
    okCount = okCount < fontArr.count ? okCount : fontArr.count;
    
    NSMutableString *txt = [NSMutableString string];
    for (NSString *str in txtArr) {
        [txt appendString:str];
    }
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:txt];
    NSInteger startLoc = 0;
    for (int i = 0; i < okCount; i++) {
        [str addAttributes:@{NSForegroundColorAttributeName:colorArr[i], NSFontAttributeName:[UIFont systemFontOfSize:[fontArr[i] integerValue]]} range:NSMakeRange(startLoc, [txtArr[i] length])];
        startLoc += [txtArr[i] length];
    }
    self.attributedText = str;
}
@end

@implementation FMButton

- (instancetype)init
{
    if (self = [super init]) {
    }
    return self;
}

@end

@implementation FMBarButtonItem
@end

@implementation FMLongPressGestureRecognizer
@end

@interface FMView ()
{
    UITapGestureRecognizer *_tap;
}
@end

@implementation FMView
- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}

- (void)tapGesture
{
    if (self.onTap) {
        self.onTap();
    }
}

- (void)dealloc
{
    [self removeGestureRecognizer:_tap];
}
@end

@interface FMImageView ()
{
    UITapGestureRecognizer *_tap;
}
@end

@implementation FMImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [self addGestureRecognizer:_tap];
    }
    
    return self;
}

- (void)tapGesture:(UITapGestureRecognizer*)tap
{
    if (self.onTap) {
        self.onTap();
    }
    
    if (self.onTapParam) {
        self.onTapParam(tap);
    }
    
    if (self.onImageViewTap) {
        self.onImageViewTap(self);
    }
}

- (void)dealloc
{
    [self removeGestureRecognizer:_tap];
}
@end

