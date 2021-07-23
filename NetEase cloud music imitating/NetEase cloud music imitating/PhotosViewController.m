//
//  ViewControllerPhotos.m
//  NetEase cloud music imitating
//
//  Created by 张博添 on 2021/7/21.
//

#import "PhotosViewController.h"

#define width self.view.bounds.size.width
#define height self.view.bounds.size.height - self.navigationController.navigationBar.bounds.size.height - self.tabBarController.tabBar.bounds.size.height - [UIApplication sharedApplication].windows.firstObject.windowScene.statusBarManager.statusBarFrame.size.height

@interface ViewControllerPhotos ()


@end
@implementation ViewControllerPhotos

@synthesize Tag;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.toolbarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择头像";
    UIBarButtonItem* rightButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(pressRightButton)];
    self.navigationItem.rightBarButtonItem = rightButton;
    UIBarButtonItem* leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"iconfont-left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(pressLeftButton)];
    self.navigationItem.leftBarButtonItem = leftButton;
    _photoWall = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    _photoWall.contentSize = CGSizeMake(width, width / 4 * 12);
    _photoWall.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    for (int i = 0; i < 4; ++i) {
        for (int j = 0; j < 8; ++j) {
            float width2 = width / 4;
            headImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
            headImageButton.frame = CGRectMake(5 + width2 * i, 5 + width2 * j, width2 - 10, width2 - 10);
            UIImage* head = [UIImage imageNamed:[NSString stringWithFormat:@"headImage%d%d.jpg", j, i]];
//获取图片名称
            [head setAccessibilityIdentifier:[NSString stringWithFormat:@"headImage%d%d.jpg", j, i]];
            [headImageButton setBackgroundImage:head forState:UIControlStateNormal];
            //NSLog(@"%@",buttonHeadImage.currentBackgroundImage.accessibilityIdentifier);
            
            
            [headImageButton addTarget:self action:@selector(pressImage:) forControlEvents:UIControlEventTouchUpInside];
            imagesArray = [[NSMutableArray alloc] init];
            
            
            [_photoWall addSubview: headImageButton];
        }
    }
    
    [self.view addSubview:_photoWall];
}
//点按“确定”按钮
- (void)pressRightButton {
    //创建警报控制器
    UIAlertController* confirmAlertController = [UIAlertController alertControllerWithTitle:@"选择头像" message:@"是否确认" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* confirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if (self->imagesArray.count != 0) {
            UIImage* headImage = self->imagesArray.firstObject;
            [self.delegate selectedPhoto:headImage number:self->imagesArray.count];
            [[NSUserDefaults standardUserDefaults] setObject: headImage.accessibilityIdentifier forKey:@"headImage"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        } else {
            [self.delegate selectedPhoto:nil number:0];
        }
        
        //[self.navigationController popViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //NSLog(@"点击了取消按钮");
    }];
    [confirmAlertController addAction: cancel];
    [confirmAlertController addAction: confirm];
    [self presentViewController:confirmAlertController animated:YES completion:nil];
}

- (void)pressLeftButton {
    if (self->imagesArray.count == 0) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else {
        UIAlertController* confirmAlertController2 = [UIAlertController alertControllerWithTitle:@"是否取消" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* confirm = [UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        }];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //NSLog(@"点击了取消按钮");
        }];
        [confirmAlertController2 addAction: cancel];
        [confirmAlertController2 addAction: confirm];
        [self presentViewController:confirmAlertController2 animated:YES completion:nil];
    }
}

- (void)pressImage:(UIButton*) imageButton {
    if (imageButton.currentBackgroundImage) {
        Tag = [[UIImageView alloc] init];
        Tag.frame = CGRectMake(width/4 - 30, 0, 20, 20);
        Tag.image = [UIImage imageNamed:@"duihao.png"];
        NSLog(@"%@",imageButton.currentBackgroundImage.accessibilityIdentifier);
        if([self->imagesArray containsObject:imageButton.currentBackgroundImage]) {
            NSLog(@"重复");
            [self->imagesArray removeObject:imageButton.currentBackgroundImage];
            [imageButton.subviews[1] removeFromSuperview];
            
        } else {
            [self->imagesArray addObject:imageButton.currentBackgroundImage];
            [imageButton addSubview: Tag];
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
