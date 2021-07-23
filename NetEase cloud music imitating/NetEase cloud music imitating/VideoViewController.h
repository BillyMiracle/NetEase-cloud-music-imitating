//
//  VCVideo.h
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface VCVideo : UIViewController
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView* mainTableView;

@property (nonatomic, strong) UIView* fakeNavigationBar;
@property (nonatomic, strong) UIView* fakeStatusBar;

@property (nonatomic, strong) UITextField* searchTextField;

@property (nonatomic, strong) UILabel* titleLabel;

@property (nonatomic, strong) UIImageView* searchImage;

@property (nonatomic, strong) UIButton* searchButton;
@end

NS_ASSUME_NONNULL_END
