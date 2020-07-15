//
//  XXPhotoAlbumModel.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXPhotoAlbumModel.h"

@implementation XXPhotoAlbumModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        self.time = dict[@"time"];
        self.count = [dict[@"count"] unsignedIntValue];
        self.list = dict[@"list"];
        
        [self calculationCellH];
    }
    
    return self;
}

- (void)calculationCellH {
    NSInteger row = ceil(self.count / 3);
    
    CGFloat cellWH = ((SCREEN_WIDTH - kMargin * 3 - 40.f - kSMargin * 2) / 3);
    
    self.cellH = cellWH * row + kSMargin * (row - 1) + kMargin;
}

@end
