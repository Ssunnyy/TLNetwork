//
//  LDRefreshHeaderView.m
//  LDRefresh
//
//  Created by lidi on 10/6/15.
//  Copyright © 2015 lidi. All rights reserved.
//

#import "LDRefreshHeaderView.h"

typedef NS_ENUM(NSInteger, LDRefreshState) {
    LDRefreshStateNormal  = 1,
    LDRefreshStatePulling = 2,
    LDRefreshStateLoading = 3,
};

typedef void(^LDRefreshedHandler)(void);

const CGFloat LDRefreshHeaderHeight = 60;

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define TextColor   [UIColor colorWithRed:120/255.0 green:120/255.0 blue:120/255.0 alpha:1.0]
#define TextFont    [UIFont systemFontOfSize:12.0f]

@interface LDRefreshHeaderView ()
//UI
@property (nonatomic, strong) UIScrollView            *scrollView;
@property (nonatomic, strong) UILabel                 *statusLab;
@property (nonatomic, strong) UIImageView             *arrowImage;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

//Data
@property (nonatomic, assign) UIEdgeInsets            initEdgeInset;
@property (nonatomic, strong) NSDictionary            *stateTextDic;
@property (nonatomic, assign) CGFloat                 dragHeightThreshold;

@property (nonatomic, copy  ) LDRefreshedHandler      refreshHandler;
@property (nonatomic, assign) LDRefreshState          refreshState;
@end

@implementation LDRefreshHeaderView

- (void)dealloc{
    [_scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (instancetype)init {
    if (self = [super init]) {

        [self drawRefreshView];
        
        [self initData];
    }
    return self;
}

- (void)drawRefreshView {
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, -LDRefreshHeaderHeight, ScreenWidth, LDRefreshHeaderHeight);
    
    self.statusLab = ({
        UILabel *lab        = [[UILabel alloc] init];
        lab.frame           = CGRectMake(0, 0, ScreenWidth, LDRefreshHeaderHeight);
        lab.font            = TextFont;
        lab.textColor       = TextColor;
        lab.backgroundColor = [UIColor clearColor];
        lab.textAlignment   = NSTextAlignmentCenter;
        [self addSubview:lab];
        
        lab;
    });

    self.arrowImage = ({
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tableview_pull_refresh"]];
        imageView.frame        = CGRectMake(ScreenWidth/2.0 - 60,(LDRefreshHeaderHeight-32)/2.0, 32, 32);
        [self addSubview:imageView];
        
        imageView;
    });

    self.indicatorView = ({
        UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicatorView.color                    = TextColor;
        indicatorView.frame                    = _arrowImage.frame;
        [self addSubview:indicatorView];
        
        indicatorView;
    });
}

- (void)initData {
    self.stateTextDic = @{@"normalText" : @"下拉刷新",
                          @"pullingText" : @"释放更新",
                          @"loadingText" : @"加载中..."
                          };
    
    self.refreshState = LDRefreshStateNormal;
}

- (void)setScrollView:(UIScrollView *)scrollView {
    if (_scrollView != scrollView) {
        _initEdgeInset = scrollView.contentInset;
        _scrollView    = scrollView;
        [_scrollView addSubview:self];
        
        [_scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"contentOffset"]) {
        [self scrollViewContentOffsetDidChange];
    }
}

- (void)scrollViewContentOffsetDidChange {
    if (self.dragHeight < 0 || self.refreshState == LDRefreshStateLoading) {
        return;
    }
    
    if (self.scrollView.isDragging) {
        if (self.dragHeight < self.dragHeightThreshold) {
            self.refreshState = LDRefreshStateNormal;
        }else {
            self.refreshState = LDRefreshStatePulling;
        }
    }
    else {
        if (self.refreshState == LDRefreshStatePulling) {
            self.refreshState = LDRefreshStateLoading;
        }
    }
}

- (CGFloat)dragHeight {
    return (self.scrollView.contentOffset.y + _initEdgeInset.top) * -1.0;
}

- (CGFloat)dragHeightThreshold {
    return LDRefreshHeaderHeight;
}

- (void)setRefreshState:(LDRefreshState)refreshState {
    _refreshState = refreshState;

    switch (_refreshState) {
        case LDRefreshStateNormal: {
            [self normalAnimation];
            
            [UIView animateWithDuration:0.3 animations:^{
                self.scrollView.contentInset = _initEdgeInset;
            }];
            break;
        }
            
        case LDRefreshStatePulling: {
            [self pullingAnimation];
            break;
        }
            
        case LDRefreshStateLoading: {
            [self loadingAnimation];
            
            [UIView animateWithDuration:0.3 animations:^{
                UIEdgeInsets inset           = _initEdgeInset;
                inset.top                    += LDRefreshHeaderHeight;
                self.scrollView.contentInset = inset;
            }];
            
            if (self.refreshHandler) {
                self.refreshHandler();
            }
            break;
        }
    }
}

- (void)normalAnimation{
    _statusLab.text    = self.stateTextDic[@"normalText"];

    _arrowImage.hidden = NO;
    [_indicatorView stopAnimating];
    [UIView animateWithDuration:0.3 animations:^{
        _arrowImage.transform = CGAffineTransformIdentity;
    }];
}

- (void)pullingAnimation{
    _statusLab.text = self.stateTextDic[@"pullingText"];
    
    [UIView animateWithDuration:0.3 animations:^{
        _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
    }];
}

- (void)loadingAnimation {
    _statusLab.text    = self.stateTextDic[@"loadingText"];

    _arrowImage.hidden = YES;
    _arrowImage.transform = CGAffineTransformIdentity;
    [_indicatorView startAnimating];
}

- (void)startRefresh {
    self.refreshState = LDRefreshStateLoading;
}

- (void)endRefresh {
    self.refreshState = LDRefreshStateNormal;
}
@end
