# CHTPlaceholderView
A view to show some message when error happens

![CHTPlaceholderView](https://github.com/ChanRoy/CHTPlaceholderView/blob/master/CHTPlaceholderView.gif)

## Introduction

*A placeholder view to show some message when something unexpected happens*

*The image above shows the usage.*

## Usage

- We give a enum of `CHTPlaceholderViewType` like this:

```
typedef enum : NSUInteger {
    
    CHTPlaceholderViewTypeNoConnect = 0,
    CHTPlaceholderViewTypeNoData,
    CHTPlaceholderViewTypeError,
    
} CHTPlaceholderViewType;
```

- If we want to use it in our viewController, we have defined some message to show in `UIViewController+CHTPlaceholderView.m`

```
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
```

- And we provide some interface in `UIViewController+CHTPlaceholderView.h`

```
- (void)showPlaceholderViewInView:(UIView *)view
              placeholderViewType:(CHTPlaceholderViewType)type;
```
```
- (void)hidePlaceholderView;
```
```
// add some touch events
- (void)addTouchEventInPhViewWithTarget:(id)target
                                 action:(SEL)selector;
```

So you can call this method in your viewContrller.

**Also, you can add some other `CHTPlaceholderViewType` by yourself.**

## Example

Plz see `CHTPhotoBrowserDemo` project.

## License
MIT