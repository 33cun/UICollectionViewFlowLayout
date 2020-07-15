//
//  XXTBCVVC.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/15.
//  Copyright © 2020 Eleven. All rights reserved.
//

#import "XXTBCVVC.h"

#import "XXAlbumCell.h"

#import "XXPhotoAlbumModel.h"


@interface XXTBCVVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tb;
@property (nonatomic, copy) NSArray<XXPhotoAlbumModel *> *dataSource;

@property (nonatomic, strong) YYFPSLabel *lb_fps;


@end

@implementation XXTBCVVC

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}


#pragma mark - UI
- (void)setupUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tb];
    [self.view addSubview:self.lb_fps];
    
    [self.tb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    [self.lb_fps mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).inset(24.f + kSMargin);
    }];
}


#pragma mark - Data
- (void)setupData {
    self.dataSource = [self testLocalJson];
    [self.tb reloadData];
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
    
    return models;
}


#pragma mark - Delegate
#pragma mark - UITableViewDataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger num = self.dataSource.count;
    return num;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXPhotoAlbumModel *model = self.dataSource[indexPath.section];
    
    XXAlbumCell *cell = [XXAlbumCell cellWithTableView:tableView];
    [cell load:model];
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    XXPhotoAlbumModel *model = self.dataSource[indexPath.section];
    return model.cellH;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


#pragma mark - Request


#pragma mark - Setter


#pragma mark - Getter
- (UITableView *)tb {
    if (!_tb) {
        _tb = [[UITableView alloc] init];
        _tb.delegate = self;
        _tb.dataSource = self;
        _tb.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tb.backgroundColor = [UIColor magentaColor];
        [_tb registerClass:[XXAlbumCell class] forCellReuseIdentifier:NSStringFromClass([XXAlbumCell class])];

    }
    
    return _tb;
}

- (YYFPSLabel *)lb_fps {
    if (!_lb_fps) {
        _lb_fps = [YYFPSLabel new];
    }
    
    return _lb_fps;
}

@end
