//  自定义扫描二维码模块
//  ScanQRCodeViewController.h
//  DiDi
//
//  Created by jaybin on 15/7/28.
//  Copyright (c) 2015年 jaybin. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ZBarSDK.h"

@protocol scanQRCodeControllerDelegate<NSObject>

-(void)scanSuccess:(NSString*)str;
@end

@interface ScanQRCodeViewController : UIViewController
@property (nonatomic,weak) id<scanQRCodeControllerDelegate> delegate;

//打开二维码扫描视图
- (void)setZBarReaderViewStart;
//关闭二维码扫描视图
- (void)setZBarReaderViewStop;

@end
