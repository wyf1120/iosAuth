//
//  wyfProgressView.h
//  biaoShiPai
//
//  Created by 吴宇飞 on 16/11/7.
//  Copyright © 2016年 gyd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface loadView : UIView

@end

@interface wyfProgressView : NSObject
@property (nonatomic ,strong)loadView *lView;
+(instancetype)defaultLoadView;
-(void)showLoadViewWithBool:(BOOL)isShow;
@end
