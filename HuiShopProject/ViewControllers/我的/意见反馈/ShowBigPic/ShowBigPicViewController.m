//
//  ShowBigPicViewController.m
//  CheBaiTong
//
//  Created by shanjin on 15/6/30.
//  Copyright (c) 2015年 shanjin. All rights reserved.
//

#import "ShowBigPicViewController.h"
#import "FMFile.h"
static BOOL SDImagedownloderOldShouldDecompressImages = YES;
@interface ShowBigPicViewController ()<UIScrollViewDelegate>
{
    UIButton *img;
    NSMutableArray *myArray;
}

@end

@implementation ShowBigPicViewController

- (void)loadView {
    [super loadView];
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    SDImagedownloderOldShouldDecompressImages = downloder.shouldDecompressImages;
    downloder.shouldDecompressImages = NO;
}

- (void)dealloc {
    SDWebImageDownloader *downloder = [SDWebImageDownloader sharedDownloader];
    downloder.shouldDecompressImages = SDImagedownloderOldShouldDecompressImages;
}

- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
    self.navBar.title = @"查看大图";
    [self initView1];
}

-(void)initView1 {
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
    [[SDImageCache sharedImageCache] clearMemory];
    
    img = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    img.backgroundColor = COLOR_ddd;
    [img addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:img];

    WS(bself);
	if (self.picUrl) {
		UIImageView * imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
		[imgView sd_setImageWithURL:[NSURL URLWithString:self.picUrl] placeholderImage:[UIImage imageNamed:@""] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
			if (image) {
				[bself reSetImageSize:image.size.height/image.size.width withImage:imgView];
			}
		}];
		
		[img addSubview:imgView];
	}
		

}


- (void)btnPress{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.4];
    [animation setType:kCATransitionFade];
    [animation setSubtype: kCATransitionFade];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [self.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)reSetImageSize:(CGFloat)factor withImage:(UIImageView *)image{
    if (factor > SCREEN_HEIGHT/SCREEN_WIDTH) {
        image.frame = CGRectMake((SCREEN_WIDTH - SCREEN_HEIGHT/factor)/2 ,0, SCREEN_HEIGHT/factor, SCREEN_HEIGHT);
    }else{
        image.frame = CGRectMake(0, (SCREEN_HEIGHT- SCREEN_WIDTH*factor)/2, SCREEN_WIDTH, SCREEN_WIDTH*factor);
    }
    
}



@end
