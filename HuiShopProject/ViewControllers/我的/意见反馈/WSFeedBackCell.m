//
//  WSFormTextCell.m
//  WiseSeller
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

#import "WSFeedBackCell.h"
#import "REPlaceholderTextView.h"


@implementation WSFeedBackItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 350;
        self.maxLenth = 150;
    }
    return self;
}

@end

@interface WSFeedBackCell()<UITextViewDelegate, UINavigationControllerDelegate>
{
    REPlaceholderTextView *remarkView;
    UILabel *jishuLabel;
}
@end

@implementation WSFeedBackCell
- (void)cellDidLoad
{
    [super cellDidLoad];
    
    remarkView = [[REPlaceholderTextView alloc] initWithFrame:CGRectMake(15, 7, SCREEN_WIDTH-30, 320)];
    remarkView.font = [UIFont systemFontOfSize:16];
    remarkView.placeholder = @"";
    remarkView.delegate = self;
    remarkView.inputAccessoryView = self.actionBar;
    remarkView.autocapitalizationType = UITextAutocapitalizationTypeNone;
	View_Border_Radius(remarkView, 5, 1, COLOR_ddd);
    [self.contentView addSubview:remarkView];
    
    jishuLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, remarkView.bottom + 5,SCREEN_WIDTH-30, 20)];
    jishuLabel.textColor = COLOR_999;
    jishuLabel.textAlignment = NSTextAlignmentRight;
    jishuLabel.font = Font_Size_14;
    jishuLabel.text = @"150/150";
    jishuLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:jishuLabel];
	
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    remarkView.text = [CommonUtil strRelay:self.item.remarks];
	remarkView.placeholder = [CommonUtil strRelay:self.item.placeH];
}






#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([[[UITextInputMode currentInputMode]primaryLanguage] isEqualToString:@"emoji"]) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView{
    [AppUtil checkTextView:textView maxLen:150 countLab:jishuLabel];
    self.item.remarks = textView.text;
}

@end
