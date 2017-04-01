//
//  ViewController.m
//  CHTPlaceholderView
//
//  Created by cht on 17/3/30.
//  Copyright © 2017年 Roy Chan. All rights reserved.
//

#import "ViewController.h"

#define HEIGHT_REFRESH 20.0

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置如果tableview的内容没有占满整个collectionView，
    //这个就不能下拉滑动，没法实现下拉；但是设置下面这个就可以实现下拉了
    self.tableView.alwaysBounceVertical = YES;
    
}

- (void) loadRefreshView
{
    // 下拉刷新
    _refreshControl = [[UIRefreshControl alloc] init];
    _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:_refreshControl];
    [self.tableView sendSubviewToBack:_refreshControl];
}

// 设置刷新状态
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    decelerate = YES;
    if (scrollView.contentOffset.y < HEIGHT_REFRESH) {
        dispatch_async(dispatch_get_main_queue(), ^{
            _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"正在刷新"];
        });
        [_refreshControl beginRefreshing];
        [self loadData];
    }
}

// 设置刷新状态
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= HEIGHT_REFRESH) {
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    }
    else if (!scrollView.decelerating) {
        _refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"松开刷新"];
    }
}

// 结束刷新
- (void) endRefreshControl
{
    [_refreshControl endRefreshing];
}

// 刷新的回调方法
- (void) loadData
{
    [self endRefreshControl];
    // [self performSelector:@selector(endRefreshControl) withObject:nil afterDelay:2];
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row %ld",indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
