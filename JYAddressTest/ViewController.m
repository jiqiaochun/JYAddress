//
//  ViewController.m
//  JYAddressTest
//
//  Created by 姬巧春 on 16/6/15.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "ViewController.h"

#import "JYMyAddressViewController.h"


@interface ViewController ()

@property (nonatomic,strong) UIButton *btn;

@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

- (void)btnClick:(UIButton *)btn{
    JYMyAddressViewController *vc = [[JYMyAddressViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
