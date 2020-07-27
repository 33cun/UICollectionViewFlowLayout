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
    NSArray<UICollectionViewLayoutAttributes *> *layoutAttributes = [[NSArray alloc] initWithArray:layoutAttributes_t copyItems:YES];
    
    //  总偏移量
    CGFloat offsetY = 0;
    CGFloat sectionFirstY = layoutAttributes.firstObject.frame.size.height + self.minimumLineSpacing;
    CGFloat diff = 0;
    NSUInteger curSection = 0;
    for (UICollectionViewLayoutAttributes *currentAttr in layoutAttributes) {
        
//        if (currentAttr.indexPath.row == 0 && curSection == currentAttr.indexPath.section) {
////            offsetY += sectionFirstY;
//            ++curSection;
//            NSLog(@"----------> Current Section -> %ld", curSection);
//        }
        
        offsetY = sectionFirstY * (currentAttr.indexPath.section + 1);
        if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) { //  设置 headerview frame
            currentAttr.frame = CGRectMake(0, currentAttr.frame.origin.y - sectionFirstY * (currentAttr.indexPath.section), currentAttr.size.height, currentAttr.size.height);
        } else {
            if (!diff) {
                diff = currentAttr.frame.origin.y - sectionFirstY;
            }
            
            CGFloat y = currentAttr.frame.origin.y;
            currentAttr.frame = CGRectMake(currentAttr.frame.origin.x, y - 0 - offsetY, currentAttr.frame.size.width, currentAttr.frame.size.height);
        }
    }
    
    return layoutAttributes;
}

@end
