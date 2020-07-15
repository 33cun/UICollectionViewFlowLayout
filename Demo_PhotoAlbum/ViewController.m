//
//  ViewController.m
//  Demo_PhotoAlbum
//
//  Created by 肖鑫 on 2020/7/14.
//  Copyright © 2020 Eleven. All rights reserved.
//

#define kCellID     @"cellID"


#import "ViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tb;
@property (nonatomic, copy) NSArray<NSDictionary *> *dataSource;

@end


@implementation ViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupData];
}


#pragma mark - UI
- (void)setupUI {
    [self.view addSubview:self.tb];
}


#pragma mark - Data
- (void)setupData {
    self.dataSource = @[
        @{
            @"name" : @"TB 嵌套 CV",
            @"className" : @"XXTBCVVC",
        }, @{
            @"name" : @"自定义 CV",
            @"className" : @"XXCustomCVVC",
        }, @{
            @"name" : @"自定义 CV 2",
            @"className" : @"XXCustomCVVC2",
        }
    ];
}


#pragma mark - Event Response


#pragma mark - Public Methods


#pragma mark - Private Methods


#pragma mark - Delegate
#pragma mark - UITableViewDataSource Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.row][@"name"];
    
    return cell;
}


#pragma mark - UITableViewDelegate Methods
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"%ld-%ld", (long)indexPath.section, (long)indexPath.row);
    
    NSString *className = self.dataSource[indexPath.row][@"className"];
    Class class = NSClassFromString(className);
    if (class) {
        UIViewController *ctrl = class.new;
        ctrl.title = self.dataSource[indexPath.row][@"name"];
        [self.navigationController pushViewController:ctrl animated:YES];
    }
}


#pragma mark - Request


#pragma mark - Setter


#pragma mark - Getter

- (UITableView *)tb {
    if (!_tb) {
        _tb = [[UITableView alloc] init];
        _tb.frame = self.view.bounds;
        _tb.delegate = self;
        _tb.dataSource = self;
        [_tb registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellID];
    }
    
    return _tb;
}


@end
