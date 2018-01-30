//
//  loginController.h
//  anQuanTong
//
//  Created by 吴宇飞 on 17/6/9.
//  Copyright © 2017年 gyd. All rights reserved.
//

#import "uiBaseController.h"

@protocol loginvcDelegate <NSObject>

-(void)loginvcDel;

@end

@interface loginController : uiBaseController
@property (nonatomic, assign) id<loginvcDelegate>delegate;
@property (nonatomic, copy)NSString *loginSuccess;
@end
