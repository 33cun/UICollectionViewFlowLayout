//
//  XXPhotoAlbumModel.h
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XXPhotoAlbumModel : NSObject

@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, copy) NSArray *list;

@property (nonatomic, assign) CGFloat cellH;


- (instancetype)initWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
