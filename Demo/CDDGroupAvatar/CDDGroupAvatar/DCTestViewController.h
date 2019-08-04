//
//  DCTestViewController.h
//  CDDGroupAvatar
//
//  Created by 陈甸甸 on 2019/7/28.
//Copyright © 2019 RocketsChen. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface DCTestViewController : UITableViewController

@end



@interface DCTestItem : NSObject

/* groupId */
@property (strong , nonatomic)NSString *groupId;

/* groupSource */
@property (strong , nonatomic)NSArray *groupSource;

@end


@interface DCTestCell : UITableViewCell

/* groupIamgeView */
@property (strong , nonatomic)UIImageView *groupIamgeView;

/* groupId */
@property (strong , nonatomic)UILabel *groupIdLabel;

/* cacheId */
@property (strong , nonatomic)UILabel *cacheIdLabel;

@end

