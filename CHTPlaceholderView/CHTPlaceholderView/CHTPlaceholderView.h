//
//  CHTPlaceholderView.h
//  CHTPlaceholderView
//
//  Created by cht on 17/3/30.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    
    CHTPlaceholderViewTypeNoConnect = 0,
    CHTPlaceholderViewTypeNoData,
    CHTPlaceholderViewTypeError,
    
} CHTPlaceholderViewType;

@interface CHTPlaceholderView : UIControl

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, assign) CGFloat offsetX;
@property (nonatomic, assign) BOOL isShowPhImageView;
@property (nonatomic, assign) CHTPlaceholderViewType type;

- (void)setPhTitle:(NSString *)phTitle
        phSubTitle:(NSString *)phSubTitle
           phImage:(UIImage *)phImage
placeholderViewType:(CHTPlaceholderViewType)type;

- (void)showPlaceholderViewWithType:(CHTPlaceholderViewType)type;

@end
