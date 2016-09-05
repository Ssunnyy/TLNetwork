//
//  TLAsiNetworkItem.m
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#import "TLAsiNetworkItem.h"
#import "AFNetworking.h"
#import "SVProgressHUD.h"
#import "TLAsiNetworkDefine.h"
#import "DSToast.h"

@interface TLAsiNetworkItem ()

@end

@implementation TLAsiNetworkItem


#pragma mark - 创建一个网络请求项，开始请求网络
/**
 *  创建一个网络请求项，开始请求网络
 *
 *  @param networkType  网络请求方式
 *  @param url          网络请求URL
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param hashValue    网络请求的委托delegate的唯一标示
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return TLAsiNetworkItem对象
 */
- (TLAsiNetworkItem *)initWithtype:(TLAsiNetWorkType)networkType
                               url:(NSString *)url
                            params:(NSDictionary *)params
                          delegate:(id)delegate
                         hashValue:(NSUInteger)hashValue
                           showHUD:(BOOL)showHUD
                      successBlock:(TLAsiSuccessBlock)successBlock
                      failureBlock:(TLAsiFailureBlock)failureBlock
{
    if (self = [super init])
    {
        self.networkType    = networkType;
        self.url            = url;
        self.params         = params;
        self.delegate       = delegate;
        self.showHUD        = showHUD;
        if (showHUD==YES) {
            [SVProgressHUD show];
        }
        __weak typeof(self)weakSelf = self;
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/json",@"text/html", nil];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        if (networkType==TLAsiNetWorkGET)
        {
            [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [SVProgressHUD dismiss];

                if ([responseObject[@"api_code"] integerValue] != 0) {
                    
                    if (failureBlock) {
                        failureBlock(nil);
                    }
                    [weakSelf removewItem];
                    [[DSToast toastWithText:responseObject[@"api_message"]] show];
                    
                    return;
                }
                
                if (successBlock) {
                    successBlock(responseObject);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf removewItem];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [SVProgressHUD dismiss];
                NSLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf removewItem];
                
            }];
            
        }
        else if (networkType == TLAsiNetWorkPOST){
            [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [SVProgressHUD dismiss];
                NSLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf removewItem];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [SVProgressHUD dismiss];
                NSLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf removewItem];
            }];
        }
        else if (networkType == TLAsiNetWorkPATCH){
        
            [manager PATCH:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                [SVProgressHUD dismiss];
                NSLog(@"\n\n----请求的返回结果 %@\n",responseObject);
                if (successBlock) {
                    successBlock(responseObject);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
                    [weakSelf.delegate requestDidFinishLoading:responseObject];
                }
                [weakSelf removewItem];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                [SVProgressHUD dismiss];
                NSLog(@"---error==%@\n",error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
                if ([weakSelf.delegate respondsToSelector:@selector(requestdidFailWithError:)]) {
                    [weakSelf.delegate requestdidFailWithError:error];
                }
                [weakSelf removewItem];
                
            }];
        }
    }
    return self;
}
/**
 *   移除网络请求项
 */
- (void)removewItem
{
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ([weakSelf.delegate respondsToSelector:@selector(netWorkWillDealloc:)]) {
            [weakSelf.delegate netWorkWillDealloc:weakSelf];
        }
    });
}
- (void)dealloc
{
    
    
}
@end
