//
//  ColorDefine.h
//  FMBaseOCProject
//
//  Created by q on 2017/10/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#ifndef ColorDefine_h
#define ColorDefine_h

//设置随机颜色
#define Random_Color [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]
//设置颜色和透明度
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define Color_Alpha(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define Color_Clear [UIColor clearColor]

#define COLOR_RED_              UIColorFromRGB(0xe51c23) //红色
#define COLOR_BLUE_             UIColorFromRGB(0x1fa2ee)
#define COLOR_GREEN             UIColorFromRGB(0x66d43f) //171
#define COLOR_333               UIColorFromRGB(0x333333) //51
#define COLOR_666               UIColorFromRGB(0x666666) //102
#define COLOR_999               UIColorFromRGB(0x999999) //153
#define COLOR_ddd               UIColorFromRGB(0xdddddd)
#define COLOR_ccc        UIColorFromRGB(0xcccccc) //197

#define COLOR_YELLOW_           UIColorFromRGB(0xf27a39)//黄色
#define COLOR_BACKGROUND     UIColorFromRGB(0xf5f5f5)//200
#define COLOR_LIGHT_RED         UIColorFromRGB(0xffe5e5)

#define COLOR_STATE_BLUE   RGBCOLOR(102, 84, 242)

#endif /* ColorDefine_h */
