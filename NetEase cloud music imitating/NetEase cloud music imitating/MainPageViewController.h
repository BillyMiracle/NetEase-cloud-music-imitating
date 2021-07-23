//
//  VCMainPage.h
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import <UIKit/UIKit.h>
#import "AccountViewController.h"
#import "DiscoveryViewController.h"
#import "VideoViewController.h"
#import "MineViewController.h"
#import "ClubViewController.h"
#import "AccountViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MainPageViewController : UITabBarController<ViewControllerAccountDelegate>

-(void) changeToNight:(NSInteger) nod;
-(void) changeToDay;
@property (nonatomic, copy) NSArray* vcArray;
@end

NS_ASSUME_NONNULL_END
