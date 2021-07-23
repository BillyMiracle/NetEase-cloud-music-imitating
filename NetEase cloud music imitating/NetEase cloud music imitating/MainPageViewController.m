//
//  VCMainPage.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import "MainPageViewController.h"


@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self dismissViewControllerAnimated:NO completion:nil];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    DiscoveryViewController* discoveryViewController = [[DiscoveryViewController alloc] init];
    VCVideo* videoViewController = [VCVideo new];
    VCMine* mineViewController = [VCMine new];
    VCClub* clubViewController = [VCClub new];
    VCAccount* accountViewController = [VCAccount new];
    
    accountViewController.delegate = self;
    
    
    discoveryViewController.title = @"发现";
    videoViewController.title = @"视频";
    mineViewController.title = @"我的";
    clubViewController.title = @"云村";
    accountViewController.title = @"账号";
    
    UINavigationController* navFirst = [[UINavigationController alloc] initWithRootViewController: discoveryViewController];
    UINavigationController* navSecond = [[UINavigationController alloc] initWithRootViewController: videoViewController];
    UINavigationController* navThird = [[UINavigationController alloc] initWithRootViewController: mineViewController];
    UINavigationController* navFourth = [[UINavigationController alloc] initWithRootViewController: clubViewController];
    UINavigationController* navFifth = [[UINavigationController alloc] initWithRootViewController: accountViewController];
    
    _vcArray = [NSArray arrayWithObjects: navFirst, navSecond, navThird, navFourth, navFifth, nil];
    accountViewController.array = _vcArray;
    self.tabBar.translucent = NO;
    self.viewControllers = _vcArray;
    self.tabBar.tintColor = [UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1];
    self.tabBar.barTintColor = [UIColor whiteColor];
    [[UITabBar appearance] setShadowImage:[self createImageWithColor:[UIColor whiteColor]]];
    [[UITabBar appearance] setBackgroundImage:[self createImageWithColor:[UIColor whiteColor]]];
    //self.tabBar.backgroundImage = [self createImageWithColor:[UIColor blackColor]];
}

-(void) changeToNight: (NSInteger) nod {
//    self.view.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
//    self.tabBarController.tabBar.backgroundImage = [self createImageWithColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
//    self.tabBarController.tabBar.shadowImage = [self createImageWithColor:[UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1]];
//    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//    VCDiscovery *view0 = _vcArray[0];
//    view0.navigationController.navigationBar.barStyle = UIBarStyleBlack;
}

-(void) changeToDay {
//    self.view.backgroundColor = [UIColor whiteColor];
//    self.tabBarController.tabBar.backgroundImage = [self createImageWithColor:[UIColor whiteColor]];
//    self.tabBarController.tabBar.shadowImage = [self createImageWithColor:[UIColor whiteColor]];
}

-(UIImage*) createImageWithColor:(UIColor*) color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
