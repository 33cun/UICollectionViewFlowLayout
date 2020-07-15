//
//  XXAlbumCell.h
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/14.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kTitleLabelW    40.f
#define kCellWH     ((SCREEN_WIDTH - kMargin * 3 - kTitleLabelW - kSMargin * 2) / 3)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XXPhotoAlbumModel;
@interface XXAlbumCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)load:(XXPhotoAlbumModel *)model;

@end

NS_ASSUME_NONNULL_END
