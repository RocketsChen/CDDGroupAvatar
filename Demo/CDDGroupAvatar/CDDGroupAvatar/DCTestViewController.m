//
//  DCTestViewController.m
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/28.
//Copyright © 2019 RocketsChen. All rights reserved.
//

#import "DCTestViewController.h"
#import "UIImageView+DCGroup.h"
#import "DCAvatarManager.h"

@interface DCTestViewController ()

@property (strong , nonatomic)NSMutableArray <DCTestItem *>*groupArray;

@end

@implementation DCTestViewController

- (NSMutableArray<DCTestItem *> *)groupArray
{
    if (!_groupArray) {
        _groupArray = [NSMutableArray array];
    }
    return _groupArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setUpGroupData];
    
    
    [DCAvatarManager sharedAvatar].distanceBetweenAvatar = 2;
    [DCAvatarManager sharedAvatar].groupAvatarType = DCGroupAvatarWeChatType;
    
    self.tableView.rowHeight = 80;
    [self.tableView registerClass:[DCTestCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DCTestCell class])]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"clean" style:UIBarButtonItemStyleDone target:self action:@selector(clean)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor blackColor]];

    
//    for (NSInteger i = 0; i < 100; ++i) { // 暴力测试刷新数据
//        @weakify(self);
//        [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeAll completion:^{
//            @strongify(self);
//            [self.tableView reloadData];
//            NSLog(@"-index--------%zd",i);
//        }];
//    }
}


- (void)clean
{
    @ga_weakify(self);
    [[SDImageCache sharedImageCache] clearWithCacheType:SDImageCacheTypeAll completion:^{
        @ga_strongify(self);
        [self.tableView reloadData];
    }];
}

- (void)setUpGroupData
{
    
    [DCAvatarManager sharedAvatar].baseUrl = @"http://ww1.sinaimg.cn/small/";
    
    for (NSInteger i = 0; i < 3 * 8; ++i) {
        DCTestItem *item = [DCTestItem new];
        item.groupId = [NSString stringWithFormat:@"群头id-%zd",i];
        
        NSInteger index = i / 8;
        NSInteger count = i % 8;
        
        item.groupSource = [[self allArray][index] subarrayWithRange:NSMakeRange(0, MIN(((NSArray *)[self allArray][index]).count, count + 2))];
        
        [self.groupArray addObject:item];
    }
}


- (NSArray *)allArray
{
    return @[@[@"006tNc79gy1g5fmoexlt6j30u00vxqrb.jpg",@"006tNc79gy1g5fmofi07aj30u00uwqqk.jpg",@"006tNc79gy1g5fln5crn5j30u00u00vh.jpg",@"006tNc79gy1g5fln52xz8j30u00u0411.jpg",@"006tNc79gy1g5fmtvyydxj30u00u0x6r.jpg",@"006tNc79gy1g5fmogr9fsj30u00uz4m9.jpg",@"006tNc79gy1g5fmogcjidj30u00wc7su.jpg",@"006tNc79gy1g5fmofvp9cj30u00w8kft.jpg",@"006tNc79gy1g5fmofvp9cj30u00w8kft.jpg"],@[@"006tNc79gy1g5fln52xz8j30u00u0411.jpg",@"006tNc79gy1g5fln5crn5j30u00u00vh.jpg",@"006tNc79gy1g5fli2qszgj30ku0ii0ua.jpg",@"006tNc79gy1g5fli1g0wtj30rs0rs416.jpg",@"006tNc79gy1g5fli2zfzwj30qo0qojvv.jpg",@"006tNc79gy1g5fli3fr0oj30u00u2goh.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g56mcmorgrj30rk0nm0ze.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg"],@[@"006tNc79gy1g57hfrnhe6j30u00w01eu.jpg",@"006tNc79gy1g56or92vvmj30u00u048a.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"无效地址头像",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg",@"无效地址头像",@"006tNc79gy1g5fli2j5x4j30u00u2ack.jpg",@"006tNc79gy1g5fli3fr0oj30u00u2goh.jpg",@"006tNc79gy1g57h4j42ppj30u00u00vy.jpg"]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groupArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DCTestCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DCTestCell class])] forIndexPath:indexPath];
 
    DCTestItem *item = self.groupArray[indexPath.row];
    
    [cell.groupIamgeView dc_setImageAvatarWithGroupId:item.groupId Source:item.groupSource completed:^(NSString *groupId, UIImage *groupImage, NSArray<UIImage *> *itemImageArray, NSString *cacheId) {
        cell.cacheIdLabel.text = [NSString stringWithFormat:@"缓存id-%@",cacheId];
    }];
    
//    [cell.groupIamgeView dc_setImageAvatarWithGroupId:item.groupId Source:item.groupSource itemPlaceholder:nil options:DCGroupAvatarCachedRefresh completed:^(NSString *groupId, UIImage *groupImage, NSArray<UIImage *> *itemImageArray, NSString *cacheId) {
//        cell.cacheIdLabel.text = [NSString stringWithFormat:@"缓存id-%@",cacheId];
//    }];

    cell.groupIdLabel.text = item.groupId;
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end




@implementation DCTestItem


@end



@implementation DCTestCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpUI];
    }
    return self;
}


- (void)setUpUI
{
    _groupIamgeView = [[UIImageView alloc] init];
    [self.contentView addSubview:_groupIamgeView];
    _groupIamgeView.frame = CGRectMake(12, 10, 60, 60);
    
    
    _groupIdLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_groupIdLabel];
    _groupIdLabel.font = [UIFont systemFontOfSize:18];
    
    
    _cacheIdLabel = [[UILabel alloc] init];
    [self.contentView addSubview:_cacheIdLabel];
    _cacheIdLabel.textColor = [UIColor lightGrayColor];
    _cacheIdLabel.font = [UIFont systemFontOfSize:15];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    _groupIdLabel.frame = CGRectMake(CGRectGetMaxX(_groupIamgeView.frame) + 10, 10, self.frame.size.width - (CGRectGetMaxX(_groupIamgeView.frame) + 30), 30);
    _cacheIdLabel.frame = CGRectMake(CGRectGetMaxX(_groupIamgeView.frame) + 10, CGRectGetMaxY(_groupIdLabel.frame) + 4, self.frame.size.width - (CGRectGetMaxX(_groupIamgeView.frame) + 30), 20);
}

@end
