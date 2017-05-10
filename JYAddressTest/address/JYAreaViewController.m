//
//  JYAreaViewController.m
//  减约
//
//  Created by 姬巧春 on 16/5/24.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import "JYAreaViewController.h"

#import "JYMyAddressViewController.h"

#import "JYUserEditMsgCell.h"

#import "UIColor+JYColor.h"
#import "UIImage+JYImageTool.h"

@interface JYAreaViewController () <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *table;

@property (nonatomic,strong)NSArray *dicArrray;

@property(nonatomic,strong)NSMutableArray *provinces;
@property(nonatomic,strong)NSArray *citys;
@property(nonatomic,strong)NSArray *areas;
@property(nonatomic,assign)int selectProvinceIndex;

@end

@implementation JYAreaViewController


-(void)viewDidLoad{
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 初始化
    [self setupNav];
    
    [self configureData];
    
    [self configureViews];
}

- (void)setupNav{
    self.navigationController.title = @"地区";
}


-(void)configureData{
    
    self.provinces = [NSMutableArray array];
    self.dicArrray = [NSArray array];
    
    if (self.displayType == kDisplayProvince) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"zh_CN" ofType:@"json"];
        NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
        self.dicArrray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        for (int i = 0; i < self.dicArrray.count; i++) {
            [self.provinces addObject:self.dicArrray[i][@"name"]];
        }
        
        NSLog(@"%@",self.provinces);
        
        
        if (self.selectedProvince.length>0) {
            for (int i = 0; i<self.provinces.count; i++) {
                if ([self.provinces[i] isEqualToString:self.selectedProvince]) {
                    [self.provinces removeObjectAtIndex:i];
                    [self.provinces insertObject:self.selectedProvince atIndex:0];
                    break;
                }
            }
        }
        
    }
    
}

-(void)configureViews{
    self.table = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.table];
    self.table.backgroundColor = [UIColor colorWithHexString:@"#F2F2F2"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.showsVerticalScrollIndicator = NO;
    self.table.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.displayType == kDisplayProvince) {
        return self.provinces.count;
    }else if (self.displayType == kDisplayCity){
        return self.citys.count;
    }else{
        return self.areas.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 51;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *otherIdentifier = @"addressIdentifier";
    
    JYUserEditMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:
                               otherIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"JYUserEditMsgCell" owner:self options:nil]lastObject];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageWithColor:[UIColor colorWithHexString:@"#EDEDED"]]];
    }
    
    cell.leftNameL.textColor = [UIColor colorWithHexString:@"#544C57"];
    cell.MessageL.textColor = [UIColor colorWithHexString:@"#888888"];
    
    if (self.displayType == kDisplayProvince) {
        
        cell.leftNameL.text = self.provinces[indexPath.row];
        if ([self.provinces[indexPath.row] isEqualToString:self.selectedProvince]) {
            cell.MessageL.text = @"已选地区";
        }else{
            cell.MessageL.text = @"";
        }
        if ([self.provinces[indexPath.row] isEqualToString:@"中国"]) {
            cell.MsgarrowImage.hidden = NO;
        }else{
            cell.MsgarrowImage.hidden = YES;
        }
        
    }else if (self.displayType == kDisplayCity){
        NSDictionary *city = self.citys[indexPath.row];
        NSString *cityName = [city objectForKey:@"name"];
        cell.leftNameL.text = cityName;
        cell.MessageL.text = @"";
        cell.MsgarrowImage.hidden = NO;
    }else{
        NSDictionary *area = self.areas[indexPath.row];
        NSString *areaName = [area objectForKey:@"name"];
        cell.leftNameL.text = areaName;
        cell.MessageL.text = @"";
        cell.MsgarrowImage.hidden = YES;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.displayType == kDisplayProvince) {
        
        if ([self.selectedProvince isEqualToString:@"中国"] || self.selectedProvince.length == 0) {
            if (indexPath.row == 0) {
                
                NSDictionary *province = self.dicArrray[0];
                NSMutableArray *citys = [province objectForKey:@"children"];
                self.selectedProvince = [province objectForKey:@"name"];
                
                if (self.selectedCity.length>0) {
                    for (int i = 0; i<citys.count; i++) {
                        
                        if ([citys[i][@"name"] isEqualToString:self.selectedCity]) {
                            NSDictionary *tempDic = citys[i];
                            [citys removeObjectAtIndex:i];
                            [citys insertObject:tempDic atIndex:0];
                            break;
                        }
                        
                    }
                }
                
                //构建下一级视图控制器
                JYAreaViewController *cityVC = [[JYAreaViewController alloc]init];
                cityVC.displayType = kDisplayCity;//显示模式为城市
                cityVC.citys = citys;
                cityVC.selectedProvince = self.selectedProvince;
                cityVC.selectedCity = self.selectedCity;
                cityVC.selectedArea = self.selectedArea;
                [self.navigationController pushViewController:cityVC animated:YES];
                
            }else{ // 别的国家
                self.selectedProvince = self.provinces[indexPath.row];
#pragma - mark 根据需要改动self.navigationController.viewControllers[0]
                JYMyAddressViewController *vc = self.navigationController.viewControllers[0];
                vc.address = self.selectedProvince;
                [self.navigationController popToViewController:vc animated:YES];
                
                // 上传地址信息
//                [self modifyUserMessageCountry:self.selectedProvince andProvince:nil andCity:nil];
                
            }
        }else{
            if (indexPath.row == 1) {
                
                NSDictionary *province = self.dicArrray[0];
                NSMutableArray *citys = [province objectForKey:@"children"];
                self.selectedProvince = [province objectForKey:@"name"];
                
                if (self.selectedCity.length>0) {
                    for (int i = 0; i<citys.count; i++) {
                        
                        if ([citys[i][@"name"] isEqualToString:self.selectedCity]) {
                            NSDictionary *tempDic = citys[i];
                            [citys removeObjectAtIndex:i];
                            [citys insertObject:tempDic atIndex:0];
                            break;
                        }
                        
                    }
                }
                
                //构建下一级视图控制器
                JYAreaViewController *cityVC = [[JYAreaViewController alloc]init];
                cityVC.displayType = kDisplayCity;//显示模式为城市
                cityVC.citys = citys;
                cityVC.selectedProvince = self.selectedProvince;
                cityVC.selectedCity = self.selectedCity;
                cityVC.selectedArea = self.selectedArea;
                [self.navigationController pushViewController:cityVC animated:YES];
                
            }else{
                self.selectedProvince = self.provinces[indexPath.row];
                
#pragma - mark 根据需要改动self.navigationController.viewControllers[0]
                JYMyAddressViewController *vc = self.navigationController.viewControllers[0];
                vc.address = self.selectedProvince;
                [self.navigationController popToViewController:vc animated:YES];
                
                // 上传地址信息
//                [self modifyUserMessageCountry:self.selectedProvince andProvince:nil andCity:nil];
            }
        }
    }else if (self.displayType == kDisplayCity){
        NSDictionary *city = self.citys[indexPath.row];
        self.selectedCity = [city objectForKey:@"name"];
        NSMutableArray *areas = [city objectForKey:@"children"];
        
        if (self.selectedArea.length>0) {
            for (int i = 0; i<areas.count; i++) {
                if ([areas[i][@"name"] isEqualToString:self.selectedArea]) {
                    NSDictionary *tempDic = areas[i];
                    [areas removeObjectAtIndex:i];
                    [areas insertObject:tempDic atIndex:0];
                    break;
                }
            }
        }
        
        //构建下一级视图控制器
        JYAreaViewController *areaVC = [[JYAreaViewController alloc]init];
        areaVC.displayType = kDisplayArea;//显示模式为区域
        areaVC.areas = areas;
        areaVC.selectedCity = self.selectedCity;
        areaVC.selectedProvince = self.selectedProvince;
        [self.navigationController pushViewController:areaVC animated:YES];
    }
    else{
        NSDictionary *selectSreaDic = self.areas[indexPath.row];
        self.selectedArea = selectSreaDic[@"name"];
        
#pragma - mark 根据需要改动self.navigationController.viewControllers[0]
        JYMyAddressViewController *vc = self.navigationController.viewControllers[0];
        vc.address = [NSString stringWithFormat:@"%@-%@-%@",self.selectedProvince,self.selectedCity,self.selectedArea];
        [self.navigationController popToViewController:vc animated:YES];
        
        // 上传地址信息
//        [self modifyUserMessageCountry:self.selectedProvince andProvince:self.selectedCity andCity:self.selectedArea];
    }
}


//#pragma mark - 修改用户数据
//-(void)modifyUserMessageCountry:(NSString *)country andProvince:(NSString *)province andCity:(NSString *)city{
//    
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    
//    [param JYSetObject:@"6,7,8" forKey:@"editType"];
//    [param JYSetObject:country forKey:@"country"];
//    [param JYSetObject:province forKey:@"province"];
//    [param JYSetObject:city forKey:@"city"];
//    
//    [JYHTTPClient POST:@"/app/3000000/user/info/update.do" parameters:param success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
//        
//        
//    } failure:^(NSURLSessionDataTask *task, NSError *error) {
//        NSLog(@"%@",error);
//    }];
//    
//}

@end
