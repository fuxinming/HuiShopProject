//
//  WSImageUtil.m
//  ImageCropView
//
//  Created by jienliang on 16/1/25.
//
//

#import "WSImageUtils.h"
#import<AVFoundation/AVCaptureDevice.h>
#import<AVFoundation/AVMediaFormat.h>

@interface WSImageUtils ()
- (NSString *)fileTempDir:(NSString *)path;
- (NSString *)strGUID;
@end


@implementation WSImageUtils
static WSImageUtils *sharedSingleton = nil;

+ (WSImageUtils *)sharedInstance {
    if (sharedSingleton == nil) {
        sharedSingleton = [[WSImageUtils alloc] init];
        sharedSingleton.canEditPic = NO;
        sharedSingleton.canMultiSelect = NO;
    }
    return sharedSingleton;
}

+ (void)destroyDealloc
{
    sharedSingleton = nil;
}

- (void)showAlertSheet:(UIViewController *)parentView{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选取", @"拍照", nil];
    actionSheet.tag = 10023;
    self.parentViewController = parentView;
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:parentView.view];
}

-(void)showAlumSheet:(UIViewController *)parentView{
    self.parentViewController = parentView;
    if (self.canMultiSelect==YES) { //多张
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.canSelectCount delegate:self];
        imagePickerVc.allowPickingVideo = NO;
        imagePickerVc.allowPickingOriginalPhoto = NO;
        [self.parentViewController.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
    } else { //单张
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = self.canEditPic;
        [self.parentViewController presentViewController:imagePickerController animated:YES completion:nil];
    }
    
}
#pragma mark - UIActionSheetDelegate
// 定义菜单处理事件
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex==0) {// 从相册中选取
        if (self.canMultiSelect==YES) { //多张
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:self.canSelectCount delegate:self];
            imagePickerVc.allowPickingVideo = NO;
            imagePickerVc.allowPickingOriginalPhoto = NO;
            [self.parentViewController.navigationController presentViewController:imagePickerVc animated:YES completion:nil];
        } else { //单张
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.allowsEditing = self.canEditPic;
            [self.parentViewController presentViewController:imagePickerController animated:YES completion:nil];
        }
    }
    else if(buttonIndex==1){// 拍照
        [self takePic];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            NSURL*uri =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication] openURL:uri];
        }
    }
}

- (void)takePic {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusAuthorized){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            [self performSelector:@selector(showcamera) withObject:nil afterDelay:0.1];
        }
    } else {
        WS(weakSelf);
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (!granted) {
                [weakSelf performSelectorOnMainThread:@selector(onHandleUserDeniedAlert) withObject:nil waitUntilDone:NO];
            }
        }];
    }
}

- (void)showcamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [imagePicker setDelegate:self];
    if (self.canEditPic==YES) {
        imagePicker.allowsEditing = YES;
    }
    [self.parentViewController presentViewController:imagePicker animated:YES completion:nil];
}

- (void)onHandleUserDeniedAlert
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    CFShow(CFBridgingRetain(infoDictionary));
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *tips = [NSString stringWithFormat:@"请在iPhone的“设置-隐私-相机”选项中，允许 “%@” 访问你的手机相机",app_Name];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:tips delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}

#pragma mark TZImagePickerControllerDelegate
- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.parentViewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    [self imagePickerController:picker didFinishPickingPhotos:photos sourceAssets:assets];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    NSMutableArray *assetsPath = [[NSMutableArray alloc] init];
    @autoreleasepool {
        for (UIImage *image in photos) {
            NSData *dataObj = [self yaSuo:image];
            NSString *imgPath = [self getTempImgPath:[self strGUID]];
            [dataObj writeToFile:imgPath atomically:YES];
            [assetsPath addObject:imgPath];
        }
        if ([WSImageUtils sharedInstance].didFinishPickingAssets) {
            [WSImageUtils sharedInstance].didFinishPickingAssets(assetsPath);
        }
    }
    assetsPath = nil;
}

#pragma mark - 从相机获取到图片后回调操作
- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];

    @autoreleasepool {
        UIImage *image = nil;
        if (self.canEditPic==YES) {
            image = [info valueForKey:UIImagePickerControllerEditedImage];
        }
        else {
            image = [info valueForKey:UIImagePickerControllerOriginalImage];
        }
        image = [self normalizedImage:image];
        NSData *dataObj = [self yaSuo:image];
        NSString *imgPath = [self getTempImgPath:[self strGUID]];
        [dataObj writeToFile:imgPath atomically:YES];
        
        if (self.canEditPic==YES) {
            // 单张图片裁剪
            if ([WSImageUtils sharedInstance].didFinishPickingAssets) {
                [WSImageUtils sharedInstance].didFinishPickingAssets(@[imgPath]);
            }
            // 拍照裁剪
            if (self.didFinishCamera) {
                self.didFinishCamera(imgPath);
            }
        }
        // 拍照不裁剪
        if (self.didFinishCamera && !self.canEditPic) {
            self.didFinishCamera(imgPath);
        }
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    });
}

- (NSData *)yaSuo:(UIImage *)image {
    @autoreleasepool {
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        double len = data.length/1024;
        NSData *dataObj = data;
        if (len>300) {
            dataObj = UIImageJPEGRepresentation(image,WS_ImageScale_Value);
        }
        return dataObj;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:18]};
    
//    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    viewController.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    navigationController.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
    navigationController.navigationBar.tintColor = [UIColor whiteColor];
    navigationController.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 保存图片路径等相关辅助方法
- (NSString *)getTempImgPath:(NSString *)imgName{
    imgName = [imgName stringByReplacingOccurrencesOfString:@" " withString:@""];
    imgName = [imgName stringByReplacingOccurrencesOfString:@"-" withString:@""];
    imgName = [imgName stringByReplacingOccurrencesOfString:@":" withString:@""];
    NSString *tmpPath = [self fileTempDir:@"image"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:tmpPath]) {
        [self fileCreateDir:tmpPath];
    }
    tmpPath = [NSString stringWithFormat:@"%@/%@.jpg",tmpPath,imgName];
    return tmpPath;
}

- (NSString *)fileTempDir:(NSString *)path {
    NSString *tempDir = NSTemporaryDirectory();
    NSString *filePath = [tempDir stringByAppendingPathComponent:path];
    return filePath;
}

- (BOOL)fileCreateDir:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    BOOL success = [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];
    if (!success) {
        NSLog(@"fileCreateDir Error : %@", [error localizedDescription]);
    }
    return success;
}

- (NSString *)strGUID
{
    CFUUIDRef    uuidObj = CFUUIDCreate(nil);//create a new GUID
    NSString    *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    NSString    *guidStr = [uuidString lowercaseString];
    CFRelease(uuidObj);
    return guidStr;
}
- (UIImage *)normalizedImage:(UIImage *)image {
    @autoreleasepool {
        if (image.imageOrientation == UIImageOrientationUp) return image;
        UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
        [image drawInRect:(CGRect){0, 0, image.size}];
        UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return normalizedImage;
    }
}
@end
