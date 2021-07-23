//
//  VCMine.h
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import <UIKit/UIKit.h>
#import "PhotosViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface VCMine : UIViewController <SelectPhotoDelegate,UIScrollViewDelegate> {
    NSMutableArray* recentTitleArray;
    NSMutableArray* recentSecondArray;
    UIButton* buttonHeadImage;
    UIButton* headerHead;
    UILabel *numberLabel;
    id<UIScrollViewDelegate> delegate;
}

@property (nonatomic, strong) UIScrollView* mainScrollView;
@property (nonatomic, strong) UIScrollView* listScrollView;
@property (nonatomic, strong) UIScrollView* recentScrollView;
@property (nonatomic, strong) UIScrollView* myMusicScrollView;

@end

NS_ASSUME_NONNULL_END
