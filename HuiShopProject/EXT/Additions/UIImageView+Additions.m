//
//  UIImageView+Additions.m
//  WJLibraryT
//
//  Created by jienliang on 2017/6/6.
//  Copyright © 2017年 jienliang. All rights reserved.
//

#import "UIImageView+Additions.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (WJLibraryT)
- (void)setWebImageWithUrl:(NSString *)url placeHolder:(UIImage *)placeImg {
    [self sd_setImageWithURL:[NSURL URLWithString:[CommonUtil strRelay:url]] placeholderImage:placeImg];
}
@end

