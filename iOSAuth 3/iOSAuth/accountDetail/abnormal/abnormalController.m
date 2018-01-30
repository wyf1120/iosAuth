//
//  abnormalController.m
//  iOSAuth
//
//  Created by wyf on 2018/1/22.
//  Copyright © 2018年 Aran. All rights reserved.
//

#import "abnormalController.h"
//#import "abnormalCell.swift"
#import "normalAccountCell.h"
@interface abnormalController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)BOOL isFirst;
@end

@implementation abnormalController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self configUI];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    if (!_isFirst) {
        [self configUI];
        _isFirst = YES;
    }
}

-(void)configUI
{
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-104) style:UITableViewStylePlain];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [UIView new];
    [tableview registerClass:[abnormalCell class] forCellReuseIdentifier:@"cell"];
    [tableview registerClass:[barChartCell class] forCellReuseIdentifier:@"barCell"];
    [tableview registerClass:[normalAccountCell class] forCellReuseIdentifier:@"normalCell"];
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        abnormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else if (indexPath.row == 1)
    {
        barChartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"barCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell configBarChartWithYData:@[@10,@4,@20]];
        return cell;
    }
    else
    {
        normalAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"normalCell" forIndexPath:indexPath];
        cell.img.image = [UIImage imageNamed:@"abnormal"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 170;
    }
    else if (indexPath.row == 1)
    {
        return 250;
    }
    else
    {
        return 155*HEIGHT;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 1) {
        abnormalDetailController *avc = [[abnormalDetailController alloc] init];
        [self.navigationController pushViewController:avc animated:YES];
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
