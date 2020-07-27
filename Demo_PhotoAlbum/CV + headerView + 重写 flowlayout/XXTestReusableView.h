//
//  XXTestReusableView.h
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XXTestReusableView;
@protocol XXTestReusableViewDelegate <NSObject>

@optional
- (void)testReusableView:(XXTestReusableView *)view att:(UICollectionViewLayoutAttributes *)att;

@end


@interface XXTestReusableView : UICollectionReusableView

@property (nonatomic, weak) id<XXTestReusableViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
