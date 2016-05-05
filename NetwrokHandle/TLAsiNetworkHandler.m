//
//  TLAsiNetworkHandler.m
//  NetwrokDemo
//
//  Created by Ted Liu on 16/5/4.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#import "TLAsiNetworkHandler.h"
#import "TLAsiNetworkItem.h"
#import "AFNetworking.h"
#import "CoreStatus.h"

@interface TLAsiNetworkHandler ()<TLAsiNetworkDelegate,CoreStatusProtocol>

@end;

@implementation TLAsiNetworkHandler

+ (TLAsiNetworkHandler *)sharedInstance
{
    static TLAsiNetworkHandler *handler = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[TLAsiNetworkHandler alloc] init];
    });
    return handler;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.networkError = NO;
    }
    return self;
}

#pragma mark - 创建一个网络请求项
/**
 *  创建一个网络请求项
 *
 *  @param url          网络请求URL
 *  @param networkType  网络请求方式
 *  @param params       网络请求参数
 *  @param delegate     网络请求的委托，如果没有取消网络请求的需求，可传nil
 *  @param showHUD      是否显示HUD
 *  @param successBlock 请求成功后的block
 *  @param failureBlock 请求失败后的block
 *
 *  @return 根据网络请求的委托delegate而生成的唯一标示
 */
- (TLAsiNetworkItem*)requestURL:(NSString *)url
                    networkType:(TLAsiNetWorkType)networkType
                         params:(NSMutableDictionary *)params
                       delegate:(id)delegate
                        showHUD:(BOOL)showHUD
                   successBlock:(TLAsiSuccessBlock)successBlock
                   failureBlock:(TLAsiFailureBlock)failureBlock
{
    if (![CoreStatus isNetworkEnable]) {
        NSLog(@"网络连接断开,请检查网络!");
        if (failureBlock) {
            failureBlock(nil);
        }
        return nil;
    }
    /// 如果有一些公共处理，可以写在这里
    NSUInteger hashValue = [delegate hash];
    self.netWorkItem = [[TLAsiNetworkItem alloc]initWithtype:networkType
                                                         url:url
                                                      params:params
                                                    delegate:delegate
                                                   hashValue:hashValue
                                                     showHUD:showHUD
                                                successBlock:successBlock
                                                failureBlock:failureBlock];
    self.netWorkItem.delegate = delegate;
    [self.items addObject:self.netWorkItem];
    return self.netWorkItem;
}
/**
 *   懒加载网络请求项的 items 数组
 *
 *   @return 返回一个数组
 */
- (NSMutableArray *)items
{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    return _items;
}
/**
 *   取消所有正在执行的网络请求项
 */
+ (void)cancelAllNetItems
{
    TLAsiNetworkHandler *handler = [TLAsiNetworkHandler sharedInstance];
    [handler.items removeAllObjects];
    handler.netWorkItem = nil;
}

- (void)netWorkWillDealloc:(TLAsiNetworkItem *)itme
{
    [self.items removeObject:itme];
    
    self.netWorkItem = nil;
}
@end
