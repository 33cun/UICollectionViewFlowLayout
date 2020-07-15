//
//  XXAlbumCell.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/14.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kCell           @"cell"

#import "XXAlbumCell.h"
#import "XXPhotoCell.h"

#import "XXPhotoAlbumModel.h"


@interface XXAlbumCell () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *cv;

@property (nonatomic, strong) UILabel *lb_title;
@property (nonatomic, strong) UIView *v_line;

@property (nonatomic, strong) XXPhotoAlbumModel *model;

@end


@implementation XXAlbumCell

#pragma mark - Life Cycle
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"XXAlbumCell";
    
    // 1.缓存中取
    XXAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    // 2.创建
    if (cell == nil) {
        cell = [[XXAlbumCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self setupUI];
        [self setupData];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}


#pragma mark - UI
- (void)setupUI {
    [self addSubview:self.lb_title];
    [self addSubview:self.cv];
    [self addSubview:self.v_line];
    
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).inset(kMargin);
        make.width.mas_equalTo(kTitleLabelW);
    }];
    
    [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.and.right.equalTo(self).inset(kMargin);
        make.left.equalTo(self.lb_title.mas_right).inset(kMargin);
    }];
    
    [self.v_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self);
        make.bottom.equalTo(self).inset(kMargin);
        make.height.mas_equalTo(1.f);
    }];
}


#pragma mark - Data
- (void)setupData {
    
}


#pragma mark - Event Response


#pragma mark - Public Methods
- (void)load:(XXPhotoAlbumModel *)model {
    self.model = model;
    [self.cv reloadData];
}


#pragma mark - Private Methods


#pragma mark - Delegate
#pragma mark UICollectionViewDelegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    cell.backgroundColor = RandomColor;
    
    return cell;
}

#pragma mark    设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat WH = kCellWH;
    return CGSizeMake(WH, WH);
}

#pragma mark    设置每个 item 的 UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark 每列之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark 每行之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSMargin;
}

#pragma mark   点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}


#pragma mark - Request


#pragma mark - Setter


#pragma mark - Getter
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    
    return _flowLayout;
}

- (UICollectionView *)cv {
    if (!_cv) {
        _cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _cv.backgroundColor = [UIColor whiteColor];
        _cv.delegate = self;
        _cv.dataSource = self;
        _cv.scrollEnabled = NO;
        [_cv registerClass:[XXPhotoCell class] forCellWithReuseIdentifier:kCell];
    }
    
    return _cv;
}

- (UILabel *)lb_title {
    if (!_lb_title) {
        _lb_title = [[UILabel alloc] init];
        _lb_title.font = [UIFont boldSystemFontOfSize:18.f];
        _lb_title.textColor = [UIColor blackColor];
        _lb_title.textAlignment = NSTextAlignmentLeft;
        _lb_title.text = @"本周";
    }
    
    return _lb_title;
}

- (UIView *)v_line {
    if (!_v_line) {
        _v_line = [[UIView alloc] init];
        _v_line.backgroundColor = [UIColor lightGrayColor];
    }
    
    return _v_line;
}



@end
