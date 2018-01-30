//
//  loginController.m
//  anQuanTong
//
//  Created by 吴宇飞 on 17/6/9.
//  Copyright © 2017年 gyd. All rights reserved.
//

#import "loginController.h"

@interface loginController ()
@property (nonatomic, strong) UITextField *phoneNumTextfield;
@property (nonatomic, strong) UITextField *yzmTextfield;
@property (nonatomic, strong) UIButton *yzmBtn;
@property (nonatomic, copy) NSString *yzmStr;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation loginController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏=YES,显示=NO; Animation:动画效果
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}
//退出时显示
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //隐藏=YES,显示=NO; Animation:动画效果
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

-(void)configUI
{
    keyboardToolView *keyView = [[keyboardToolView alloc] init];
    [keyView.finishBtn addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *backImgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backImgView.userInteractionEnabled = YES;
    //backImgView.backgroundColor = [UIColor orangeColor];
    backImgView.image = [UIImage imageNamed:@"Signin_bj"];
    [self.view addSubview:backImgView];
    
    UIView *topBackView = [[UIView alloc] init];
    topBackView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.3];
    topBackView.alpha = 1;
    [backImgView addSubview:topBackView];
    
    UILabel *loginLab = [[UILabel alloc] init];
    loginLab.text = @"登录";
    loginLab.textAlignment = NSTextAlignmentCenter;
    loginLab.font = [UIFont systemFontOfSize:16];
    [topBackView addSubview:loginLab];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn addTarget:self action:@selector(backBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [topBackView addSubview:backBtn];
    
    if ([_loginSuccess isEqualToString:@"yes"]) {
        [backBtn setImage:[UIImage imageNamed:@"Signin_jt"] forState:UIControlStateNormal];
    }
    
    UIImageView *topLogImg = [[UIImageView alloc] init];
    topLogImg.image = [UIImage imageNamed:@"Signin_aqydt"];
    [backImgView addSubview:topLogImg];
    
    UIView *backView = [[UIView alloc] init];
    backView.layer.cornerRadius = 3;
    backView.layer.cornerRadius = YES;
    backView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    backView.alpha = 1;
    [backImgView addSubview:backView];
    
    UIImageView *leftImg = [[UIImageView alloc] init];
    leftImg.image = [UIImage imageNamed:@"Signin_tel"];
    [backView addSubview:leftImg];
    
    UITextField *phoneNumtext = [[UITextField alloc] init];
    _phoneNumTextfield = phoneNumtext;
    phoneNumtext.inputAccessoryView = keyView;
    phoneNumtext.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumtext.userInteractionEnabled = YES;
    phoneNumtext.keyboardType = UIKeyboardTypeNumberPad;
    //[phoneNumtext becomeFirstResponder];
    phoneNumtext.placeholder = @"输入手机号";
    //phoneNumtext.backgroundColor = [UIColor redColor];
    phoneNumtext.font = [UIFont systemFontOfSize:13];
    [backView addSubview:phoneNumtext];
    
    
    
    
    //验证码输入
    UIView *backView1 = [[UIView alloc] init];
    backView1.layer.cornerRadius = 3;
    backView1.layer.cornerRadius = YES;
    backView1.backgroundColor = [UIColor colorWithWhite:1 alpha:0.6];
    backView1.alpha = 1;
    [backImgView addSubview:backView1];
    
    UIImageView *leftImg1 = [[UIImageView alloc] init];
    leftImg1.image = [UIImage imageNamed:@"Signin_yzm"];
    [backView1 addSubview:leftImg1];
    
    UITextField *phoneNumtext1 = [[UITextField alloc] init];
    _yzmTextfield = phoneNumtext1;
    phoneNumtext1.inputAccessoryView = keyView;
    phoneNumtext1.clearButtonMode = UITextFieldViewModeWhileEditing;
    phoneNumtext1.userInteractionEnabled = YES;
    phoneNumtext1.keyboardType = UIKeyboardTypeNumberPad;
    //[phoneNumtext becomeFirstResponder];
    phoneNumtext1.placeholder = @"输入密码";
    //phoneNumtext.backgroundColor = [UIColor redColor];
    phoneNumtext1.font = [UIFont systemFontOfSize:13];
    [backView1 addSubview:phoneNumtext1];
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    loginBtn.backgroundColor = [UIColor colorWithRed:253.0/255 green:65.0/255 blue:64.0/255 alpha:1];
    loginBtn.layer.cornerRadius = 3;
    loginBtn.layer.masksToBounds = YES;
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backImgView addSubview:loginBtn];
    
    
    [topBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40*HEIGHT));
    }];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*WIDTH);
        make.centerY.mas_equalTo(topBackView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20*WIDTH, 20*WIDTH));
    }];
    
    [loginLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(backBtn.mas_centerY);
        make.centerX.mas_equalTo(topBackView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    [topLogImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topBackView.mas_bottom).offset(53*HEIGHT);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(70*WIDTH, 70*WIDTH));
    }];
    
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLogImg.mas_bottom).offset(60*HEIGHT);
        make.left.mas_equalTo(32*WIDTH);
        make.size.mas_equalTo(CGSizeMake(256*HEIGHT, 36*WIDTH));
    }];
    
    [leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*WIDTH);
        make.centerY.mas_equalTo(backView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(21*WIDTH, 24*HEIGHT));
    }];
    
    
    [phoneNumtext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImg.mas_right).offset(10*WIDTH);
        make.centerY.mas_equalTo(leftImg.mas_centerY);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(25*HEIGHT);
    }];
    
    [backView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView.mas_bottom).offset(10*HEIGHT);
        make.left.mas_equalTo(32*WIDTH);
        make.size.mas_equalTo(CGSizeMake(256*HEIGHT, 36*WIDTH));
    }];
    
    [leftImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10*WIDTH);
        make.centerY.mas_equalTo(backView1.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(21*WIDTH, 24*HEIGHT));
    }];
    
    [phoneNumtext1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(leftImg1.mas_right).offset(10*WIDTH);
        make.centerY.mas_equalTo(leftImg1.mas_centerY);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(25*HEIGHT);
    }];
    
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(backView1.mas_bottom).offset(30*HEIGHT);
        make.left.mas_equalTo(backView1.mas_left);
        make.size.mas_equalTo(CGSizeMake(256*WIDTH, 36*HEIGHT));
    }];
    
}

-(void)loginBtnClick
{
    if ([_phoneNumTextfield.text isEqualToString:@""] || [_yzmTextfield.text isEqualToString:@""]) {
        [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"手机号或密码不能为空"];
    }
    else
    {
        if ([self isMobileNumber:_phoneNumTextfield.text]) {
            [[NSUserDefaults standardUserDefaults] setObject:@"loginSuccess" forKey:@"loginSuccess"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self.delegate loginvcDel];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [[DMCAlertCenter defaultCenter] postAlertWithMessage:@"请输入正确的手机号码"];
        }
    }
    
}

-(void)finishBtnClick
{
    [self.view endEditing:YES];
}

-(void)backBtnClick
{
    [self.delegate loginvcDel];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(BOOL)isMobileNumber:(NSString *)mobileNum
{
    if (mobileNum.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
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
