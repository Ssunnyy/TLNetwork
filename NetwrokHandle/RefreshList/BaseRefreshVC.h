//
//  BaseRefreshVC.h
//  Campus
//
//  Created by Ted Liu on 16/3/5.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

//#import "BaseViewController.h"
#import "UIScrollView+LDRefresh.h"
#import "LDRefreshHeaderView.h"
#import "LDRefreshFooterView.h"
#import "CoreStatus.h"

@interface BaseRefreshVC : UIViewController<UITableViewDataSource,UITableViewDelegate,CoreStatusProtocol>
// 当前表格
@property (nonatomic,strong) UITableView         *baseTableView;
// 数组形式数据源
@property (nonatomic,strong) NSMutableArray      *dataArray;
// 字典形式数据源
@property (nonatomic,strong) NSMutableDictionary *dataDictionary;
// 分页
@property (nonatomic,assign) int page;
// 是否自动下拉刷新
@property (nonatomic,assign) BOOL showRefreshAuto;
// 是否支持下拉刷新
@property (nonatomic,assign) BOOL showRefreshHeader;
// 是否支持上拉加载
@property (nonatomic,assign) BOOL showRefreshFooter;
// 是否显示无数据时默认背景
@property (nonatomic,assign) BOOL showTableBlankView;
// 下拉刷新事件
- (void) tableViewDidTriggerHeaderRefresh;
// 上拉加载事件
- (void) tableViewDidTriggerFooterRefresh;
// 自动刷新
- (void) tableViewDidAutoHeaderRefresh;
// 上下拉刷新成功
- (void) tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

@end