//
//  ViewControllerCloud.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/19.
//

#import "CloudViewController.h"

@interface ViewControllerCloud ()

@end

@implementation ViewControllerCloud

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的音乐云盘";
    
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressBack)];
    [leftButton setTintColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
    self.navigationItem.leftBarButtonItem = leftButton;
}

-(void) pressBack {
    [self.navigationController popViewControllerAnimated: YES];
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
