//
//  VCVideo.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import "VideoViewController.h"

#define selfWidth self.view.bounds.size.width
#define selfHeight self.view.bounds.size.height

@interface VCVideo ()

@end

@implementation VCVideo

@synthesize mainTableView;

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"shipin.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationItem.title = @"视频";
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    
    mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height, selfWidth, selfHeight - self.tabBarController.tabBar.bounds.size.height - [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height) style:UITableViewStyleGrouped];
    self.navigationController.navigationBar.hidden =YES;
    _fakeNavigationBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.navigationController.navigationBar.bounds.size.height + [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height)];
    NSLog(@"%f",self.navigationController.navigationBar.bounds.size.height);
    NSLog(@"%f",[UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height);
    _fakeNavigationBar.backgroundColor = [UIColor whiteColor];
    mainTableView.backgroundColor = [UIColor clearColor];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    mainTableView.separatorColor = [UIColor blackColor];
    
//    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.navigationController.navigationItem.titleView.frame.origin.x, self.navigationController.navigationItem.titleView.frame.origin.y +  + [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height, self.navigationController.navigationItem.titleView.frame.size.width, self.navigationController.navigationItem.titleView.frame.size.height)];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(60, [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height + 5, self.navigationController.navigationBar.bounds.size.width - 120, self.navigationController.navigationBar.bounds.size.height - 10)];
    _searchTextField.borderStyle = UITextBorderStyleBezel;
    _searchTextField.placeholder = @"搜索";
    _searchTextField.backgroundColor = [UIColor whiteColor];

    _searchImage = [[UIImageView alloc] initWithFrame:CGRectMake((60 - (self.navigationController.navigationBar.bounds.size.height - 10)) / 2, [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height + 5, self.navigationController.navigationBar.bounds.size.height - 10, self.navigationController.navigationBar.bounds.size.height - 10)];
    _searchImage.image = [UIImage imageNamed:@"search.jpg"];
    _searchButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _searchButton.frame = CGRectMake(self.navigationController.navigationBar.bounds.size.width - 60 + (60 - (self.navigationController.navigationBar.bounds.size.height - 10)) / 2 - 5, [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height + 5, self.navigationController.navigationBar.bounds.size.height, self.navigationController.navigationBar.bounds.size.height - 10);
    _searchButton.tintColor = [UIColor whiteColor];
    _searchButton.backgroundColor = [UIColor orangeColor];
    [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [_searchButton.layer setMasksToBounds:YES];
    [_searchButton.layer setCornerRadius:4];
    [_searchButton.layer setBorderWidth:0];
    
    mainTableView.showsVerticalScrollIndicator = NO;
    [_fakeNavigationBar addSubview:_searchImage];
    [_fakeNavigationBar addSubview:_searchButton];
    [_fakeNavigationBar addSubview: _searchTextField];
    [self.view addSubview: mainTableView];
    [self.view addSubview:_fakeNavigationBar];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellFirst"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFirst"];
    }
    cell.textLabel.text = @"视频";
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.navigationController.navigationBar.bounds.size.height;
}
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
//    _fakeNavigationBar.alpha = scrollView.contentOffset.y / self.navigationController.navigationBar.bounds.size.height * 5;
//
//}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _fakeNavigationBar.alpha = 1 - scrollView.contentOffset.y / self.navigationController.navigationBar.bounds.size.height;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
