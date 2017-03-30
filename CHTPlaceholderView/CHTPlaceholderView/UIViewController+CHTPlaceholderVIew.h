//
//  UIViewController+CHTPlaceholderVIew.h
//  CHTPlaceholderView
//
//  Created by cht on 17/3/30.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CHTPlaceholderView.h"

@interface UIViewController (CHTPlaceholderVIew)

- (void)showPlaceholderViewInView:(UIView *)view placeHolderViewType:(CHTPlaceholderViewType)type;

- (void)hidePlaceholderView;

- (void)addTouchEventInPhViewWithTarget:(id)target action:(SEL)selector;

@end
