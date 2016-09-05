//
//  TLNetworkManager.h
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TLAsiNetworkDefine.h"
#import "TLAsiNetworkDelegate.h"

@class TLUploadParam;
/// 请求管理者
@interface TLNetworkManager : NSObject

/// 返回单例
+(instancetype)sharedInstance;

#pragma mark - 发送 GET 请求的方法

/**
 *   GET请求通过Block 回调结果
 *
 *   @param url          url
 *   @param paramsDict   paramsDict
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD      是否加载进度指示器
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)paramsDict
            successBlock:(TLAsiSuccessBlock)successBlock
            failureBlock:(TLAsiFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD;
/**
 *   GET请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)paramsDict
                delegate:(id<TLAsiNetworkDelegate>)delegate
                 showHUD:(BOOL)showHUD;

#pragma mark - 发送 POST 请求的方法
/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)paramsDict
              successBlock:(TLAsiSuccessBlock)successBlock
              failureBlock:(TLAsiFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD;
/**
 *   post请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)paramsDict
                  delegate:(id<TLAsiNetworkDelegate>)delegate
                   showHUD:(BOOL)showHUD;
#pragma mark - 发送 PATCH 请求的方法
/**
 *   通过 Block回调结果
 *
 *   @param url           url
 *   @param paramsDict    请求的参数字典
 *   @param successBlock  成功的回调
 *   @param failureBlock  失败的回调
 *   @param showHUD       是否加载进度指示器
 */
+ (void)patchReqeustWithURL:(NSString*)url
                     params:(NSDictionary*)paramsDict
               successBlock:(TLAsiSuccessBlock)successBlock
               failureBlock:(TLAsiFailureBlock)failureBlock
                    showHUD:(BOOL)showHUD;
/**
 *   patch请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)patchReqeustWithURL:(NSString*)url
                     params:(NSDictionary*)paramsDict
                   delegate:(id<TLAsiNetworkDelegate>)delegate
                    showHUD:(BOOL)showHUD;
/**
 *  上传单个文件
 *
 *  @param url          上传文件的 url 地址
 *  @param paramsDict   参数字典
 *  @param successBlock 成功
 *  @param failureBlock 失败
 *  @param showHUD      显示 HUD
 *  @param uploadParams 上传文件的数组（数组中类型为TLUploadParam对象）
 */

+ (void)uploadFileWithURL:(NSString*)url
                   params:(NSDictionary*)paramsDict
             successBlock:(TLAsiSuccessBlock)successBlock
             failureBlock:(TLAsiFailureBlock)failureBlock
              uploadParam:(NSMutableArray *)uploadParams
                  showHUD:(BOOL)showHUD;

@end
