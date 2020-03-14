//
//  ViewController.m
//  CDDGroupAvatar
//
//  Imageed by 陈甸甸 on 2019/7/18.
//  Copyright © 2019 RocketsChen. All rights reserved.
//

#import "ViewController.h"
#import "DCAvatar.h"
#import "DCCacheAvatarHelper.h"
#import "DCNoCacheAvatar.h"
#import <SDWebImage.h>

#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "DCTestViewController.h"

@interface ViewController ()
{
    NSArray *_groupNum2;
    NSArray *_groupNum3;
    NSArray *_groupNum4;
    NSArray *_groupNum5;
    NSArray *_groupNum6;
    NSArray *_groupNum7;
    NSArray *_groupNum8;
    NSArray *_groupNum9;
}

// Button
@property (weak, nonatomic) IBOutlet UIButton *avaButton;
@property (weak, nonatomic) IBOutlet UIButton *avaBgButton;


// QQ
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewNQ2;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewNQ3;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewNQ4;

// WeBo
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewWeiBo2;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewWeiBo3;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewWeiBo4;

// WeChat
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW2;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW3;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW4;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW5;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW6;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW7;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW8;
@property (weak, nonatomic) IBOutlet UIImageView *avImageViewW9;



// NoCache
@property (weak, nonatomic) IBOutlet UIImageView *ncImageViewW3;
@property (weak, nonatomic) IBOutlet UIImageView *ncImageViewW4;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpNav];

    [self setUpDataSource];

    [self setUpLoadData];

    [self setUpGetAllItemAva];

    
    [self setUpNoCache];

}


- (void)setUpNav
{
    self.title = @"CDDGroupAvatar";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"table" style:UIBarButtonItemStyleDone target:self action:@selector(goToTest)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"clean" style:UIBarButtonItemStyleDone target:self action:@selector(clean)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor blackColor]];
}


- (void)clean
{
    @ga_weakify(self);
    [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeAll completion:^{
        @ga_strongify(self);
        [self setUpLoadData];
    }];
}



- (void)setUpNoCache
{
    
    [self.ncImageViewW3 dc_setNoCacheImageAvatarWithGroupId:@"avImageViewW3" Source:@[[UIImage imageNamed:@"noCache1"],[UIImage imageNamed:@"noCache2"],[UIImage imageNamed:@"noCache3"]] completed:^(NSString *groupId, UIImage *groupImage, NSArray<UIImage *> *itemImageArray, NSString *cacheId) {
        NSLog(@"groupId：%@ -- 群头像：%@ 群内拼接小头像数组：%@ -- cacheId：%@",groupId, groupImage, itemImageArray , cacheId);
    }];

    [self.ncImageViewW4 dc_setNoCacheImageAvatarWithGroupId:@"avImageViewW4" Source:@[[UIImage imageNamed:@"noCache1"],[UIImage imageNamed:@"noCache2"],[UIImage imageNamed:@"noCache3"],[UIImage imageNamed:@"noCache4"]]];
}



- (void)setUpGetAllItemAva
{
    NSArray *itemImages = [DCCacheAvatarHelper dc_synfetchLoadImageSource:_groupNum8 itemPlaceholder:nil];
    [DCCacheAvatarHelper dc_asynfetchLoadImageSource:_groupNum9 itemPlaceholder:nil completedBlock:^(NSArray<UIImage *> *unitImages) {
        
    }];
    NSLog(@"群内小头像数组%@",itemImages);
}


- (void)setUpLoadData
{
    [DCAvatarManager sharedAvatar].baseUrl = @"http://ww1.sinaimg.cn/small/";
    [DCAvatarManager sharedAvatar].placeholderImage = [UIImage imageNamed:@"avatarholder"];

    [self setUpWeChat];

    [self setUpWeiBo];

    [self setUpNewQQ];

    [self setUpTestButton];
}


- (void)setUpWeiBo
{
    [DCAvatarManager sharedAvatar].groupAvatarType = DCGroupAvatarWeiBoType;
    [DCAvatarManager sharedAvatar].distanceBetweenAvatar = 2;
    
    [self.avImageViewWeiBo2 dc_setImageAvatarWithGroupId:@"avImageViewWeiBo2" Source:_groupNum2];
    [self.avImageViewWeiBo3 dc_setImageAvatarWithGroupId:@"avImageViewWeiBo3" Source:_groupNum3];
    [self.avImageViewWeiBo4 dc_setImageAvatarWithGroupId:@"avImageViewWeiBo4" Source:_groupNum4];
    
}

- (void)setUpTestButton
{
    [DCAvatarManager sharedAvatar].distanceBetweenAvatar = 2;
    [DCAvatarManager sharedAvatar].groupAvatarType = DCGroupAvatarWeChatType;

    [self.avaButton dc_setImageAvatarWithGroupId:@"avaButton" Source:_groupNum9 forState:0];
    [self.avaBgButton dc_setBackgroundImageAvatarWithGroupId:@"avaBgButton" Source:@[@"006tNc79gy1g5fmoexlt6j30u00vxqrb.jpg"] forState:0];
}



- (void)setUpNewQQ
{
    [DCAvatarManager sharedAvatar].distanceBetweenAvatar = 1;
    [DCAvatarManager sharedAvatar].groupAvatarType = DCGroupAvatarQQType;
    [self.avImageViewNQ2 dc_setImageAvatarWithGroupId:@"avImageViewNQ2" Source:_groupNum2];

    [self.avImageViewNQ3 dc_setImageAvatarWithGroupId:@"avImageViewNQ3" Source:_groupNum3];
    
    [self.avImageViewNQ4 dc_setImageAvatarWithGroupId:@"avImageViewNQ4" Source:_groupNum4];

}


- (void)setUpWeChat
{
    [DCAvatarManager sharedAvatar].distanceBetweenAvatar = 2;
    [DCAvatarManager sharedAvatar].groupAvatarType = DCGroupAvatarWeChatType;

    // 传入无效地址测试 Placeholder属性
    [self.avImageViewW2 dc_setImageAvatarWithGroupId:@"avImageViewW2" Source:@[@"1",@"2"] itemPlaceholder:@[@"man",@"woman"] options:0 completed:nil];

    [self.avImageViewW3 dc_setImageAvatarWithGroupId:@"avImageViewW3" Source:_groupNum3];

    // options == DCGroupAvatarCachedRefresh  每次都刷新
    [self.avImageViewW4 dc_setImageAvatarWithGroupId:@"avImageViewW4" Source:_groupNum4 itemPlaceholder:@"place" options:DCGroupAvatarCachedRefresh completed:nil];

    [self.avImageViewW5 dc_setImageAvatarWithGroupId:@"avImageViewW5" Source:_groupNum5];
    [self.avImageViewW6 dc_setImageAvatarWithGroupId:@"avImageViewW6" Source:_groupNum6];
    [self.avImageViewW7 dc_setImageAvatarWithGroupId:@"avImageViewW7" Source:_groupNum7];
    [self.avImageViewW8 dc_setImageAvatarWithGroupId:@"avImageViewW8" Source:_groupNum8];

    [self.avImageViewW9 dc_setImageAvatarWithGroupId:@"avImageViewW9" Source:_groupNum9 completed:^(NSString *groupId, UIImage *groupImage, NSArray<UIImage *> *itemImageArray, NSString *cacheId) {
        NSLog(@"groupId：%@ -- 群头像：%@ 群内拼接小头像数组：%@ -- cacheId：%@",groupId, groupImage, itemImageArray , cacheId);
    }];
}

#pragma mark - 数据源
- (void)setUpDataSource
{
    _groupNum2 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg"];
    
    _groupNum3 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg"];
    
    _groupNum4 = @[@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg"];
    
    _groupNum5 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg"];
    
    _groupNum6 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg"];
    
    _groupNum7 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg"];
    
    _groupNum8 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg"];
    
    
    _groupNum9 = @[@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self setUpLoadData];
}

- (void)goToTest
{
    [self.navigationController pushViewController:[DCTestViewController new] animated:YES];
}

@end
