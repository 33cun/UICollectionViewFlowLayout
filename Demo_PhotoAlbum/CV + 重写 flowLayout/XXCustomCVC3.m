//
//  XXCustomCVC3.m
//  Demo_PhotoAlbum
//
//  Created by Eleven on 2020/7/27.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kCell       @"cell"
#define kLeft       (kMargin * 2 + 60.f)
#define kCellWH     ((SCREEN_WIDTH - kLeft - kSMargin * 2 - kMargin) / 3)


#import "XXCustomCVC3.h"
#import "XXCustomFlowLayout.h"  //  可兼容多 seciton
#import "XXPhotoCell.h"


@interface XXCustomCVC3 () <UICollectionViewDataSource, UICollectionViewDelegate, XXCustomFlowLayoutDelegate>

@property (nonatomic, strong) YYFPSLabel *lb_fps;

@property (nonatomic, strong) XXCustomFlowLayout *fl_custom;
@property (nonatomic, strong) UICollectionView *cv;

@end


@implementation XXCustomCVC3

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}


#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.cv];
    [self.view addSubview:self.lb_fps];
    
    [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.lb_fps];
}


#pragma mark - Data
- (void)setupData {
    
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate
#pragma mark UICollectionViewDelegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XXPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
    cell.backgroundColor = RandomColor;
    [cell load:indexPath];
    
    return cell;
}

#pragma mark 设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat WH = kCellWH;
    
    if (indexPath.row == 0) return CGSizeMake((kLeft - kSMargin * 2), WH);
    
    return CGSizeMake(WH, WH);
}

#pragma mark 设置每个 item 的 UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kSMargin, kLeft, kMargin * 2, kMargin);
}

#pragma mark 每列之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kSMargin;
}

#pragma mark 每行之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSMargin;
}

#pragma mark 点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"--> clicked section - %ld, row - %ld", indexPath.section, indexPath.row);
}


#pragma mark - XXCustomFlowLayoutDelegate Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout maxColumnInSection:(NSInteger)section {
    return 3.f;
}


#pragma mark - Getter
- (XXCustomFlowLayout *)fl_custom {
    if (!_fl_custom) {
        _fl_custom = [[XXCustomFlowLayout alloc] init];
        _fl_custom.delegate = self;
    }
    
    return _fl_custom;
}

- (UICollectionView *)cv {
    if (!_cv) {
        _cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.fl_custom];
        _cv.backgroundColor = [UIColor whiteColor];
        _cv.delegate = self;
        _cv.dataSource = self;
        [_cv registerClass:[XXPhotoCell class] forCellWithReuseIdentifier:kCell];
    }
    
    return _cv;
}

- (YYFPSLabel *)lb_fps {
    if (!_lb_fps) {
        _lb_fps = [YYFPSLabel new];
    }
    
    return _lb_fps;
}

@end
