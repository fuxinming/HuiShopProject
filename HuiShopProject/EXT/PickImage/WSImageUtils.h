//
//  WSImageUtil.h
//  ImageCropView
//
//  Created by jienliang on 16/1/25.
//
//

#import <Foundation/Foundation.h>
#import "TZImagePickerController.h"

#define WS_ImageScale_Value 0.9

@interface WSImageUtils : NSObject<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,TZImagePickerControllerDelegate>{
}
@property (nonatomic,assign) BOOL canEditPic;       //是否可以编辑
@property (nonatomic,assign) BOOL canMultiSelect;   //是否可以多选
@property (nonatomic,assign) int canSelectCount;//多选情况下，剩余可以多选的数量

@property (nonatomic,weak) UIViewController *parentViewController;

@property (nonatomic,strong) void (^didFinishCamera)(NSString *picPath);//完成单张拍照并选择
@property (nonatomic,strong) void (^didFinishPickingAssets)(NSArray *);//完成多选
@property (nonatomic,strong) void (^didCancelPickingAssets)();//取消多选

+ (WSImageUtils *)sharedInstance;
+ (void)destroyDealloc;
- (void)showAlertSheet:(UIViewController *)parentView;
- (void)showAlumSheet:(UIViewController *)parentView;
- (NSData *)yaSuo:(UIImage *)image;
@end
