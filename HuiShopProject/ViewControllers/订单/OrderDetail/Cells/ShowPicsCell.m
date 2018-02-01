//
//  WSOrderDemandCell.m
//  OMengMerchant
//
//  Created by q on 2016/12/15.
//  Copyright © 2016年 shanjin. All rights reserved.
//

#import "ShowPicsCell.h"
#import "ShowBigPicViewController.h"
@implementation ShowPicsItem

- (instancetype)init {
    if (self = [super init]) {
        self.picBtnWH = (SCREEN_WIDTH - 60)/5;
        self.cellHeight =   20 + self.picBtnWH;
    }
    return self;
}


@end


@interface ShowPicsCell() {
    UIView *picView;
    CGFloat picBtnWH;
}
@end

@implementation ShowPicsCell
- (void)cellDidLoad {
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    picBtnWH = (SCREEN_WIDTH - 60)/5;
	
    
    picView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, picBtnWH)];
    picView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:picView];
    
}

- (void)cellWillAppear {
    [super cellWillAppear];
    [self createPicView];
}

- (void)createPicView {
    [picView removeAllSubviews];
    
    float offsetX = 10;
    for (int i = 0; i < self.item.arrayPics.count; i++) {
        NSString *file = self.item.arrayPics[i];
		
        UIButton *picBtn = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, 0, self.item.picBtnWH, self.item.picBtnWH)];
        picBtn.layer.borderColor = COLOR_ddd.CGColor;
        picBtn.layer.borderWidth = 0.5;
        picBtn.backgroundColor = [UIColor whiteColor];
        picBtn.tag = i;
		picBtn.userinfo = file;
        [picBtn addTarget:self action:@selector(picBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [picView addSubview:picBtn];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.item.picBtnWH, self.item.picBtnWH)];
		img.userInteractionEnabled = NO;
        [img sd_setImageWithURL:[NSURL URLWithString:StrRelay(file)] placeholderImage:[UIImage imageNamed:@""]];
        [picBtn addSubview:img];
        
        offsetX = picBtn.right + 10;
    }
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

-(void)picBtnPress:(UIButton *)butn{
	ShowBigPicViewController *vc = [[ShowBigPicViewController alloc]init];
	vc.picUrl = butn.userinfo;
	RootNavPush(vc);
	
}

@end
