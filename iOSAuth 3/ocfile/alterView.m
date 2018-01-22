//
//  alterView.m
//  gydApp
//
//  Created by 吴宇飞 on 16/8/23.
//  Copyright © 2016年 gyd. All rights reserved.
//

#import "alterView.h"
#import "Masonry.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WIDTH [UIScreen mainScreen].bounds.size.width/320
#define HEIGHT [UIScreen mainScreen].bounds.size.height/568
#define ksWidth [UIScreen mainScreen].bounds.size.width
#define ksHeight [UIScreen mainScreen].bounds.size.height

@implementation alterView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configUI];
        
       
    }
    return self;
}


-(void)configUI
{
    UIView *alertView = [[UIView alloc] init];
    _alertView = alertView;
    //alertView.bounds = CGRectMake(0, 0, SCREEN_WIDTH-60*WIDTH, (SCREEN_WIDTH-60*WIDTH)*0.7);
    alertView.center = self.center;
    alertView.backgroundColor = [UIColor colorWithRed:81/255.0 green:153/255.0 blue:230/255.0 alpha:1.0];
    alertView.layer.cornerRadius = 7;
    alertView.layer.masksToBounds = YES;
    [self addSubview:alertView];
    
    UILabel *titLab = [[UILabel alloc] init];
    //titLab.frame = CGRectMake(0, 20*HEIGHT, SCREEN_WIDTH, 20*HEIGHT);
    titLab.textAlignment = NSTextAlignmentCenter;
    titLab.text = @"push";
    titLab.textColor = [UIColor whiteColor];
    titLab.font = [UIFont systemFontOfSize:15];
    [alertView addSubview:titLab];
    
    UILabel *textLab = [[UILabel alloc] init];
    //textLab.frame = CGRectMake(15*WIDTH, 50*HEIGHT, SCREEN_WIDTH-90*WIDTH, 70*HEIGHT);
    textLab.font = [UIFont systemFontOfSize:13];
    textLab.textColor = [UIColor whiteColor];
    _textLab = textLab;
    textLab.numberOfLines = 0;
    textLab.textAlignment = NSTextAlignmentCenter;
    [alertView addSubview:textLab];
    
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.layer.cornerRadius = 13.5*HEIGHT;
    cancel.layer.masksToBounds = YES;
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    cancel.titleLabel.font = [UIFont systemFontOfSize:12];
    [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancel.layer.borderWidth = 1;
    cancel.layer.borderColor = [UIColor whiteColor].CGColor;
    cancel.layer.backgroundColor = [UIColor clearColor].CGColor;
    _cancelBtn = cancel;
    //cancel.frame = CGRectMake(20*WIDTH, 120*HEIGHT, 95*WIDTH, 27*HEIGHT);
//    [cancel setImage:[UIImage imageNamed:@"alert_quxiao"] forState:UIControlStateNormal];
//    [cancel setImage:[UIImage imageNamed:@"alert_quxiao1"] forState:UIControlStateHighlighted];
    [alertView addSubview:cancel];
    
    UIButton *lookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _lookBtn = lookBtn;
    
    lookBtn.layer.cornerRadius = 13.5*HEIGHT;
    lookBtn.layer.masksToBounds = YES;
    [lookBtn setTitle:@"登录" forState:UIControlStateNormal];
    lookBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [lookBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    lookBtn.layer.borderWidth = 1;
    lookBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    lookBtn.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    //lookBtn.frame = CGRectMake(145*WIDTH, 120*HEIGHT, 95*WIDTH, 27*HEIGHT);
//    [lookBtn setImage:[UIImage imageNamed:@"alert_kan"] forState:UIControlStateNormal];
//    [lookBtn setImage:[UIImage imageNamed:@"alert_kan1"] forState:UIControlStateHighlighted];
    [alertView addSubview:lookBtn];
    
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.mas_centerY);
        make.centerX.mas_equalTo(self.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-60*WIDTH);
        make.height.mas_equalTo((SCREEN_WIDTH-60*WIDTH)*0.7);
    }];
    
    [titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20*HEIGHT);
        make.centerX.mas_equalTo(alertView.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(100, 20*HEIGHT));
    }];
    
    [textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titLab.mas_bottom).offset(20*HEIGHT);
        make.centerX.mas_equalTo(alertView.mas_centerX);
        make.width.mas_equalTo(SCREEN_WIDTH-90*WIDTH);
        make.height.mas_equalTo(50*HEIGHT);
    }];
    
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(alertView.mas_bottom).offset(-25*HEIGHT);
        make.left.mas_equalTo(20*WIDTH);
        make.size.mas_equalTo(CGSizeMake(90*WIDTH, 27*HEIGHT));
    }];
    
    [lookBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(cancel.mas_bottom);
        make.right.mas_equalTo(-20*WIDTH);
        make.size.mas_equalTo(CGSizeMake(90*WIDTH, 27*HEIGHT));
    }];
    
}

-(void)alertShowWithText:(NSString *)str
{
    //_viewHasShow = YES;
    _textLab.text = str;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alertView.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.alertView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.6
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         
                         self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5f];
                         self.alertView.transform = CGAffineTransformMakeScale(1, 1);
                         self.alertView.alpha = 1.0f;
                         
                     }
                     completion:nil
     ];
}

-(void)close
{
    //_viewHasShow = NO;
    [UIView animateWithDuration:0.2f delay:0.0 options:UIViewAnimationOptionTransitionNone
                     animations:^{
                         self.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.0f];
                         self.alertView.alpha = 0.0f;
                         self.alpha = 0.0f;
                     }
                     completion:^(BOOL finished) {
                         
                         for (UIView *v in [self subviews]) {
                             [v removeFromSuperview];
                         }
                         [self removeFromSuperview];
                     }
     ];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
