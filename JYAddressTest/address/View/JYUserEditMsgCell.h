//
//  JYUserEditMsgCell.h
//  减约
//
//  Created by 姬巧春 on 16/5/3.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JYUserEditMsgCell : UITableViewCell

// 账户ID
@property (weak, nonatomic) IBOutlet UILabel *leftNameL;

// 内容
@property (weak, nonatomic) IBOutlet UILabel *MessageL;

// 箭头
@property (weak, nonatomic) IBOutlet UIImageView *MsgarrowImage;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *conRightDis;


@end
