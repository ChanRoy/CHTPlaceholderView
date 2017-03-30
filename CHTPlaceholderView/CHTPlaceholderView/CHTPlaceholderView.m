//
//  CHTPlaceholderView.m
//  CHTPlaceholderView
//
//  Created by cht on 17/3/30.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "CHTPlaceholderView.h"

// RGB颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

static NSString *const kTitleKey    = @"cht_title";
static NSString *const kSubTitleKey = @"cht_subTitle";
static NSString *const kImageKey    = @"cht_image";
static NSString *const kDictKey = @"CHT";

@interface CHTPlaceholderView ()

@property (nonatomic, strong) UIImageView *phImageView;
@property (nonatomic, strong) UILabel *phTitleLabel;
@property (nonatomic, strong) UILabel *phSubTitleLabel;

@property (nonatomic, strong) NSMutableDictionary <NSString *,NSDictionary *>*infoDict;

@end

@implementation CHTPlaceholderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        _infoDict = [NSMutableDictionary new];
        
        _phImageView = [[UIImageView alloc]init];
        [self addSubview:_phImageView];
        _isShowPhImageView = YES;
        
        _phTitleLabel = [[UILabel alloc]init];
        _phTitleLabel.font = [UIFont systemFontOfSize:15.0f];
        _phTitleLabel.backgroundColor = [UIColor clearColor];
        _phTitleLabel.textAlignment = NSTextAlignmentCenter;
        _phTitleLabel.numberOfLines = 0;
        _phTitleLabel.textColor = UIColorFromRGB(0x9b9b9b);
        [self addSubview:_phTitleLabel];
        
        _phSubTitleLabel = [[UILabel alloc]init];
        _phSubTitleLabel.font = [UIFont systemFontOfSize:12.0f];
        _phSubTitleLabel.backgroundColor = [UIColor clearColor];
        _phSubTitleLabel.textAlignment = NSTextAlignmentCenter;
        _phSubTitleLabel.numberOfLines = 0;
        _phSubTitleLabel.textColor = UIColorFromRGB(0x9b9b9b);
        [self addSubview:_phSubTitleLabel];
        
        
    }
    return self;
}

- (void)setPhTitle:(NSString *)phTitle phSubTitle:(NSString *)phSubTitle phImage:(UIImage *)phImage placeholderViewType:(CHTPlaceholderViewType)type{
    
    NSDictionary *dict = @{kTitleKey    : phTitle ?: @"",
                           kSubTitleKey : phSubTitle ?: @"",
                           kImageKey    : phImage ?: [UIImage new]};
    [_infoDict setObject:dict forKey:[NSString stringWithFormat:@"%@_%ld",kDictKey,type]];
}

- (void)showPlaceholderViewWithType:(CHTPlaceholderViewType)type{
    
    NSString *key = [NSString stringWithFormat:@"%@_%ld",kDictKey,type];
    NSDictionary *dict = [_infoDict objectForKey:key];
    
    NSString *phTitle = [dict objectForKey:kTitleKey];
    NSString *phSubTitle = [dict objectForKey:kSubTitleKey];
    UIImage *phImage = [dict objectForKey:kImageKey];
    
    _phTitleLabel.text = phTitle;
    _phSubTitleLabel.text = phSubTitle;
    _phImageView.image = phImage;
    
    [self layoutIfNeeded];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat centerX = CGRectGetWidth(self.frame) + _offsetX;
    CGFloat centerY = CGRectGetHeight(self.frame) + _offsetY;
    CGPoint labelCenter = CGPointMake(centerX, centerY);
    CGFloat padding = 30.0f;
    CGFloat subMargin = 6;
    
    CGSize labelSize = [_phTitleLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-padding*2, 999) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: _phTitleLabel.font} context:nil].size;
    
    if (_isShowPhImageView) {
        
        CGFloat imageWidth = _phImageView.image.size.width;
        CGFloat imageHeight = _phImageView.image.size.height;
        _phImageView.bounds = CGRectMake(0, 0, imageWidth, imageHeight);
        CGPoint imageCenter = CGPointMake(CGRectGetWidth(self.frame)/2.0f+_offsetX, (CGRectGetHeight(self.frame)-imageHeight)/2.0f+_offsetY);
        _phImageView.center = imageCenter;
        if (_phImageView.frame.origin.y < 0) {
            
            CGRect frame = _phImageView.frame;
            frame.origin.y = 5;
            frame.size.height = imageHeight - 5*2;
            _phImageView.frame = frame;
        }
        
        if (_phImageView.frame.origin.x < 0) {
            
            CGRect frame = _phImageView.frame;
            frame.origin.x = 5;
            frame.size.width = imageWidth - 5*2;
            _phImageView.frame = frame;
        }
        
        labelCenter = CGPointMake(CGRectGetWidth(self.frame)/2.0+_offsetX, CGRectGetMaxY(_phImageView.frame)+labelSize.height/2+subMargin);
    }else{
        _phImageView.frame = CGRectZero;
    }
    
    _phTitleLabel.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
    _phTitleLabel.center = labelCenter;
    
    CGSize subLabelSize = [_phSubTitleLabel.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame)-padding*2, 999) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: _phSubTitleLabel.font} context:nil].size;
    _phSubTitleLabel.frame = CGRectMake(0, 0, subLabelSize.width, subLabelSize.height);
    _phSubTitleLabel.center = CGPointMake(CGRectGetWidth(self.frame)/2.0+_offsetX, CGRectGetMaxY(_phTitleLabel.frame)+subLabelSize.height/2.0+subMargin);
    
}



@end
