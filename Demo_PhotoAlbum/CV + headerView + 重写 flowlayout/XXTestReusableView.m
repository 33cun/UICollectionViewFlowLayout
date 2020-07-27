//
//  XXTestReusableView.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXTestReusableView.h"

@implementation XXTestReusableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (UICollectionViewLayoutAttributes *)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    UICollectionViewLayoutAttributes *att = [super preferredLayoutAttributesFittingAttributes:layoutAttributes];
    
    if ([self.delegate respondsToSelector:@selector(testReusableView:att:)]) {
        [self.delegate testReusableView:self att:att];
    }
    
    return att;
}

@end
