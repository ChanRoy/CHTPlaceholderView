//
//  UIViewController+CHTPlaceholderVIew.m
//  CHTPlaceholderView
//
//  Created by cht on 17/3/30.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "UIViewController+CHTPlaceholderVIew.h"
#import <objc/runtime.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

static NSString *const kPhViewKey = @"kPhViewKey";

@interface CHTPlaceholderView ()

@property (nonatomic, strong) CHTPlaceholderView *phView;

@end

@implementation UIViewController (CHTPlaceholderVIew)

- (void)setPhView:(CHTPlaceholderView *)phView{
    
    objc_setAssociatedObject(self, &kPhViewKey, phView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CHTPlaceholderView *)phView{
    
    return objc_getAssociatedObject(self, &kPhViewKey);
}

- (void)setupPlaceHolderViewInView:(UIView *)view{
    
    self.phView = [[CHTPlaceholderView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
    self.phView.offsetY = 50;
    [self.phView setPhTitle:@"加载出错" phSubTitle:@"點擊重新加載" phImage:[UIImage imageNamed:@"no-wifi"] placeholderViewType:CHTPlaceholderViewTypeNoConnect];
    [self.phView setPhTitle:@"暫無數據" phSubTitle:nil phImage:[UIImage imageNamed:@"no-wifi"] placeholderViewType:CHTPlaceholderViewTypeNoData];
    [self.phView setPhTitle:@"加載出錯" phSubTitle:@"點擊重新加載" phImage:[UIImage imageNamed:@"load_fail"] placeholderViewType:CHTPlaceholderViewTypeError];
}

- (void)showPlaceholderViewInView:(UIView *)view placeholderViewType:(CHTPlaceholderViewType)type{
    
    [self hidePlaceHolderView];
    
    [self setupPlaceHolderViewInView:view];
    
    [self.phView showPlaceholderViewWithType:type];
    
    if (view == self.view) {
        
        self.phView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [view addSubview:self.phView];
        [view bringSubviewToFront:self.phView];
        
        return;
    }
    
    self.phView.frame = view.bounds;
    [self.view insertSubview:self.phView aboveSubview:view];
}

- (void)hidePlaceHolderView{
    
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
