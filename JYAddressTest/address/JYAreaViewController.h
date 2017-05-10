//
//  JYAreaViewController.h
//  减约
//
//  Created by 姬巧春 on 16/5/24.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDisplayProvince 0
#define kDisplayCity 1
#define kDisplayArea 2

@interface JYAreaViewController : UIViewController

@property (nonatomic,assign)int displayType;

@property(nonatomic,strong)NSString *selectedProvince;//选中的省
@property(nonatomic,strong)NSString *selectedCity;//选中的市
@property(nonatomic,strong)NSString *selectedArea;//选中的区

@end
