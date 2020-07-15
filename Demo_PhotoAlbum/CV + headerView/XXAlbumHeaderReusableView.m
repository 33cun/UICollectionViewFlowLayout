//
//  XXAlbumHeaderReusableView.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kLeft       (kMargin * 2 + 60.f)
#define kCellWH     ((SCREEN_WIDTH - kLeft - kSMargin * 2 - kMargin) / 3)


#import "XXAlbumHeaderReusableView.h"

@interface XXAlbumHeaderReusableView ()

@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) NSMutableArray<UIView *> *views;

@end


@implementation XXAlbumHeaderReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _views = [NSMutableArray arrayWithCapacity:0];
        
        [self setupUI];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


#pragma mark - UI
- (void)setupUI {
    [self addSubview:self.lb_title];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    NSInteger count = 3;
    
    for (int i = 0; i < count; ++i) {
        UIView *v = [[UIView alloc] init];
        v.tag = 100 + i;
        v.backgroundColor = RandomColor;
        [self addSubview:v];
        [self.views addObject:v];
    }
    
    [self.views mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:kCellWH leadSpacing:kLeft tailSpacing:kMargin];
    [self.views mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.bottom.equalTo(self);
    }];
}


#pragma mark - Data
- (void)setupData {
    
}


#pragma mark - Event Response


#pragma mark - Private Methods
- (void)loadBookCitySortHeaderViewTitle:(NSString *)title {
    self.lb_title.text = title;
}


#pragma mark - Delegate


#pragma mark - Request


#pragma mark - Setter


#pragma mark - Getter
- (UILabel *)lb_title {
    if (!_lb_title) {
        _lb_title = [[UILabel alloc] init];
        _lb_title.font = [UIFont boldSystemFontOfSize:18.f];
        _lb_title.textColor = [UIColor blackColor];
        _lb_title.textAlignment = NSTextAlignmentLeft;
        _lb_title.text = @"本周";
    }
    
    return _lb_title;
}



@end
