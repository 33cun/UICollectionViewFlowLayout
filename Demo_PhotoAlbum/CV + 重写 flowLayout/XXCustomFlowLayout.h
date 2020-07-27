//
//  XXCustomFlowLayout.h
//  Demo_PhotoAlbum
//
//  Created by Eleven on 2020/7/27.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XXCustomFlowLayout;
@protocol XXCustomFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

@optional
/// 设置 section 的最大列数
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout maxColumnInSection:(NSInteger)section;

/// 装饰view elementKind
- (NSString *)collectionView:(UICollectionView *)collectionView layoutAttributesForDecorationViewAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView contentViewContentSize:(CGSize)contentSize;

@end


@interface XXCustomFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<XXCustomFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
