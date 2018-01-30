//
//  wyfProgressView.m
//  biaoShiPai
//
//  Created by 吴宇飞 on 16/11/7.
//  Copyright © 2016年 gyd. All rights reserved.
//

#import "wyfProgressView.h"
#define VIEW_TAG  9909
@implementation loadView

-(id)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        UIView * backView = [self viewWithTag:VIEW_TAG] ;
        if (backView)
        {
            return nil;
        }
        //第一个层级
        backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
        backView.tag = VIEW_TAG ;
        [self addSubview:backView] ;
        
        
        [self bringSubviewToFront:backView];
        
        //第二个层级 是用来做透明度用的
        UIView * subBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)] ;
        
        subBackView.backgroundColor = [UIColor blackColor] ;
        
        subBackView.alpha = 0.2f ;
        
        [backView addSubview:subBackView] ;
        
        //第三层级 菊花
        
        UIView * blackView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2-50, SCREEN_HEIGHT/2-50, 100, 100)] ;
        blackView.layer.cornerRadius = 10 ;
        blackView.backgroundColor = [UIColor blackColor];
        [backView addSubview:blackView] ;
        
        UIActivityIndicatorView * activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge] ;
        activity.center = CGPointMake(blackView.frame.size.width/2, blackView.frame.size.height/2) ;
        [activity startAnimating] ;
        [blackView addSubview:activity];
    }
    return self;
}

@end

@implementation wyfProgressView

+(instancetype)defaultLoadView
{
    static wyfProgressView *wyfView;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken, ^{
        wyfView = [[wyfProgressView alloc] init];
    });
    return wyfView;
}

/**
 根据参数来展示或移除菊花

 @param isShow yes展示菊花，no移除菊花
 */
-(void)showLoadViewWithBool:(BOOL)isShow
{
    if (isShow) {
        if (!_lView) {
            _lView = [[loadView alloc] init];
        }
        [[UIApplication sharedApplication].keyWindow addSubview:_lView];
    }
    else
    {
        [_lView removeFromSuperview];
    }
}

@end
