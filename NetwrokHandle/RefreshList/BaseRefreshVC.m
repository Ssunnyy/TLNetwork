//
//  BaseRefreshVC.m
//  Campus
//
//  Created by Ted Liu on 16/3/5.
//  Copyright © 2016年 Ted Liu. All rights reserved.
//

#import "BaseRefreshVC.h"
#import "LDRefreshFooterView.h"
#import "LDRefreshHeaderView.h"


@interface BaseRefreshVC ()

@end

@implementation BaseRefreshVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.edgesForExtendedLayout =  UIRectEdgeNone;
    // 创建父类的表格
    _baseTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    _baseTableView.backgroundColor = [UIColor colorWithHexColorString:@"F7F7F7"];
    _page               = 1;
    _showRefreshHeader  = NO;
    _showRefreshFooter  = NO;
    _showTableBlankView = NO;
    _showRefreshAuto    = YES;
    
    [CoreStatus beginNotiNetwork:self];
}
/**
 *  网络状态变化
 *
 *  @param noti 
 */
- (void)coreNetworkChangeNoti:(NSNotification *)noti
{
    if ([CoreStatus currentNetWorkStatus] == CoreNetWorkStatusNone || [CoreStatus currentNetWorkStatus] == CoreNetWorkStatusUnkhow){
        NSLog(@"网络错误或断开网络连接");
        [self.baseTableView.refreshHeader endRefresh];
        [self.baseTableView.refreshFooter endRefresh];
    }
}
/**
 *  设置下拉刷新控件
 *
 *  @param showRefreshHeader
 */
- (void)setShowRefreshHeader:(BOOL)showRefreshHeader
{
    if (_showRefreshHeader != showRefreshHeader) {
        _showRefreshHeader = showRefreshHeader;
        if (_showRefreshHeader) {
            __weak typeof(self) weakSelf = self;
            //下拉刷新
            self.baseTableView.refreshHeader = [self.baseTableView addRefreshHeaderWithHandler:^ {
                
                [weakSelf tableViewDidTriggerHeaderRefresh];
            }];
        }else{
            self.baseTableView.refreshHeader = nil;
        }
    }
}
/**
 *  设置上拉刷新控件
 *
 *  @param showRefreshFooter
 */
- (void)setShowRefreshFooter:(BOOL)showRefreshFooter
{
    if (_showRefreshFooter != showRefreshFooter) {
        _showRefreshFooter = showRefreshFooter;
        if (_showRefreshFooter) {
            __weak typeof(self) weakSelf = self;
            //上拉加载更多
            self.baseTableView.refreshFooter = [self.baseTableView addRefreshFooterWithHandler:^ {
                
                [weakSelf tableViewDidTriggerFooterRefresh];
            }];
        }else{
            self.baseTableView.refreshFooter = nil;
        }
    }
}

- (void)tableViewDidAutoHeaderRefresh
{
    [self.baseTableView.refreshHeader startRefresh];
}
#pragma mark - getter

- (NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    
    return _dataArray;
}

- (NSMutableDictionary *)dataDictionary
{
    if (_dataDictionary == nil) {
        _dataDictionary = [NSMutableDictionary dictionary];
    }
    return _dataDictionary;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
#pragma mark - public refresh

/**
 *  下拉刷新事件
 */
- (void)tableViewDidTriggerHeaderRefresh
{
    
}
/**
 *  上拉加载事件
 */
- (void)tableViewDidTriggerFooterRefresh
{
    
}
/**
 *  上下拉刷新成功
 */
- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload
{
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       
                       if (reload) {
                           [weakSelf.baseTableView reloadData];
                       }
                       if (isHeader) {
                           [weakSelf.baseTableView.refreshHeader endRefresh];
                       }
                       else{
                           [weakSelf.baseTableView.refreshFooter endRefresh];
                       }
                   });
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
