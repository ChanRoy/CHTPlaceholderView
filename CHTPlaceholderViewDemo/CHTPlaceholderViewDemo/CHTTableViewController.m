//
//  CHTTableViewController.m
//  CHTPlaceholderViewDemo
//
//  Created by cht on 2017/4/1.
//  Copyright © 2017年 cht. All rights reserved.
//

#import "CHTTableViewController.h"
#import "UIViewController+CHTPlaceholderView.h"

@interface CHTTableViewController ()

@property (nonatomic, assign) NSUInteger dataCount;

@property (nonatomic, assign) NSInteger flag;

@end

@implementation CHTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
    
    _dataCount = 10;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];

}

- (void)loadData{
    
    /*
     _flag == 1 : CHTPlaceholderViewTypeNoData
     _flag == 3 : CHTPlaceholderViewTypeNoConnect
     _flag == 5 : CHTPlaceholderViewTypeError
     _flag % 2 == 0 : show tableview
     */
    
    [self.refreshControl beginRefreshing];
    
    if(_flag == 6) _flag = 0;
    
    _flag ++;
    
    if (_flag%2 == 0) {
        
        _dataCount = 10;
        [self hidePlaceholderView];
    }else{
        
        _dataCount = 0;
        if (_flag == 1) {
            [self showPlaceholderViewInView:self.view placeholderViewType:CHTPlaceholderViewTypeNoData];
        }else if (_flag == 3){
            
            [self showPlaceholderViewInView:self.view placeholderViewType:CHTPlaceholderViewTypeNoConnect];
            [self addTouchEventInPhViewWithTarget:self action:@selector(loadData)];
        }else if (_flag == 5){
            
            [self showPlaceholderViewInView:self.view placeholderViewType:CHTPlaceholderViewTypeError];
            [self addTouchEventInPhViewWithTarget:self action:@selector(loadData)];
        }
    }
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"row %ld",indexPath.row];
    
    return cell;
}

@end
