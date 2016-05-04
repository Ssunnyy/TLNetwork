//
//  TLNetworkManager.m
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#import "TLNetworkManager.h"
#import "TLAsiNetworkHandler.h"
#import "TLUploadParam.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
@implementation TLNetworkManager
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static TLNetworkManager *_manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [super allocWithZone:zone];
    });
    return _manager;
}
/// 返回单例
+(instancetype)sharedInstance
{
    return [[super alloc] init];
}
#pragma mark - GET 请求的回调方法

/**
 *   GET请求的公共方法 以下方法都调用这个方法 根据传入的不同参数觉得回调的方式
 *
 *   @param url           ur
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                  target:(id)target
                  action:(SEL)action
                delegate:(id)delegate
            successBlock:(TLAsiSuccessBlock)successBlock
            failureBlock:(TLAsiFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[TLAsiNetworkHandler sharedInstance] conURL:url networkType:TLAsiNetWorkGET params:mutableDict delegate:delegate showHUD:showHUD successBlock:successBlock failureBlock:failureBlock];
}
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
                  params:(NSDictionary*)params
            successBlock:(TLAsiSuccessBlock)successBlock
            failureBlock:(TLAsiFailureBlock)failureBlock
                 showHUD:(BOOL)showHUD
{
    [self getRequstWithURL:url params:params target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
}
/**
 *   GET请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)getRequstWithURL:(NSString*)url
                  params:(NSDictionary*)params
                delegate:(id<TLAsiNetworkDelegate>)delegate
                 showHUD:(BOOL)showHUD
{
    [self getRequstWithURL:url params:params target:nil action:nil delegate:delegate successBlock:nil failureBlock:nil showHUD:showHUD];
}

#pragma mark - POST请求的回调方法
/**
 *   发送一个 POST请求的公共方法 传入不同的回调参数决定回调的方式
 *
 *   @param url           ur
 *   @param paramsDict   paramsDict
 *   @param target       target
 *   @param action       action
 *   @param delegate     delegate
 *   @param successBlock successBlock
 *   @param failureBlock failureBlock
 *   @param showHUD      showHUD
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                    target:(id)target
                    action:(SEL)action
                  delegate:(id<TLAsiNetworkDelegate>)delegate
              successBlock:(TLAsiSuccessBlock)successBlock
              failureBlock:(TLAsiFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:params];
    [[TLAsiNetworkHandler sharedInstance] conURL:url networkType:TLAsiNetWorkPOST params:mutableDict delegate:delegate showHUD:showHUD successBlock:successBlock failureBlock:failureBlock];
}
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
                    params:(NSDictionary*)params
              successBlock:(TLAsiSuccessBlock)successBlock
              failureBlock:(TLAsiFailureBlock)failureBlock
                   showHUD:(BOOL)showHUD
{
    [self postReqeustWithURL:url params:params target:nil action:nil delegate:nil successBlock:successBlock failureBlock:failureBlock showHUD:showHUD];
}
/**
 *   post请求通过代理回调
 *
 *   @param url         url
 *   @param paramsDict  请求的参数
 *   @param delegate    delegate
 *   @param showHUD    是否转圈圈
 */
+ (void)postReqeustWithURL:(NSString*)url
                    params:(NSDictionary*)params
                  delegate:(id<TLAsiNetworkDelegate>)delegate
                   showHUD:(BOOL)showHUD;
{
    [self postReqeustWithURL:url params:params target:nil action:nil delegate:delegate successBlock:nil failureBlock:nil showHUD:showHUD];
}
/**
 *  上传多个文件
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
                  showHUD:(BOOL)showHUD
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:url parameters:paramsDict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (int i = 0; i < uploadParams.count; i++) {
            if ([uploadParams[i] isKindOfClass:[TLUploadParam class]]) {
                TLUploadParam *uploadParam = (TLUploadParam *)uploadParams[i];
                [formData appendPartWithFileData:uploadParam.data name:uploadParam.name fileName:uploadParam.fileName mimeType:uploadParam.mimeType];
            }else{
                NSLog(@"文件数组不是TLUploadParam对象，请检查文件数组类型");
                return;
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        [SVProgressHUD showProgress:uploadProgress.fractionCompleted status:@"上传中"];
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [SVProgressHUD dismiss];
        // 根据服务器返回状态判定请求是否成功
        if ([responseObject[@"state"] boolValue] == NO) {
            if (failureBlock) {
                failureBlock(nil);
            }
            NSLog(@"----> 服务器返回状态为失败");
            return;
        }
        if (successBlock) {
            NSLog(@"----> 接口请求成功");
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [SVProgressHUD dismiss];
        NSLog(@"----> %@",error.domain);
    }];
}
@end
