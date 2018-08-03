//
//  UIViewController+CHTPlaceholderView.m
//  CHTPlaceholderView
//
//  Created by cht on 2017/4/1.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "UIViewController+CHTPlaceholderView.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *const kPhViewKey = @"kPhViewKey";

@implementation UIViewController (CHTPlaceholderView)

- (void)setPhView:(CHTPlaceholderView *)phView{
    
    objc_setAssociatedObject(self, &kPhViewKey, phView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CHTPlaceholderView *)phView{
    
    return objc_getAssociatedObject(self, &kPhViewKey);
}

- (void)setupPlaceHolderViewInView:(UIView *)view{
    
    self.phView = [[CHTPlaceholderView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    self.phView.offsetY = 50;
    [self.phView setPhTitle:@"无网络连接"
                 phSubTitle:@"点击重新加载"
                    phImage:[UIImage imageNamed:@"no-wifi"]
        placeholderViewType:CHTPlaceholderViewTypeNoConnect];
    
    [self.phView setPhTitle:@"暂无数据"
                 phSubTitle:nil
                    phImage:[UIImage imageNamed:@"load_fail"]
        placeholderViewType:CHTPlaceholderViewTypeNoData];
    
    [self.phView setPhTitle:@"加载出错"
                 phSubTitle:@"点击重新加载"
                    phImage:[UIImage imageNamed:@"load_fail"]
        placeholderViewType:CHTPlaceholderViewTypeError];
}

- (void)showPlaceholderViewInView:(UIView *)view placeholderViewType:(CHTPlaceholderViewType)type{
    
    [self hidePlaceholderView];
    
    [self setupPlaceHolderViewInView:view];
    
    if (view == self.view) {
        
        self.phView.frame = view.bounds;
        [view addSubview:self.phView];
        [view bringSubviewToFront:self.phView];
        
    } else {
        
        self.phView.frame = view.bounds;
        [self.view insertSubview:self.phView aboveSubview:view];
    }
    self.phView.frame = view.frame;
    [view.superview insertSubview:self.phView aboveSubview:view];
    [self.phView showPlaceholderViewWithType:type];
}

- (void)hidePlaceholderView{
    
    if (self.phView) {
        [self.phView removeFromSuperview];
        self.phView = nil;
    }
}

- (void)addTouchEventInPhViewWithTarget:(id)target action:(SEL)selector{
    
    if (self.phView){
        
        [self.phView setUserInteractionEnabled:YES];
        
        UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
        [tapGest setNumberOfTapsRequired:1];
        [self.phView addGestureRecognizer:tapGest];
    }
}


@end
