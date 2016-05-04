//
//  TLAsiNetworkDefine.h
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#ifndef NetwrokDemo_TLAsiNetworkDefine_h
#define NetwrokDemo_TLAsiNetworkDefine_h
///**
// *  正式环境
// */
//#define API_HOST @""

///**
// *   测试环境
// */
#define API_HOST @""

//      接口路径全拼
#define PATH(_path)             [NSString stringWithFormat:_path, API_HOST]
/**
 *      首页
 */
#define DEF_GetHomepage         PATH(@"%@/GetHomepage")

/**
 *      上传头像
 */
#define DEF_UploadHeadImg       PATH(@"%@/UploadHeadImg")

#endif
