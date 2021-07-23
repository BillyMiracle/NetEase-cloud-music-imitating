//
//  VCDiscovery.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import "DiscoveryViewController.h"

@interface DiscoveryViewController ()

@end

@implementation DiscoveryViewController

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"yinle.png"];
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [_firstSubScrollView setContentOffset:CGPointMake(self.view.bounds.size.width * 4, 0) animated:NO];
    _firstPageControl.currentPage = 0;
    [self initTimerFunction];
}

-(void)viewWillDisappear:(BOOL)animated {
    [timerFirst invalidate];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    // Do any additional setup after loading the view.
    
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height)];
    _firstSubScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.width / 2.5)];
    _mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, (self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height) * 2);
    _firstSubScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 6, self.view.bounds.size.width / 2.5);
    _firstSubScrollView.backgroundColor = [UIColor clearColor];
    _mainScrollView.backgroundColor = [UIColor clearColor];
    _firstSubScrollView.showsHorizontalScrollIndicator = NO;
    _firstSubScrollView.pagingEnabled = YES;
    _firstSubScrollView.delegate = self;
    _firstPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((_firstSubScrollView.frame.size.width - 200) / 2, _firstSubScrollView.frame.size.height - 40, 200, 40)];
    _firstPageControl.numberOfPages = 4;
//    _firstPageControl.currentPage = 0;
    _firstPageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    _firstPageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    [_firstPageControl addTarget:self action:@selector(valueChangedFirst) forControlEvents:UIControlEventValueChanged];
    for (int i = 0; i < 6; ++i) {
        UIButton *imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [imageButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"DiscoveryImage%d.jpg",i%4]] forState:UIControlStateNormal];
        imageButton.frame = CGRectMake(self.view.bounds.size.width * i, 0, self.view.bounds.size.width, self.view.bounds.size.width / 2.5);
        [imageButton addTarget:self action:@selector(pressDiscoveryImage:) forControlEvents:UIControlEventTouchUpInside];
        imageButton.tag = i;
        [imageButton.layer setMasksToBounds:YES];
        [imageButton.layer setCornerRadius:10];
        [imageButton.layer setBorderWidth:3];
        [imageButton.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_firstSubScrollView addSubview:imageButton];
    }
    
    [_mainScrollView addSubview:_firstSubScrollView];
    [_mainScrollView addSubview:_firstPageControl];
    [self.view addSubview:_mainScrollView];
//    [self initTimerFunction];
}

- (void) valueChangedFirst {
    [timerFirst invalidate];
    CGPoint offset = _firstSubScrollView.contentOffset;
    offset.x = self.view.bounds.size.width * _firstPageControl.currentPage;
    [_firstSubScrollView setContentOffset:offset animated:YES];
    [timerFirst fire];
    [self initTimerFunction];
}

-(void) initTimerFunction {
    NSTimer* timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(autoSelectPage) userInfo:nil repeats:YES];
    NSRunLoop* mainloop = [NSRunLoop mainRunLoop];
    [mainloop addTimer:timer forMode:NSRunLoopCommonModes];
    timerFirst = timer;
}

-(void) autoSelectPage {
    if (_firstSubScrollView.contentOffset.x == 0) {
        [_firstSubScrollView setContentOffset:CGPointMake(self.view.bounds.size.width * 4, 0) animated:NO];
    } else if (_firstSubScrollView.contentOffset.x / self.view.bounds.size.width == 5) {
        [_firstSubScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:NO];
    }
    [_firstSubScrollView setContentOffset:CGPointMake(_firstSubScrollView.contentOffset.x + self.view.bounds.size.width, 0) animated:YES];
    _firstPageControl.currentPage = ((int)(_firstSubScrollView.contentOffset.x / self.view.bounds.size.width) + 1) % 4;
}

- (void) pressDiscoveryImage:(UIButton*) imageButton {
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (scrollView == _firstSubScrollView) {
        [timerFirst fire];
        [self initTimerFunction];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (scrollView == _firstSubScrollView) {
        [timerFirst invalidate];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _firstSubScrollView) {
        CGFloat offset = _firstSubScrollView.contentOffset.x;
        CGFloat pagewi = self.view.bounds.size.width;
        _firstPageControl.currentPage = (int)(offset / pagewi) % 4;
        if(offset == 0) {
            [_firstSubScrollView setContentOffset:CGPointMake(self.view.bounds.size.width * 4, 0) animated:NO];
        }
        if(offset / pagewi == 5) {
            [_firstSubScrollView setContentOffset:CGPointMake(self.view.bounds.size.width, 0) animated:NO];
        }
    }
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
