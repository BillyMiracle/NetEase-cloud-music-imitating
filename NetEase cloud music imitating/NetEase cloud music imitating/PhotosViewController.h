//
//  ViewControllerPhotos.h
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SelectPhotoDelegate <NSObject>

- (void) selectedPhoto: (UIImage*) headImage number: (NSInteger) numberOfPhotos;

@end

@interface ViewControllerPhotos : UIViewController
{
    UIButton* headImageButton;
    NSMutableArray* imagesArray;
}
@property (nonatomic, strong) UIScrollView* photoWall;
@property (nonatomic, assign) id<SelectPhotoDelegate> delegate;
@property (nonatomic, strong) UIImageView* Tag;
@end

NS_ASSUME_NONNULL_END
