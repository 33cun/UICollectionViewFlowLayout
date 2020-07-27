//
//  XXPhotoCell.h
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/14.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXPhotoCell : UICollectionViewCell

@property (nonatomic, strong, readonly) UILabel *lb;


- (void)load:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
