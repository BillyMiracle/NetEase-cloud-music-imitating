//
//  VCMine.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import "MineViewController.h"
#import "CloudViewController.h"
#import "PhotosViewController.h"

#define selfWidth self.view.bounds.size.width

@interface VCMine ()

@end

@implementation VCMine

@synthesize mainScrollView;
@synthesize listScrollView;
@synthesize recentScrollView;
@synthesize myMusicScrollView;

- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"yinyue.png"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.alpha = 0;
    UIImage* imageCloud = [UIImage imageNamed:@"yun.png"];
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithImage:imageCloud
       style:UIBarButtonItemStylePlain target:self action:@selector(pressCloud)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationItem.title = @"";
//导航栏头像按钮
    headerHead = [UIButton buttonWithType:UIButtonTypeCustom];
    headerHead.frame = CGRectMake(0, 0, 30, 30);
    [headerHead.layer setMasksToBounds:YES];
    [headerHead.layer setCornerRadius:15];
    [headerHead.layer setBorderWidth:0];
    NSString* headImageName1 = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
    [headerHead setBackgroundImage:[UIImage imageNamed:headImageName1] forState:UIControlStateNormal];
    UIView* head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [head addSubview:headerHead];
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithCustomView: head];
    self.navigationItem.rightBarButtonItem = rightButton;
    
//
    mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height - [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height)];
    mainScrollView.backgroundColor = [UIColor clearColor];
    mainScrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.width / 2 + 480 + self.view.bounds.size.width / 9 * 4);
//
    mainScrollView.showsVerticalScrollIndicator = NO;
    UILabel* labelMine = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.width / 2, self.view.bounds.size.width - 20, 40)];
    labelMine.font = [UIFont systemFontOfSize:16];
    labelMine.textColor = [UIColor blackColor];
    labelMine.text = @"我的音乐";
    
    myMusicScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width / 2 + 40, self.view.bounds.size.width, self.view.bounds.size.width / 9 * 4)];
    myMusicScrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 2 - 15, self.view.bounds.size.width / 9 * 4);
    myMusicScrollView.backgroundColor = [UIColor clearColor];
    myMusicScrollView.pagingEnabled = NO;
    myMusicScrollView.bounces = NO;
    myMusicScrollView.showsHorizontalScrollIndicator = NO;
    myMusicScrollView.delegate = self;
    
    NSMutableArray* arrayMyMusic = [NSMutableArray arrayWithObjects:@"我喜欢的音乐", @"私人FM", @"云狗推荐", @"听歌月榜", @"听歌周榜", @"好友在听", nil];
    for (int i = 0 ; i < 6; ++i) {
        UIButton* myMusic = [UIButton buttonWithType:UIButtonTypeCustom];
        //float width = self.view.bounds.size.width / 3 - 10;
        float width = (self.view.bounds.size.width - 30) / 3;
        float height = width * 4 / 3;
        //myMusic.frame = CGRectMake(i * width + 5 * (i * 2 + 1), (self.view.bounds.size.width / 9 * 4 - height) / 2, width, height);
        myMusic.frame = CGRectMake(i * width + 5 * (i + 2), (self.view.bounds.size.width / 9 * 4 - height) / 2, width, height);
        [myMusic setImage:[UIImage imageNamed:[NSString stringWithFormat:@"myMusicIcon%d.png",i]] forState:UIControlStateNormal];
        [myMusic setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"myMusic%d.png",i % 3]] forState:UIControlStateNormal];
        [myMusic setTitle:arrayMyMusic[i] forState:UIControlStateNormal];
        [myMusic addTarget:self action:@selector(pressMyMusic:) forControlEvents:UIControlEventTouchUpInside];
        [myMusic setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
        [myMusic setTitleEdgeInsets:UIEdgeInsetsMake(myMusic.currentImage.size.height  + 5, -myMusic.currentImage.size.width, 0, 0)];
        [myMusic setImageEdgeInsets:UIEdgeInsetsMake(-myMusic.titleLabel.intrinsicContentSize.height - 5, 0, 0, -myMusic.titleLabel.intrinsicContentSize.width)];
        //UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)
        //myMusic.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        myMusic.tag = 110 + i;
        //设置成圆角按钮
        [myMusic.layer setMasksToBounds:YES];
        [myMusic.layer setCornerRadius:10];
        [myMusic.layer setBorderWidth:1];
        myMusic.layer.borderColor = [UIColor clearColor].CGColor;
        
        [myMusicScrollView addSubview: myMusic];
    }
    
    //设置最上面“个人”界面
    UIView* mineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, selfWidth, selfWidth / 2)];
    float len = self.view.bounds.size.width/4;
    
    UIButton* buttonLocal = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLocal.frame = CGRectMake(0, len, len, len);
    [buttonLocal setImage:[UIImage imageNamed:@"xiazai.png"] forState:UIControlStateNormal];
    [buttonLocal setTitle:@"本地音乐" forState:UIControlStateNormal];
    [buttonLocal setTitleEdgeInsets:UIEdgeInsetsMake(buttonLocal.currentImage.size.height + 5, -buttonLocal.currentImage.size.width, 0, 0)];
    [buttonLocal setImageEdgeInsets:UIEdgeInsetsMake(-buttonLocal.titleLabel.intrinsicContentSize.height - 5, 0, 0, -buttonLocal.titleLabel.intrinsicContentSize.width)];
    [buttonLocal setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
    
    UIButton* buttonRideo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonRideo.frame = CGRectMake(len, len, len, len);
    [buttonRideo setImage:[UIImage imageNamed:@"diantai.png"] forState:UIControlStateNormal];
    [buttonRideo setTitle:@"我的电台" forState:UIControlStateNormal];
    [buttonRideo setTitleEdgeInsets:UIEdgeInsetsMake(buttonRideo.currentImage.size.height + 5, -buttonRideo.currentImage.size.width, 0, 0)];
    [buttonRideo setImageEdgeInsets:UIEdgeInsetsMake(-buttonRideo.titleLabel.intrinsicContentSize.height - 5, 0, 0, -buttonRideo.titleLabel.intrinsicContentSize.width)];
    [buttonRideo setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
    
    UIButton* buttonLike = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonLike.frame = CGRectMake(len * 2, len, len, len);
    [buttonLike setImage:[UIImage imageNamed:@"shoucang.png"] forState:UIControlStateNormal];
    [buttonLike setTitle:@"我的收藏" forState:UIControlStateNormal];
    [buttonLike setTitleEdgeInsets:UIEdgeInsetsMake(buttonLike.currentImage.size.height + 5, -buttonLike.currentImage.size.width, 0, 0)];
    [buttonLike setImageEdgeInsets:UIEdgeInsetsMake(-buttonLike.titleLabel.intrinsicContentSize.height - 5, 0, 0, -buttonLike.titleLabel.intrinsicContentSize.width)];
    [buttonLike setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
    
    UIButton* buttonNew = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonNew.frame = CGRectMake(len * 3, len, len, len);
    [buttonNew setImage:[UIImage imageNamed:@"xinge.png"] forState:UIControlStateNormal];
    [buttonNew setTitle:@"关注新歌" forState:UIControlStateNormal];
    [buttonNew setTitleEdgeInsets:UIEdgeInsetsMake(buttonNew.currentImage.size.height + 5, -buttonNew.currentImage.size.width, 0, 0)];
    [buttonNew setImageEdgeInsets:UIEdgeInsetsMake(-buttonNew.titleLabel.intrinsicContentSize.height - 5, 0, 0, -buttonNew.titleLabel.intrinsicContentSize.width)];
    [buttonNew setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];

//头像按钮
    buttonHeadImage = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonHeadImage.frame = CGRectMake(16, 16, selfWidth/4 - 32, selfWidth/4 - 32);
    [buttonHeadImage.layer setMasksToBounds:YES];
    [buttonHeadImage.layer setBorderWidth:10];
    [buttonHeadImage.layer setCornerRadius:selfWidth/8 - 16];
    [buttonHeadImage.layer setBorderColor:[UIColor clearColor].CGColor];
    NSString* headImageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
    [buttonHeadImage setBackgroundImage:[UIImage imageNamed:headImageName] forState:UIControlStateNormal];
    [buttonHeadImage addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];
    
//用户按钮
    UIButton* buttonName = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonName.frame = CGRectMake(selfWidth/4 - 12, 16, 50, 40);
    [buttonName setTitle:@"用户" forState:UIControlStateNormal];
    [buttonName setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    buttonName.titleLabel.font = [UIFont systemFontOfSize:24];
    
//VIP按钮
    UIButton* buttonVip = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonVip.frame = CGRectMake(selfWidth - 60, 16, 50, 40);
    [buttonVip setTitle:@"Vip ＞" forState:UIControlStateNormal];
    [buttonVip setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    buttonVip.titleLabel.font = [UIFont systemFontOfSize:16];
    
    UILabel* labelRecent = [[UILabel alloc] initWithFrame:CGRectMake(20, self.view.bounds.size.width / 2 + 40 + self.view.bounds.size.width / 9 * 4, self.view.bounds.size.width - 20, 40)];
    labelRecent.font = [UIFont systemFontOfSize:16];
    labelRecent.textColor = [UIColor blackColor];
    labelRecent.text = @"最近播放";
    
    recentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width / 2 + 80 + self.view.bounds.size.width / 9 * 4, selfWidth, 90)];
    recentScrollView.contentSize = CGSizeMake(selfWidth * 2 - 15, 90);
    recentScrollView.showsHorizontalScrollIndicator = NO;
    recentScrollView.bounces = NO;
    recentScrollView.delegate = self;
    
    recentTitleArray = [[NSMutableArray alloc] initWithObjects:@"全部已播歌曲",@"歌单：翻唱",@"歌单：纯音乐",@"歌单：哈哈", nil];
    recentSecondArray = [[NSMutableArray alloc] initWithObjects:@"300首",@"继续播放",@"继续播放",@"继续播放", nil];
    for (int i = 0 ; i < 4; ++i) {
        UIButton* recentMusic = [UIButton buttonWithType:UIButtonTypeCustom];
        //float width2 = self.view.bounds.size.width / 2 - 10;
        float width2 = (self.view.bounds.size.width - 25) / 2 ;
        //recentMusic.frame = CGRectMake(i * width2 + 5 * (i * 2 + 1), 5, width2, 80);
        recentMusic.frame = CGRectMake(i * width2 + 5 * (i + 2), 5, width2, 80);
        [recentMusic.layer setMasksToBounds:YES];
        [recentMusic.layer setCornerRadius:10];
        [recentMusic.layer setBorderWidth:1];
        [recentMusic.layer setBorderColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1].CGColor];
        recentMusic.backgroundColor = [UIColor clearColor];
        
        UIImageView* recentImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [recentImage.layer setMasksToBounds:YES];
        [recentImage.layer setCornerRadius:10];
        [recentImage.layer setBorderWidth:0];
        recentImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"recentImage%d.png", i % 2]];
        
        UILabel* recentTitle = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, width2 - 90, 50)];
        recentTitle.textColor = [UIColor blackColor];
        recentTitle.text = recentTitleArray[i];
        //recentTitle.textAlignment = NSTextAlignmentCenter;
        recentTitle.font = [UIFont systemFontOfSize:15];
        
        UILabel* recentSecondTitle = [[UILabel alloc] initWithFrame: CGRectMake(95, 30, width2 - 100, 40)];
        recentSecondTitle.textColor = [UIColor grayColor];
        recentSecondTitle.text = recentSecondArray[i];
        recentSecondTitle.font = [UIFont systemFontOfSize:13];
        
        [recentMusic addSubview:recentSecondTitle];
        [recentMusic addSubview:recentTitle];
        [recentMusic addTarget:self action:@selector(pressRecentMusic:) forControlEvents:UIControlEventTouchUpInside];
        [recentMusic addSubview: recentImage];
        [recentScrollView addSubview: recentMusic];
    }
    
    listScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.width / 2 + 210 + self.view.bounds.size.width / 9 * 4, selfWidth , 270)];
    listScrollView.contentSize = CGSizeMake((selfWidth - 20) * 2 + 25, 270);
    listScrollView.showsHorizontalScrollIndicator = NO;
//    scrollViewList.pagingEnabled = YES;
    listScrollView.pagingEnabled = NO;
    listScrollView.delegate = self;
    listScrollView.bounces = NO;
    NSArray* arrayListFirst = [NSArray arrayWithObjects:@"翻唱",@"哈哈",@"好听英文",@"小清新", nil];
    NSArray* arrayListSecond = [NSArray arrayWithObjects:@"纯音乐",@"中文",@"纯音乐",@"车载", nil];
    NSArray* arrayListThird = [NSArray arrayWithObjects:@"粤语",@"导入外部歌单",@"跑步",@"其他", nil];
    NSMutableArray* musicListArray = [NSMutableArray arrayWithObjects:arrayListFirst, arrayListSecond, arrayListThird, nil];
    NSArray* arrayListFirst2 = [NSArray arrayWithObjects:@"30首",@"267首",@"143首",@"56首", nil];
    NSArray* arrayListSecond2 = [NSArray arrayWithObjects:@"34首",@"45首",@"123首",@"345首", nil];
    NSArray* arrayListThird2 = [NSArray arrayWithObjects:@"24首",@"",@"98首",@"", nil];
    NSMutableArray* musicListArray2 = [NSMutableArray arrayWithObjects:arrayListFirst2, arrayListSecond2, arrayListThird2, nil];
    for (int i = 0 ; i < 4; ++i) {
        for (int j = 0; j < 3; ++j) {
            UIButton* myMusic = [UIButton buttonWithType:UIButtonTypeCustom];
//            float width2 = self.view.bounds.size.width / 2 - 10;
            float width2 = (self.view.bounds.size.width - 25) / 2 ;
//            myMusic.frame = CGRectMake(i * width2 + 5 * (i * 2 + 1), j * 80 + 5 * (j * 2 + 1), width2, 80);
            myMusic.frame = CGRectMake(i * width2 + 5 * (i + 2), j * 80 + 5 * (j * 2 + 1), width2, 80);
            [myMusic.layer setMasksToBounds:YES];
            [myMusic.layer setCornerRadius:10];
            [myMusic.layer setBorderWidth:0];
            [myMusic.layer setBorderColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1].CGColor];
            myMusic.backgroundColor = [UIColor clearColor];
            
            UIImageView* myImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
            [myImage.layer setMasksToBounds:YES];
            [myImage.layer setCornerRadius:10];
            [myImage.layer setBorderWidth:0];
            myImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"musicList%d%d.png", j, i % 2]];
            
            UILabel* myTitle = [[UILabel alloc] initWithFrame:CGRectMake(85, 0, width2 - 90, 50)];
            myTitle.textColor = [UIColor blackColor];
            myTitle.text = musicListArray[j][i];
            myTitle.font = [UIFont systemFontOfSize:15];
            
            UILabel* mySecondTitle = [[UILabel alloc] initWithFrame: CGRectMake(85, 30, width2 - 100, 40)];
            mySecondTitle.textColor = [UIColor grayColor];
            mySecondTitle.text = musicListArray2[j][i];
            mySecondTitle.font = [UIFont systemFontOfSize:13];
            
            [myMusic addSubview:mySecondTitle];
            [myMusic addSubview:myTitle];
            [myMusic addTarget:self action:@selector(pressMusicList:) forControlEvents:UIControlEventTouchUpInside];
            [myMusic addSubview: myImage];
            myMusic.tag = i * 10 + j;
            [listScrollView addSubview: myMusic];
        }
    }
    
    UIButton* createdButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    createdButton.frame = CGRectMake(15, self.view.bounds.size.width / 2 + 170 + self.view.bounds.size.width / 9 * 4, 80, 40);
    [createdButton setTitle:@"创建歌单" forState:UIControlStateNormal];
    [createdButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createdButton.titleLabel.font = [UIFont systemFontOfSize:16];
    createdButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [createdButton addTarget:self action:@selector(pressCreatedButton:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton* likeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    likeButton.frame = CGRectMake(95, self.view.bounds.size.width / 2 + 170 + self.view.bounds.size.width / 9 * 4, 80, 40);
    [likeButton setTitle:@"收藏歌单" forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    likeButton.titleLabel.font = [UIFont systemFontOfSize:16];
    likeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    [likeButton addTarget:self action:@selector(pressLikeButton:) forControlEvents:UIControlEventTouchUpInside];
    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width/4, 56, 12, 12)];
    
    [mainScrollView addSubview: likeButton];
    [mainScrollView addSubview: createdButton];
    [mainScrollView addSubview: listScrollView];
    [mineView addSubview: buttonName];
    [mineView addSubview: buttonHeadImage];
    [mineView addSubview: buttonLocal];
    [mineView addSubview: buttonRideo];
    [mineView addSubview: buttonLike];
    [mineView addSubview: buttonNew];
    [mineView addSubview: buttonVip];
    [mainScrollView addSubview: recentScrollView];
    [mainScrollView addSubview: mineView];
    [mainScrollView addSubview: labelMine];
    [mainScrollView addSubview: myMusicScrollView];
    [mainScrollView addSubview: labelRecent];
    [self.view addSubview:mainScrollView];
}

- (void)changeHeadImage:(UIButton*) headImageButton{
    ViewControllerPhotos* photoWall = [[ViewControllerPhotos alloc] init];
    photoWall.delegate = self;
    
    //[self.navigationController pushViewController:photoWall animated:YES];
    //photoWall.modalPresentationStyle = UIModalPresentationFullScreen;
    
    UINavigationController* photoWallNavigationController = [[UINavigationController alloc] initWithRootViewController:photoWall];
    photoWallNavigationController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:photoWallNavigationController animated:YES completion:nil];
}

- (void)pressCloud {
    ViewControllerCloud* cloud = [ViewControllerCloud new];
    UIButton* headerHead2 = [UIButton buttonWithType:UIButtonTypeCustom];
    headerHead2.frame = CGRectMake(0, 0, 30, 30);
    [headerHead2.layer setMasksToBounds:YES];
    [headerHead2.layer setCornerRadius:15];
    [headerHead2.layer setBorderWidth:0];
    [headerHead2 setBackgroundImage:buttonHeadImage.currentBackgroundImage forState:UIControlStateNormal];
    UIView* head = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    [head addSubview:headerHead2];
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithCustomView: head];
    cloud.navigationItem.rightBarButtonItem = rightButton;
    [self.navigationController pushViewController:cloud animated:YES];
}

- (void)pressCreatedButton:(UIButton*)createdButton {
    [listScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void) pressLikeButton:(UIButton*)createdButton {
    [listScrollView setContentOffset:CGPointMake(self.view.bounds.size.width - 15, 0) animated:YES];
}

- (void)pressMyMusic:(UIButton*) musicButton {
    if (musicButton.tag == 110) {
        
    } else if (musicButton.tag == 111) {
        
    } else if (musicButton.tag == 112) {
        
    } else if (musicButton.tag == 113) {
        
    } else if (musicButton.tag == 114) {
        
    } else if (musicButton.tag == 115) {
        
    }
    NSLog(@"%ld",musicButton.tag);
}

- (void)pressRecentMusic:(UIButton*)recentMusicButton {
    NSLog(@"1111");
}

- (void)pressMusicList:(UIButton*)musicListButton {
    NSLog(@"%ld",musicListButton.tag);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)selectedPhoto:(UIImage *)headImage number:(NSInteger)numberOfPhotos {
    if (headImage) {
        [buttonHeadImage setBackgroundImage:headImage forState:UIControlStateNormal];
        [headerHead setBackgroundImage:headImage forState:UIControlStateNormal];
    }
    self->numberLabel.text = [NSString stringWithFormat:@"%ld",numberOfPhotos];
    self->numberLabel.textColor = [UIColor blackColor];
    [mainScrollView addSubview:numberLabel];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == myMusicScrollView) {
        for (int i = 0; i < 4; ++i) {
//            if (scrollView.contentOffset.x >= selfWidth  / 3 * i - selfWidth / 6) {
//                [scrollView setContentOffset:CGPointMake(selfWidth / 3 * i, 0) animated:YES];
//            }
            if (scrollView.contentOffset.x >= (self.view.bounds.size.width - 30) / 3 * i - (self.view.bounds.size.width - 30) / 6 + 5*(i+1)){
                [scrollView setContentOffset:CGPointMake(((self.view.bounds.size.width - 30) / 3 + 5) * i, 0) animated:YES];
            }
        }
    } else if (scrollView == recentScrollView) {
        for (int i = 0; i < 3; ++i) {
//            if (scrollView.contentOffset.x >= selfWidth  / 2 * i - selfWidth / 4) {
//                [scrollView setContentOffset:CGPointMake(selfWidth / 2 * i, 0) animated:YES];
//            }
            if (scrollView.contentOffset.x >= (self.view.bounds.size.width - 25) / 2 * i - (self.view.bounds.size.width - 25) / 4 + 5*(i+1)) {
                [scrollView setContentOffset:CGPointMake(((self.view.bounds.size.width - 25) / 2 + 5) * i, 0) animated:YES];
            }
        }
    } else if (scrollView == listScrollView) {
        if (scrollView.contentOffset.x >= (self.view.bounds.size.width - 20) - (self.view.bounds.size.width - 20) / 2 + 10) {
            [scrollView setContentOffset:CGPointMake(self.view.bounds.size.width - 15, 0) animated:YES];
        } else {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView == myMusicScrollView) {
        for (int i = 0; i < 4; ++i) {
//            if (scrollView.contentOffset.x >= selfWidth  / 3 * i - selfWidth / 6) {
//                [scrollView setContentOffset:CGPointMake(selfWidth / 3 * i, 0) animated:YES];
//            }
            if (scrollView.contentOffset.x >= (self.view.bounds.size.width - 30) / 3 * i - (self.view.bounds.size.width - 30) / 6 + 5*(i+1)){
                [scrollView setContentOffset:CGPointMake(((self.view.bounds.size.width - 30) / 3 + 5) * i, 0) animated:YES];
            }
        }
    } else if (scrollView == recentScrollView) {
        for (int i = 0; i < 3; ++i) {
//            if (scrollView.contentOffset.x >= selfWidth  / 2 * i - selfWidth / 4) {
//                [scrollView setContentOffset:CGPointMake(selfWidth / 2 * i, 0) animated:YES];
//            }
            if (scrollView.contentOffset.x >= (self.view.bounds.size.width - 25) / 2 * i - (self.view.bounds.size.width - 25) / 4 + 5*(i+1)) {
                [scrollView setContentOffset:CGPointMake(((self.view.bounds.size.width - 25) / 2 + 5) * i, 0) animated:YES];
            }
        }
    } else if (scrollView == listScrollView) {
        if (scrollView.contentOffset.x >= (self.view.bounds.size.width - 20) - (self.view.bounds.size.width - 20) / 2 + 10) {
            [scrollView setContentOffset:CGPointMake(self.view.bounds.size.width - 15, 0) animated:YES];
        } else {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
    }
}

@end
