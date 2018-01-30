//
//  keyboardToolView.m
//  gydApp
//
//  Created by 吴宇飞 on 16/3/24.
//  Copyright © 2016年 gyd. All rights reserved.
//

#import "keyboardToolView.h"

@implementation keyboardToolView

-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30*HEIGHT)]) {
        self.backgroundColor = [UIColor colorWithWhite:0.923 alpha:1.000];
        //toolView.alpha = 0.8;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        _finishBtn = button;
        [button setTitle:@"完成" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:0.098 green:0.624 blue:1.000 alpha:1.000] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(finishBtnClick) forControlEvents:UIControlEventTouchUpInside];
        button.frame = CGRectMake(SCREEN_WIDTH-60, 0, 50, 30);
        //button.backgroundColor = [UIColor colorWithWhite:0.674 alpha:1.000];
        [self addSubview:button];
    }
    return self;
}

-(void)finishBtnClick
{
    [self endEditing:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
