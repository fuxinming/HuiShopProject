//
//  FMNavBar.h
//  FMBaseProject
//
//  Created by shanjin on 2016/10/10.
//  Copyright © 2016年 付新明. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *	@brief	导航按钮数据对象.
 */
@interface FMBarItem : NSObject{
}
@property (nonatomic, assign) int itemStyle;//样式：0文字/1图片/2文字+图片(样式指定)
@property (nonatomic, strong) NSString *itemTitle;//0文字 1图片名称
@property (nonatomic, copy) NSString *itemImg; //2文字+图片(样式指定)
@property (nonatomic,assign) CGSize imgSize;
@property (nonatomic, copy) UIColor *titleColor;//文字颜色

@property (copy, readwrite, nonatomic) void (^onClick)(id item);

+ (id)itemWith:(NSString *)title withClick:(void (^)(id it))clickEvent;
+ (id)itemImg:(NSString *)img withClick:(void (^)(id it))clickEvent;\

// 指定界面使用
+ (id)itemHomeImg:(NSString *)img withClick:(void (^)(id it))clickEvent;
+ (id)itemHomeImg:(NSString *)img homeWith:(NSString *)title withClick:(void (^)(id it))clickEvent;
+ (id)itemHomeMesImg:(NSString *)img withClick:(void (^)(id it))clickEvent;
@end

@interface FMNavBar : UIView
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic, copy) NSArray *rightItemList;
@property (nonatomic, copy) NSArray *leftItemList;
@property (nonatomic, copy) UIImageView *lineImg;
@end
