//
//  setController.h
//  anQuanTong
//
//  Created by 吴宇飞 on 17/6/16.
//  Copyright © 2017年 gyd. All rights reserved.
//

#import "uiBaseController.h"
@protocol loginDelegate <NSObject>

-(void)loginSuccess;

@end
@interface setController : uiBaseController
@property (nonatomic, assign) id <loginDelegate> delegate;
@end
