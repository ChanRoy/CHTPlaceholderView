//
//  UIViewController+CHTPlaceholderView.h
//  CHTPlaceholderView
//
//  Created by cht on 2017/4/1.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTPlaceholderView.h"

@interface UIViewController (CHTPlaceholderView)

@property (nonatomic, strong) CHTPlaceholderView *phView;

- (void)showPlaceholderViewInView:(UIView *)view
              placeholderViewType:(CHTPlaceholderViewType)type;

- (void)hidePlaceholderView;

// add some touch events
- (void)addTouchEventInPhViewWithTarget:(id)target
                                 action:(SEL)selector;

@end
