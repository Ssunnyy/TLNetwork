//
//  MHNetwrok.h
//  PersonalAssistant
//
//  Created by dabing on 15/10/23.
//  Copyright © 2015年 Mark. All rights reserved.
//

#ifndef MHNetwrok_h
#define MHNetwrok_h
//判断是否要Log
#ifdef DEBUG
#define TLLog(...) NSLog(__VA_ARGS__)
#else
#define TLLog(...)
#endif

#define SHOW_ALERT(_msg_)  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:_msg_ delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];\
[alert show];


#import "MHAsiNetworkDefine.h"
#import "MHAsiNetworkDefine.h"
#import "MHAsiNetworkHandler.h"
#import "MHNetworkManager.h"
#import "MHAsiNetworkUrl.h"
#import "InterfaceMacros.h"
#import <JSONModel/JSONModel.h>

#endif /* MHNetwrok_h */
