//
//  VCAccount.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/18.
//

#import "AccountViewController.h"
#import "DiscoveryViewController.h"


@interface VCAccount ()

@end

@implementation VCAccount
- (instancetype)init {
    if (self = [super init]) {
        self.tabBarItem.image = [UIImage imageNamed:@"wo.png"];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated {
    [mineTableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.title = @"";
    
    UIImage* scanImage = [UIImage imageNamed:@"saoma.png"];
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithImage:scanImage
       style:UIBarButtonItemStylePlain target:self action:@selector(pressScan)];
    self.navigationItem.leftBarButtonItem = leftButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor grayColor];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    mineTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,self.view.bounds.size.width, self.view.bounds.size.height - self.tabBarController.tabBar.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height) style:UITableViewStyleGrouped];
    //tableViewMine = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    mineTableView.delegate = self;
    mineTableView.dataSource = self;
    mineTableView.backgroundColor = [UIColor whiteColor];
    mineTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    mineTableView.sectionFooterHeight = 0;
    
    NSMutableArray* textArrayFirst = [NSMutableArray arrayWithObjects: @"用户",nil];
    NSMutableArray* textArraySecond = [NSMutableArray arrayWithObjects: @"创作者中心",nil];
    NSMutableArray* textArrayThird = [NSMutableArray arrayWithObjects: @"演出",@"商城",@"口袋彩铃",@"在线听歌免流量",nil];
    NSMutableArray* textArrayFourth = [NSMutableArray arrayWithObjects: @"设置",@"夜间模式",@"定时关闭",@"音乐黑名单",@"小鲸鱼音效",@"添加快捷指令",@"音乐闹钟",@"青少年模式",@"我的订单",@"优惠券",@"分享",@"关于",nil];
    NSMutableArray* textArray4 = [NSMutableArray arrayWithObjects: @"退出登录",nil];
    textDataArray = [NSMutableArray arrayWithObjects:textArrayFirst, textArraySecond, textArrayThird, textArrayFourth, textArray4, nil];
    
    NSMutableArray* imageArrayFirst = [NSMutableArray arrayWithObjects: [UIImage imageNamed:@"HEAD.jpg"],nil];
    NSMutableArray* imageArraySecond = [NSMutableArray arrayWithObjects: [UIImage imageNamed:@"dengpao.png"],nil];
    NSMutableArray* imageArrayThird = [NSMutableArray arrayWithObjects: [UIImage imageNamed:@"piao.png"],[UIImage imageNamed:@"shouye.png"],[UIImage imageNamed:@"cailing.png"],[UIImage imageNamed:@"hezi.png"],nil];
    NSMutableArray* imageArrayFourth = [NSMutableArray arrayWithObjects: [UIImage imageNamed:@"shezhi.png"],[UIImage imageNamed:@"yejian.png"],[UIImage imageNamed:@"jishiqi.png"],[UIImage imageNamed:@"icon-ignore.png"],[UIImage imageNamed:@"jingyu.png"],[UIImage imageNamed:@"kuaijie.png"],[UIImage imageNamed:@"dingshi.png"],[UIImage imageNamed:@"hudun.png"],[UIImage imageNamed:@"dd.png"],[UIImage imageNamed:@"youhui.png"],[UIImage imageNamed:@"fenxiang.png"],[UIImage imageNamed:@"guanyu.png"],nil];
    imageDataArray = [NSMutableArray arrayWithObjects:imageArrayFirst, imageArraySecond, imageArrayThird, imageArrayFourth, nil];
    
    levelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    switchNight = [[UISwitch alloc] initWithFrame:CGRectZero];
    labelFirst = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width - 20, 60)];
    labelSecond = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, self.view.bounds.size.width - 20, 60)];
    [self.view addSubview: mineTableView];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2) {
        return 4;
    } else if (section == 3) {
        return 12;
    }
    return 1;
}
//设置数据视图的组数
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}
//创建单元格对象函数
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSString* cellStr = [NSString stringWithFormat:@"cell%ld%ld",indexPath.section, indexPath.row];
//    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellStr];
//    //UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
//    if(cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellStr];
//    }
//    cell.backgroundColor = [UIColor clearColor];
//    if (_nod == 1) {
//        cell.textLabel.textColor = [UIColor whiteColor];
//    } else {
//        cell.textLabel.textColor = [UIColor blackColor];
//    }
//    if (indexPath.section != 4) {
//        cell.imageView.image = arrayImageData[indexPath.section][indexPath.row];
//    } else {
//        cell.textLabel.textColor = [UIColor redColor];
//        cell.textLabel.textAlignment = NSTextAlignmentCenter;
//        cell.textLabel.font = [UIFont systemFontOfSize: 20];
//    }
//    if (indexPath.section == 3 && indexPath.row == 1) {
//
//        switchNight = [[UISwitch alloc] initWithFrame:CGRectZero];
//        [switchNight addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//        [switchNight setOnTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
//        switchNight.on = _nod;
//        cell.accessoryView = switchNight;
//
//    } else if (indexPath.section != 0 && indexPath.section != 4) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }
//
//    if (indexPath.section == 0) {
//
//        buttonLevel = [UIButton buttonWithType:UIButtonTypeCustom];
//        buttonLevel.frame = CGRectMake(self.view.bounds.size.width - 80, 10, 70, 20);
//        [buttonLevel setTitle:@"等级Lv.7" forState:UIControlStateNormal];
//        buttonLevel.titleLabel.font = [UIFont systemFontOfSize:13];
//        [buttonLevel.layer setMasksToBounds:YES];
//        [buttonLevel.layer setBorderWidth:2];
//        [buttonLevel.layer setCornerRadius: 10];
//        [buttonLevel.layer setBorderColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1].CGColor];
//
//
//        [buttonLevel setTitleColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1] forState:UIControlStateNormal];
//        [buttonLevel addTarget:self action:@selector(pressLevel:) forControlEvents:UIControlEventTouchUpInside];
//
//        [cell addSubview:buttonLevel];
//    }
//    cell.textLabel.text = arrayTextData[indexPath.section][indexPath.row];
//    NSLog(@"%ld %ld  %p",indexPath.section, indexPath.row, &cell);
//    return cell;
//
    if (indexPath.section == 0) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellFirst"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellFirst"];
        }
        levelButton.frame = CGRectMake(self.view.bounds.size.width - 80, 10, 70, 20);
        [levelButton setTitle:@"等级Lv.7" forState:UIControlStateNormal];
        levelButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [levelButton.layer setMasksToBounds:YES];
        [levelButton.layer setBorderWidth:2];
        [levelButton.layer setCornerRadius: 10];
        [levelButton.layer setBorderColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1].CGColor];
        [levelButton setTitleColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1] forState:UIControlStateNormal];
        [levelButton addTarget:self action:@selector(pressLevel:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:levelButton];
        cell.textLabel.text = textDataArray[indexPath.section][indexPath.row];
        [cell.imageView.layer setMasksToBounds:YES];
        [cell.imageView.layer setCornerRadius:20];
        [cell.imageView.layer setBorderWidth:0];
        [cell.imageView.layer setBorderColor:[UIColor clearColor].CGColor];
//        cell.imageView.image = arrayImageData[indexPath.section][indexPath.row];
        
        NSString* imageName = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
        NSLog(@"%@",imageName);
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"switchType"]);
        NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"]);
        NSLog(@"%@",imageName);
        cell.imageView.image = [UIImage imageNamed:imageName];
        
//        NSLog(@"@1 %ld %ld  %p",indexPath.section, indexPath.row, cell);
        return cell;
    } else if (indexPath.section == 4) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellLast"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellLast"];
        }
        cell.textLabel.textColor = [UIColor redColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize: 20];
        cell.textLabel.text = textDataArray[indexPath.section][indexPath.row];
//        NSLog(@"@2 %ld %ld  %p",indexPath.section, indexPath.row, cell);
        return cell;
    } else if (indexPath.section == 3 && indexPath.row == 1) {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellMiddleFirst"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellMiddleFirst"];
        }
        [switchNight addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
        [switchNight setOnTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
        //switchNight.on = _nod;
//读取开关状态
        switchNight.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchType"];
        
        cell.accessoryView = switchNight;
        cell.textLabel.text = textDataArray[indexPath.section][indexPath.row];
        cell.imageView.image = imageDataArray[indexPath.section][indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        NSLog(@"@3 %ld %ld  %p",indexPath.section, indexPath.row, cell);
        return cell;
    } else {
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cellMiddleSecond"];
        if(cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellMiddleSecond"];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = textDataArray[indexPath.section][indexPath.row];
        cell.imageView.image = imageDataArray[indexPath.section][indexPath.row];
//        NSLog(@"@4 %ld %ld  %p",indexPath.section, indexPath.row, cell);
        return cell;
    }
}

-(void)pressLevel:(UIButton*)buttonLevel {
    
}

- (void)switchAction:(UISwitch*)switchNight {

//改变开关状态
    BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:@"switchType" ];
    isOn = !isOn;
    [[NSUserDefaults standardUserDefaults]setBool:isOn forKey:@"switchType"];
    switchNight.on = isOn;
    [[NSUserDefaults standardUserDefaults] synchronize];
//    UIImage* head = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
//    UIImageView* view = [[UIImageView alloc] initWithImage:head];
//    view.frame = CGRectMake(0, 0, 100, 100);
//    [self.view addSubview: view];
    
/*
    if (switchNight.on) {
        NSLog(@"on");
        _nod = 1;
//        [_delegate changeToNight: _nod];
//        tableViewMine.backgroundColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
//        for (int i = 0; i < arrayTextData.count - 1; ++i) {
//            for (int j = 0; j < [(NSArray*)arrayTextData[i] count]; ++j) {
//                NSIndexPath* cellPosition = [NSIndexPath indexPathForRow:j inSection:i];
//                UITableViewCell* cell = [tableViewMine cellForRowAtIndexPath:cellPosition];
//                cell.textLabel.textColor = [UIColor whiteColor];
//            }
//        }
//        self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1];
//
//        buttonMessage.titleLabel.textColor = [UIColor whiteColor];
//        buttonMine.titleLabel.textColor = [UIColor whiteColor];
//        buttonFriend.titleLabel.textColor = [UIColor whiteColor];
//        buttonDressup.titleLabel.textColor = [UIColor whiteColor];
//        VCDiscovery *view0 = _array[0];
//        view0.navigationController.navigationBar.barStyle = UIBarStyleBlack;
//        label1.textColor = [UIColor grayColor];
//        label2.textColor = [UIColor grayColor];
    } else {
        _nod = 0;
//        NSLog(@"off");
//        [_delegate changeToDay];
//        tableViewMine.backgroundColor = [UIColor whiteColor];
//        for (int i = 0; i < arrayTextData.count - 1; ++i) {
//            for (int j = 0; j < [(NSArray*)arrayTextData[i] count]; ++j) {
//                NSIndexPath* cellPosition = [NSIndexPath indexPathForRow:j inSection:i];
//                UITableViewCell* cell = [tableViewMine cellForRowAtIndexPath:cellPosition];
//                cell.textLabel.textColor = [UIColor blackColor];
//            }
//        }
//        self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//        buttonMessage.titleLabel.textColor = [UIColor blackColor];
//        buttonMine.titleLabel.textColor = [UIColor blackColor];
//        buttonFriend.titleLabel.textColor = [UIColor blackColor];
//        buttonDressup.titleLabel.textColor = [UIColor blackColor];
//        label1.textColor = [UIColor blackColor];
//        label2.textColor = [UIColor blackColor];
    }
 */
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        float len = self.view.bounds.size.width/4;
        messageBotton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        friendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        mineButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        derssupButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        
        messageBotton.frame = CGRectMake(0, 0, len, len);
        [messageBotton setImage:[UIImage imageNamed:@"xin.png"] forState:UIControlStateNormal];
        [messageBotton setTitle:@"我的消息" forState:UIControlStateNormal];
        
        [messageBotton setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
        [messageBotton setTitleEdgeInsets:UIEdgeInsetsMake(messageBotton.currentImage.size.height + 5, -messageBotton.currentImage.size.width, 0, 0)];
        [messageBotton setImageEdgeInsets:UIEdgeInsetsMake(-messageBotton.titleLabel.intrinsicContentSize.height - 5, 0, 0, -messageBotton.titleLabel.intrinsicContentSize.width)];
        
        //UIEdgeInsetsMake(top, left, bottom, right);
        
        friendButton.frame = CGRectMake(len, 0, len, len);
        [friendButton setImage:[UIImage imageNamed:@"haoyou.png"] forState:UIControlStateNormal];
        [friendButton setTitle:@"我的好友" forState:UIControlStateNormal];
        
        [friendButton setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
        [friendButton setTitleEdgeInsets:UIEdgeInsetsMake(friendButton.currentImage.size.height + 10, -friendButton.currentImage.size.width, 0, 0)];
        [friendButton setImageEdgeInsets:UIEdgeInsetsMake(-friendButton.titleLabel.intrinsicContentSize.height - 5, 0, 0, -friendButton.titleLabel.intrinsicContentSize.width)];
        
        mineButton.frame = CGRectMake(len * 2, 0, len, len);
        [mineButton setImage:[UIImage imageNamed:@"zhuye.png"] forState:UIControlStateNormal];
        [mineButton setTitle:@"个人主页" forState:UIControlStateNormal];
        
        [mineButton setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
        [mineButton setTitleEdgeInsets:UIEdgeInsetsMake(mineButton.currentImage.size.height + 10, -mineButton.currentImage.size.width, 0, 0)];
        [mineButton setImageEdgeInsets:UIEdgeInsetsMake(-mineButton.titleLabel.intrinsicContentSize.height - 5, 0, 0, -mineButton.titleLabel.intrinsicContentSize.width)];
        
        derssupButton.frame = CGRectMake(len * 3, 0, len, len);
        [derssupButton setImage:[UIImage imageNamed:@"zhuangban.png"] forState:UIControlStateNormal];
        [derssupButton setTitle:@"个性装扮" forState:UIControlStateNormal];
        
        [derssupButton setTintColor:[UIColor colorWithRed:0.914062 green:0.2578125 blue:0.1914062 alpha:1]];
        [derssupButton setTitleEdgeInsets:UIEdgeInsetsMake(derssupButton.currentImage.size.height + 5, -derssupButton.currentImage.size.width, 0, 0)];
        [derssupButton setImageEdgeInsets:UIEdgeInsetsMake(-derssupButton.titleLabel.intrinsicContentSize.height - 5, 0, 0, -derssupButton.titleLabel.intrinsicContentSize.width)];
        
        UIView* Function = [[UIView alloc] initWithFrame:CGRectMake(0, 0, len*4, len)];
        
        //NSLog(@"%ld",_nod);
        
//        if (_nod == 1) {
//            [buttonMessage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [buttonFriend setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [buttonMine setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//            [buttonDressup setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        } else {
            [messageBotton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [friendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [mineButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [derssupButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        }
        
        [Function addSubview: messageBotton];
        [Function addSubview: friendButton];
        [Function addSubview: mineButton];
        [Function addSubview: derssupButton];
        
        return Function;
    } else if (section == 2) {
        
        labelFirst.text = @"音乐服务";
        labelFirst.font = [UIFont systemFontOfSize:15];
        
//        if (_nod == 1) {
//            label1.textColor = [UIColor grayColor];
//        } else {
            labelFirst.textColor = [UIColor blackColor];
//        }
        viewFirst = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        [viewFirst addSubview:labelFirst];
        return viewFirst;
    } else if (section == 3){
        
        labelSecond.text = @"小工具";
        labelSecond.font = [UIFont systemFontOfSize:15];
//        if (_nod == 1) {
//            label2.textColor = [UIColor grayColor];
//        } else {
            labelSecond.textColor = [UIColor blackColor];
//        }
        UIView* viewSecond = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 60)];
        [viewSecond addSubview:labelSecond];
        return viewSecond;
    }
    return nil;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

//头部高度
-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return self.view.bounds.size.width / 4;
    } else if ((section == 3) || (section == 2)) {
        return 60;
    } else if (section == 4) {
        return 10;
    }
    
    return 0;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)pressScan {
    [mineTableView reloadData];
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
