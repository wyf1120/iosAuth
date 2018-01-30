//
//  setController.m
//  anQuanTong
//
//  Created by 吴宇飞 on 17/6/16.
//  Copyright © 2017年 gyd. All rights reserved.
//

#import "setController.h"
#include "setCell.h"
#include "setCell3.h"
#import "loginController.h"
@interface setController ()<UITableViewDelegate,UITableViewDataSource>
{
    double totalSize;
    NSString *cacheStr;
}
@property (nonatomic, strong) UIButton *quitBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *cacheLab;
@end

@implementation setController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"Signin_jt"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, 0, 20*WIDTH, 20*WIDTH);
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.title = @"设置";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19]
       }];
    [self configUI];
    
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfoDic = [defaults objectForKey:@"userInfo"];
    
    if (userInfoDic) {
        [_quitBtn setImage:[UIImage imageNamed:@"Setup_tc"] forState:UIControlStateNormal];
    }
    else
    {
        [_quitBtn setImage:[UIImage imageNamed:@"Setup_tc1"] forState:UIControlStateNormal];
    }
}

-(void)leftBtnClick
{
    [self.delegate loginSuccess];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)configUI
{
    UITableView *tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView = tableview;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc] init];
    [tableview registerClass:[setCell class] forCellReuseIdentifier:@"cell"];
    [tableview registerClass:[setCell3 class] forCellReuseIdentifier:@"cell2"];
    [self.view addSubview:tableview];
    
    UIButton *quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _quitBtn = quitBtn;
    [quitBtn addTarget:self action:@selector(quitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    quitBtn.frame = CGRectMake(20*WIDTH, 250*HEIGHT, 280*WIDTH, 45*HEIGHT);
    [self.view addSubview:quitBtn];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfoDic = [defaults objectForKey:@"userInfo"];
    
    if (userInfoDic) {
    [quitBtn setImage:[UIImage imageNamed:@"Setup_tc"] forState:UIControlStateNormal];
    }
    else
    {
        [quitBtn setImage:[UIImage imageNamed:@"Setup_tc1"] forState:UIControlStateNormal];
    }
    
}

-(void)quitBtnClick
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userInfoDic = [defaults objectForKey:@"userInfo"];
    if (userInfoDic) {
        [defaults setValue:nil forKey:@"userInfo"];
        [defaults synchronize];
        [_quitBtn setImage:[UIImage imageNamed:@"Setup_tc1"] forState:UIControlStateNormal];
        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"您已推出登录"];
        //AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    }
    else
    {
        loginController *lvc = [[loginController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        setCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.textLab.text = @"更换账号";
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else if (indexPath.row == 1)
    {
        setCell3 *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        _cacheLab = cell.cacheLab;
        return cell;
    }
    UITableViewCell *cell;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40*HEIGHT;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        
        if ([_cacheLab.text isEqualToString:@"0.2M"]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                _cacheLab.text = @"0.0M";
                [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"清除缓存0.2M"];
            });
        }
    }
    else
    {
        loginController *lvc = [[loginController alloc] init];
        [self presentViewController:lvc animated:YES completion:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
