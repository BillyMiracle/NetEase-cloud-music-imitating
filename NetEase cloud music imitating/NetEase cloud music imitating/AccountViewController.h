//
//  VCAccount.h
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ViewControllerAccountDelegate <NSObject>

- (void) changeToNight: (NSInteger) nod;
- (void) changeToDay;

@end


@interface VCAccount : UIViewController
<UITableViewDelegate,UITableViewDataSource>
{
    UITableView* mineTableView;
    
    NSMutableArray* imageDataArray;
    NSMutableArray* textDataArray;
    
    UIButton* messageBotton;
    UIButton* friendButton;
    UIButton* mineButton;
    UIButton* derssupButton;
    UIButton* levelButton;
    
    UIView* viewFirst;
    UIView* viewSecond;
    
    UILabel* labelFirst;
    UILabel* labelSecond;
    
    UISwitch* switchNight;
}

@property(assign,nonatomic) id<ViewControllerAccountDelegate> delegate;

@property (nonatomic, copy) NSArray *array;

@property (nonatomic, assign) NSInteger nod;

@end

NS_ASSUME_NONNULL_END
