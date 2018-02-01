//
//  WSOrderDemandCell.m
//  OMengMerchant
//
//  Created by q on 2016/12/15.
//  Copyright © 2016年 shanjin. All rights reserved.
//

#import "SelectPicCell.h"
#import "WSImageUtils.h"

@implementation SelectPicItem

- (instancetype)init {
    if (self = [super init]) {
        self.arrayPics = [[NSMutableArray alloc] init];
        self.picBtnWH = (SCREEN_WIDTH - 60)/5;
        self.cellHeight =   20 + self.picBtnWH;
    }
    return self;
}


@end


@interface SelectPicCell() {
    UIView *picView;
    CGFloat picBtnWH;
}
@property(nonatomic,strong) UIButton *btnAddMore;
@end

@implementation SelectPicCell
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
//        [picBtn addTarget:self action:@selector(picBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [picView addSubview:picBtn];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.item.picBtnWH, self.item.picBtnWH)];
        [img setImage:[UIImage imageWithContentsOfFile:file]];
        [picBtn addSubview:img];
        
        UIButton *delBtn = [[UIButton alloc] initWithFrame:CGRectMake(img.width - 20, 0, 20, 20)];
        [delBtn setBackgroundImage:[UIImage imageNamed:@"ordersendcha"] forState:UIControlStateNormal];
        delBtn.tag = i;
        [delBtn addTarget:self action:@selector(delectPic1:) forControlEvents:UIControlEventTouchUpInside];
        [picBtn addSubview:delBtn];
        
        offsetX = picBtn.right + 10;
    }
    
    if (self.item.arrayPics.count <= 4) {
        UIButton *btnAddPic = [[UIButton alloc] initWithFrame:CGRectMake(offsetX, 0, self.item.picBtnWH, self.item.picBtnWH)];
        btnAddPic.backgroundColor = [UIColor clearColor];
        [btnAddPic addTarget:self action:@selector(addPic:) forControlEvents:UIControlEventTouchUpInside];
        [btnAddPic setBackgroundImage:[UIImage imageNamed:@"icon_addpic_unfocused"] forState:UIControlStateNormal];
        [btnAddPic setBackgroundImage:[UIImage imageNamed:@"icon_addpic_unfocused"] forState:UIControlStateHighlighted];
        [picView addSubview:btnAddPic];
    }
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}


- (void)delectPic1:(UIButton *)longGusture {
    [self.item.arrayPics removeObjectAtIndex:longGusture.tag];
    [self.item reloadRowWithAnimation:UITableViewRowAnimationNone];
}



#pragma mark-添加图片
- (void)addPic:(UIButton *)btn {
    [self.parentTableView endEditing:YES];
    WS(bself);
    if ([self.item.arrayPics count]==5) {
       Toast(@"最多可添加5张图片");
        return;
    }
    UIViewController *rootV = [((UINavigationController *)[CommonUtil appDelegate].window.rootViewController).viewControllers lastObject];
    
    [WSImageUtils sharedInstance].canEditPic = NO;
    [WSImageUtils sharedInstance].canMultiSelect = YES;
    [WSImageUtils sharedInstance].canSelectCount = (int)(5-[self.item.arrayPics count]);
	[[WSImageUtils sharedInstance] showAlertSheet:rootV];
    [WSImageUtils sharedInstance].didFinishPickingAssets = ^(NSArray *assets){
        for (NSString *imagePath in assets) {
            [bself.item.arrayPics addObject:imagePath];
            [bself.item reloadRowWithAnimation:UITableViewRowAnimationFade];
        }
    };
    [WSImageUtils sharedInstance].didFinishCamera = ^(NSString *picPath){
        [bself.item.arrayPics addObject:picPath];
        [bself.item reloadRowWithAnimation:UITableViewRowAnimationFade];
    };
}
@end
