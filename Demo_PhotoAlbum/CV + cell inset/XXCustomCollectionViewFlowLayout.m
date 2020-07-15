//
//  XXCustomCollectionViewFlowLayout.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXCustomCollectionViewFlowLayout.h"

@implementation XXCustomCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * layoutAttributes_t = [super layoutAttributesForElementsInRect:rect];
    NSArray * layoutAttributes = [[NSArray alloc] initWithArray:layoutAttributes_t copyItems:YES];
    
    //  总偏移量
    CGFloat offsetY = 0;
    CGFloat firstY = 0;
    for (UICollectionViewLayoutAttributes *currentAttr in layoutAttributes) {
        if (!firstY) {
//            firstY = currentAttr.frame.origin.y;
        }
        
        //  11dsf
        //  df
//        offsetY = firstY * currentAttr.indexPath.section;
        
        if (currentAttr.zIndex == 10) { //  设置 headerview frame
            currentAttr.frame = CGRectMake(0, currentAttr.frame.origin.y - offsetY, currentAttr.size.height, currentAttr.size.height);
        } else {
            CGFloat y = currentAttr.frame.origin.y;
            currentAttr.frame = CGRectMake(currentAttr.frame.origin.x, y - firstY - offsetY, currentAttr.frame.size.width, currentAttr.frame.size.height);
        }
    }
    
    return layoutAttributes;
}

@end
