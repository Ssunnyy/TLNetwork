//
//  TLAsiNetworkDefine.h
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#ifndef TLAsiNetworkDefine_h
#define TLAsiNetworkDefine_h

/**
 *  请求类型
 */
typedef NS_ENUM(NSUInteger, TLAsiNetWorkType){
    TLAsiNetWorkGET = 1, // GET请求
    TLAsiNetWorkPOST     // POST请求
};
/**
 *  网络请求超时的时间
 */
#define TLAsi_API_TIME_OUT 20


#if NS_BLOCKS_AVAILABLE
/**
 *  请求开始的回调（下载时用到）
 */
typedef void (^TLAsiStartBlock)(void);

/**
 *  请求成功回调
 *
 *  @param returnData 回调block
 */
typedef void (^TLAsiSuccessBlock)(NSDictionary *returnData);

/**
 *  请求失败回调
 *
 *  @param error 回调block
 */
typedef void (^TLAsiFailureBlock)(NSError *error);

#endif

#endif /* TLAsiNetworkDefine_h */
