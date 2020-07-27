//
//  XXCustomCVVC2.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kCell       @"cell"
#define kHeader     @"header"
#define kLeft       (kMargin * 2 + 60.f)
#define kCellWH     ((SCREEN_WIDTH - kLeft - kSMargin * 2 - kMargin) / 3)

#import "XXCustomCVVC2.h"

#import "XXPhotoCell.h"
#import "XXTestReusableView.h"

#import "XXCustomCollectionViewFlowLayout.h"    //
#import "WaterFlowLayout.h" //  不兼容多section
#import "XXCustomFlowLayout.h"  //  可兼容多 seciton

#import "XXPhotoAlbumModel.h"
#import "XXTools.h"


@interface XXCustomCVVC2 () <UICollectionViewDataSource, UICollectionViewDelegate, XXTestReusableViewDelegate, WaterFlowLayoutDelegate, XXCustomFlowLayoutDelegate>

@property (nonatomic, strong) YYFPSLabel *lb_fps;

@property (nonatomic, strong) XXCustomCollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) WaterFlowLayout *fl_fall;
@property (nonatomic, strong) XXCustomFlowLayout *fl_custom;
@property (nonatomic, strong) UICollectionView *cv;

@property (nonatomic, strong) NSArray<XXPhotoAlbumModel *> *models;

@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *atts;


@end


@implementation XXCustomCVVC2

#pragma mark - Life Cycle
- (instancetype)init {
    if (self = [super init]) {
        _atts = [NSMutableArray arrayWithCapacity:0];
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
    
//    [self.lb_fps mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).inset(24.f + kSMargin);
//    }];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.lb_fps];
}


#pragma mark - Data
- (void)setupData {
    self.models = [self testLocalJson];
    
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:@[
        @(9), @(1), @(10), @(100), @(50)
    ]];
    
    for (int i = 0; i < 20; ++i) {
        [arr addObject:@((arc4random() % 100) + 1)];
    }
    
    [XXTools heapSortWithArray:arr];
    
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
    if (_flowLayout) return self.models.count;
    if (_fl_fall || _fl_custom) return 3;
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (_flowLayout) return self.models[section].count;
    if (_fl_fall || _fl_custom) return 10;
    
    return 0;
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

#pragma mark Header 的 size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(kCellWH, kCellWH);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        XXTestReusableView *v_header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeader forIndexPath:indexPath];
        v_header.delegate = self;
        
        return v_header;
    }
    
    return nil;
}


#pragma mark - WaterFlowLayoutDelegate Methods
- (CGFloat)waterFlow:(WaterFlowLayout *)layout heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    return 45.f + (random() % 60 + 1);
}


#pragma mark - GLFlowLayoutDelegate Methods
- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout maxColumnInSection:(NSInteger)section {
    return 3;
}


#pragma mark - XXTestReusableViewDelegate Methods
- (void)testReusableView:(XXTestReusableView *)view att:(UICollectionViewLayoutAttributes *)att {
    if (![self.atts containsObject:att]) {
        [self.atts addObject:att];
    }
}

static NSUInteger oldCount = 0;

#pragma mark - UIScrollViewDelegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat svOffsetY = scrollView.contentOffset.y;
    
    NSArray <XXPhotoCell *> *cellArray = [self.cv visibleCells];
    //cell的section的最小值
    NSUInteger cellSectionMINCount = UINT_MAX;
    for (int i = 0; i < cellArray.count; i++) {
        XXPhotoCell *cell = cellArray[i];
        NSUInteger cellSection = [self.cv indexPathForCell:cell].section;
        if (cellSection < cellSectionMINCount) {
            cellSectionMINCount = cellSection;
        }
    }
    
    if (oldCount != cellSectionMINCount) {
        NSLog(@"当前悬停的组头是:%ld    %@", cellSectionMINCount, @"p-");
        oldCount = cellSectionMINCount;
    }
    
    /*
    NSArray *arr = [self.cv visibleCells];
    
    XXPhotoCell *firstCell = arr.firstObject;
    
    NSIndexPath *indexPath = [self.cv indexPathForCell:firstCell];
    
    NSLog(@"--------------> %@", indexPath);
     */
}


#pragma mark - Request


#pragma mark - Setter


#pragma mark - Getter
- (XXCustomCollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[XXCustomCollectionViewFlowLayout alloc] init];
    }
    
    return _flowLayout;
}

- (WaterFlowLayout *)fl_fall {
    if (!_fl_fall) {
        _fl_fall = [[WaterFlowLayout alloc] init];
        _fl_fall.delegate = self;
        _fl_fall.colum = 2;
        _fl_fall.insetSpace = UIEdgeInsetsMake(kMargin, kMargin, kMargin, kMargin);
        _fl_fall.distance = kMargin;
    }
    
    return _fl_fall;
}

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
        [_cv registerClass:[XXTestReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kHeader];
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
