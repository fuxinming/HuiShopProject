//
//  BottomSelectView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/16.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "BottomSelectView.h"

@interface BottomSelectView (){
    NSArray *dataArrayOne;
    int defaltSelect;
}
@property (nonatomic,strong)UIPickerView *pickerView;
@end
@implementation BottomSelectView
-(id)initWithArr:(NSArray *)arr{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
    if (self) {
        UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-260, self.width, 260)];
        v.backgroundColor = [UIColor whiteColor];
        [self addSubview:v];
        
        dataArrayOne = [NSArray arrayWithArray:arr];
        defaltSelect = 0;
        UIView *v1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 35)];
        v1.backgroundColor = COLOR_ddd;
        [v addSubview:v1];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0,0, 50, 35)];
        [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        [btn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
        btn.titleLabel.font = Font_Size_14;
        [v addSubview:btn];
        
        UIButton *finish = [[UIButton alloc] initWithFrame:CGRectMake(self.width-60, 0, 50, 35)];
        [finish setTitle:@"确定" forState:UIControlStateNormal];
        [finish setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
        [finish addTarget:self action:@selector(finishBtnPress) forControlEvents:UIControlEventTouchUpInside];
        finish.titleLabel.font = Font_Size_14;
        [v addSubview:finish];
        
        
        self.pickerView = [[UIPickerView alloc] init];
        // 显示选中框
        self.pickerView.showsSelectionIndicator=YES;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.frame = CGRectMake(0, 40, SCREEN_WIDTH,182);
        [v addSubview:self.pickerView];
//        if (dataArrayOne.count > 0) {
//            if (![WJUtil strNilOrEmpty:str1]) {
//                [self.pickerView selectRow:[self getIndexOfArray:dataArrayOne withOcntentStr:str1]   inComponent:0 animated:YES];
//                _resultOne = [dataArrayOne objectAtIndex:[self getIndexOfArray:dataArrayOne withOcntentStr:str1]];
            }else{
                [self.pickerView selectRow:0   inComponent:0 animated:YES];
//                _resultOne = [dataArrayOne objectAtIndex:0];
                
//            }
//        }
        
        
        
        CATransition *animation = [CATransition animation];
        [animation setDuration:0.5];
        [animation setType:kCATransitionReveal];
        [animation setSubtype:kCATransitionFromRight];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.layer addAnimation:animation forKey:@"SwitchToView"];
    }
    return self;
}
-(void)finishBtnPress{
    
    if (self.rebackBlock) {
        self.rebackBlock([dataArrayOne objectAtIndex:defaltSelect], defaltSelect);
    }
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)btnPress{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


// pickerView 列数
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// pickerView 每列个数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [dataArrayOne count];
    
}

// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return pickerView.width;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
   defaltSelect = row;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [dataArrayOne objectAtIndex:row];
    
}

//-(int)getIndexOfArray:(NSArray *)array withOcntentStr:(NSString *)content{
//    int index = 0;
//    for (int i = 0; i < array.count; i ++) {
//        if ([content isEqualToString:array[i]]) {
//            index = i;
//        }
//    }
//    return index;
//}
//
//-(int)getIndexOfDictArray:(NSArray *)array withOcntentStr:(NSString *)content{
//    int index = 0;
//    for (int i = 0; i < array.count; i ++) {
//        if ([content isEqualToString:array[i][@"city"]]) {
//            index = i;
//        }
//    }
//    return index;
//}
@end
