//
//  ViewController.m
//  LinkPageTableView
//
//  Created by polycom on 2017/5/16.
//  Copyright © 2017年 xuyafei. All rights reserved.
//

#import "ViewController.h"

#define LPScreenWidth   [[UIScreen mainScreen]bounds].size.width
#define LPScreenHeight  [[UIScreen mainScreen]bounds].size.height

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) UITableView *leftTableView;
@property (weak, nonatomic) UITableView *rightTableView;

@property (weak, nonatomic) NSMutableArray *datas;

@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;

@end

@implementation ViewController

- (NSMutableArray *)datas {
    if(!_datas) {
        _datas = [NSMutableArray array];
        for(NSUInteger i = 1; i <= 10; i++) {
            [_datas addObject:[NSString stringWithFormat:@"第%zd分区", i]];
        }
    }
    
    return _datas;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configTabelView];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configTabelView {
    UITableView *leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, LPScreenWidth * 0.25f, LPScreenHeight)];
    [self.view addSubview:leftTableView];
    self.leftTableView = leftTableView;
    
    UITableView *rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(LPScreenWidth * 0.25f, 0, LPScreenWidth * 0.75f, LPScreenHeight)];
    [self.view addSubview:rightTableView];
    self.rightTableView = rightTableView;
    
    rightTableView.delegate = leftTableView.delegate = self;
    rightTableView.dataSource = leftTableView.dataSource = self;
    
    /*[leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];*/
}

- (void)selectLeftTableViewWithScrollView:(UIScrollView *)scrollView {
    if(self.currentSelectIndexPath) {
        return;
    }
    
    if((UITableView *)scrollView == self.leftTableView)
        return;
    
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.rightTableView.indexPathsForVisibleRows.firstObject.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView == self.leftTableView)
        return 1;
    
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == self.leftTableView)
        return self.datas.count;
    
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if(tableView == self.leftTableView)
        return nil;
    
    return self.datas[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if(tableView == self.leftTableView) {
        cell.textLabel.text =self.datas[indexPath.row];
    } else {
        cell.textLabel.text = [NSString stringWithFormat:@"%@ ----- 第%zd行", self.datas[indexPath.section], indexPath.row + 1];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView == self.leftTableView)
        return 0;
    
    return 30;
}


@end
