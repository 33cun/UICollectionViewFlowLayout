//
//  XXCustomCVVC.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kCell       @"cell"
#define kHeader     @"header"
#define kLeft       (kMargin * 2 + 60.f)
#define kCellWH     ((SCREEN_WIDTH - kLeft - kSMargin * 2 - kMargin) / 3)


#import "XXCustomCVVC.h"

#import "XXCollectionViewLayout.h"

#import "XXPhotoCell.h"
#import "XXAlbumHeaderReusableView.h"

#import "XXPhotoAlbumModel.h"


@interface XXCustomCVVC () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *cv;

@property (nonatomic, strong) NSArray<XXPhotoAlbumModel *> *models;

@property (nonatomic, strong) YYFPSLabel *lb_fps;

@end

@implementation XXCustomCVVC
- (void)dealloc {
    NSLog(@"%s", __func__);
}

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}


#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.cv];
    [self.view addSubview:self.lb_fps];
    
    [self.cv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.lb_fps mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).inset(24.f + kSMargin);
    }];
}


#pragma mark - Data
- (void)setupData {
    self.models = [self testLocalJson];
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods
- (NSArray *)testLocalJson {
    NSString *dataFilePath = [[NSBundle mainBundle] pathForResource:@"photoAlbumData" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:dataFilePath];
    NSDictionary *rootDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSArray *feedDicts = rootDict[@"data"];
    
    NSMutableArray *models = [NSMutableArray arrayWithCapacity:0];
    
    for (NSDictionary *dict in feedDicts) {
        XXPhotoAlbumModel *model = [[XXPhotoAlbumModel alloc] initWithDict:dict];
        [models addObject:model];
    }
    
    return models.copy;
}


#pragma mark - Delegate
#pragma mark UICollectionViewDelegate Methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.models.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return self.models[section].count;
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
    return UIEdgeInsetsMake(kSMargin, kLeft, kMargin * 2, kMargin);
}

#pragma mark 每列之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return -5;
}

#pragma mark 每行之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kSMargin;
}

#pragma mark   点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark Header 的 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kCellWH, kCellWH);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XXAlbumHeaderReusableView *v_header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeader forIndexPath:indexPath];

        return v_header;
    }
    
    return nil;
}


#pragma mark - Request


#pragma mark - Setter


#pragma mark - Getter
- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    
    return _flowLayout;
}

- (UICollectionView *)cv {
    if (!_cv) {
        _cv = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _cv.backgroundColor = [UIColor whiteColor];
        _cv.delegate = self;
        _cv.dataSource = self;
//        _cv.scrollEnabled = NO;
        [_cv registerClass:[XXPhotoCell class] forCellWithReuseIdentifier:kCell];
        [_cv registerClass:[XXAlbumHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeader];

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
