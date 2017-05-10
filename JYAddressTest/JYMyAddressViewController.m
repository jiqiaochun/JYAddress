//
//  JYMyAddressViewController.m
//  JYAddressTest
//
//  Created by 姬巧春 on 16/6/15.
//  Copyright © 2016年 姬巧春. All rights reserved.
//

#import "JYMyAddressViewController.h"

#import "JYAreaViewController.h"

@interface JYMyAddressViewController ()

@property (nonatomic,strong) UIButton *btn;

@property(nonatomic,strong)NSString *selectedCountry;//选中的国家
@property(nonatomic,strong)NSString *selectedProvince;//选中的省
@property(nonatomic,strong)NSString *selectedCity;//选中的城市
@end

@implementation JYMyAddressViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    if (self.address.length != 0) {
        NSArray *addressArray = [self.address componentsSeparatedByString:@"-"];
        NSString *needAdd = @"";
        if (addressArray.count == 1) {
            self.selectedCountry = addressArray[0];
            needAdd = self.selectedCountry;
        }else{
            self.selectedCountry = addressArray[0];
            self.selectedProvince = addressArray[1];
            self.selectedCity = addressArray[2];
            needAdd = [NSString stringWithFormat:@"%@ %@",self.selectedProvince,self.selectedCity];
        }
        [self.btn setTitle:needAdd forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    self.btn = btn;
}

- (void)btnClick:(UIButton *)btn{
    JYAreaViewController *vc = [[JYAreaViewController alloc] init];
    vc.displayType = kDisplayProvince;
    vc.selectedProvince = self.selectedCountry;
    vc.selectedCity = self.selectedProvince;
    vc.selectedArea = self.selectedCity;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
