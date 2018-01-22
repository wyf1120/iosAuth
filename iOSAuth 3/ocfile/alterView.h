//
//  alterView.h
//  gydApp
//
//  Created by 吴宇飞 on 16/8/23.
//  Copyright © 2016年 gyd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alterView : UIView

@property (nonatomic ,strong)UIView *alertView;
@property (nonatomic ,strong)UIButton *cancelBtn;
@property (nonatomic ,strong)UIButton *lookBtn;
@property (nonatomic ,assign)NSString *pushStr;
@property (nonatomic ,strong)UILabel *textLab;
@property (nonatomic ,assign)BOOL viewHasShow;

-(void)alertShowWithText:(NSString*)str;
-(void)close;
@end
