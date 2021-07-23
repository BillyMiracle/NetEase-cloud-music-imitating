//
//  VCDiscovery.h
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import <UIKit/UIKit.h>
#import "AccountViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface DiscoveryViewController : UIViewController <UIScrollViewDelegate>
{
    NSTimer* timerFirst;
}

@property (nonatomic, strong) UIScrollView* mainScrollView;
@property (nonatomic, strong) UIScrollView* firstSubScrollView;
@property (nonatomic, strong) UIPageControl* firstPageControl;

@end

NS_ASSUME_NONNULL_END
