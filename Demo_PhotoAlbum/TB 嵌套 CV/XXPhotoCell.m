//
//  XXPhotoCell.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/14.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXPhotoCell.h"

@interface XXPhotoCell ()

@property (nonatomic, strong) UILabel *lb;

@end


@implementation XXPhotoCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)setupUI {
    [self addSubview:self.lb];
    
    [self.lb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)load:(NSIndexPath *)indexPath {
    self.lb.text = [NSString stringWithFormat:@"%ld - %ld", indexPath.section, indexPath.row];
}

- (UILabel *)lb {
    if (!_lb) {
        _lb = [[UILabel alloc] init];
        _lb.textColor = [UIColor blackColor];
        _lb.font = [UIFont systemFontOfSize:20.f];
        _lb.textAlignment = NSTextAlignmentCenter;
    }
    
    return _lb;
}

@end
