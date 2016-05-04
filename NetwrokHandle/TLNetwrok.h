//
//  TLNetwrok.h
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#ifndef TLNetwrok_h
#define TLNetwrok_h

#define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];


#import "TLAsiNetworkDefine.h"
#import "TLAsiNetworkDelegate.h"
#import "TLAsiNetworkHandler.h"
#import "TLNetworkManager.h"
#import "TLAsiNetworkUrl.h"
#import <JSONModel/JSONModel.h>

#endif 