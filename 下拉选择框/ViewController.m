//
//  ViewController.m
//  下拉选择框
//
//  Created by xiaofei on 2017/8/14.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "MultiButton.h"

#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong)NSArray *titleArr;             // 按钮初始值
@property (nonatomic, assign)NSInteger index;               // 点击第几个按钮
@property (nonatomic, strong)MultiButton *multiBtn;         // 按钮控件

@property (nonatomic, strong)UITableView *listTableView;     // 列表下拉框
@property (nonatomic, strong)NSArray *selectArr;            // 下拉数据

@property (nonatomic, strong)UIView *bgView;                // 灰色背景
@property (nonatomic, strong)NSMutableArray *selectedArr;    // 选择的内容

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    [self createTopView];
}

- (void)createTopView {
    self.titleArr = @[@"项目类型", @"年化利率", @"项目状态"];
    MultiButton *multiBtn = [[MultiButton alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 44) TitArr:self.titleArr];
    self.multiBtn = multiBtn;
    [self.view addSubview:multiBtn];
    [multiBtn setBtnBlock:^(NSInteger index, BOOL isSelected){
        self.index = index;
        if (isSelected) {
            [self hidenTableView];
        }else {
            [self showTableViewWithIndex:index];
        }
    }];
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    [window addSubview:self.bgView];
    [window addSubview:self.listTableView];
}

//隐藏下拉列表
- (void)hidenTableView {
    self.multiBtn.isSelected = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.listTableView.frame = CGRectMake(0, 64 + 44, SCREEN_WIDTH, 0);
        self.bgView.hidden = YES;
    }];
    [self.multiBtn resetButtonStatus];
}
//显示下拉列表
- (void)showTableViewWithIndex:(NSInteger)index {
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.listTableView.frame;
        frame.size.height = [self.selectArr[index] count] * 44;
        frame.size.width = CGRectGetMaxX(self.view.frame);
        self.listTableView.frame = frame;
    }];
    self.multiBtn.isSelected = YES;
    [self.listTableView reloadData];
    self.bgView.hidden = NO;
}
// 灰色背景点击事件隐藏下拉列表
- (void)tapGesture:(UITapGestureRecognizer *)tap {
    [self hidenTableView];
}


#pragma mark    ----UITableView代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectArr[self.index] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    NSDictionary *dict = self.selectArr[self.index][indexPath.row];
    cell.textLabel.text = dict[@"name"];
    NSDictionary *selectedDict = self.selectedArr[self.index];
    
    if ([selectedDict[@"name"] isEqualToString:dict[@"name"]]) {
        cell.textLabel.textColor = [UIColor blueColor];
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"access_selected"]];
    }else {
        cell.textLabel.textColor = [UIColor blackColor];
        cell.accessoryView = nil;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedArr replaceObjectAtIndex:self.index withObject:self.selectArr[self.index][indexPath.row]];
    if (indexPath.row == 0) {
        [self.multiBtn setTitleWithStr:self.titleArr[self.index] ForBtn:self.index];
    }else {
        NSDictionary *dict = self.selectArr[self.index][indexPath.row];
        [self.multiBtn setTitleWithStr:dict[@"name"] ForBtn:self.index];
    }
    NSLog(@"%@", self.selectedArr);
    
    [self hidenTableView];
}

#pragma mark    ----lazy load
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64 + 44, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44)];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0.5;
        _bgView.hidden = YES;
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
        [_bgView addGestureRecognizer:tapGesture];
    }
    return _bgView;
}

- (UITableView *)listTableView {
    if (!_listTableView) {
        _listTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 44, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.tag = 54321;
    }
    return _listTableView;
}

- (NSArray *)selectArr {
    if (!_selectArr) {
        _selectArr = @[@[@{@"name":@"全部", @"type": @""},
                         @{@"name":@"新人计划", @"type": @"NEW_USER_PLAN"},
                         @{@"name":@"月标", @"type": @"MONTH_PLAN"},
                         @{@"name":@"季度标", @"type": @"THREE_MONTH_PLAN"},
                         @{@"name":@"半年标", @"type": @"SIX_MONTH_PLAN"},
                         @{@"name":@"年标", @"type": @"YEAR_PLAN"}],
                       @[@{@"name":@"全部", @"rateMin":@"", @"rateMax":@""},
                         @{@"name":@"8%以下", @"rateMin":@"0.0", @"rateMax":@"0.08"},
                         @{@"name":@"8%-10%", @"rateMin":@"0.08", @"rateMax":@"0.1"},
                         @{@"name":@"10%-12%", @"rateMin":@"0.1", @"rateMax":@"0.12"},
                         @{@"name":@"12%以上", @"rateMin":@"0.12", @"rateMax":@"1"},],
                       @[@{@"name":@"全部", @"type": @""},
                         @{@"name":@"募集中", @"type": @"BIDDING"},
                         @{@"name":@"募集结束", @"type": @"FILLED"}]];
    }
    return _selectArr;
}

- (NSMutableArray *)selectedArr {
    if (!_selectedArr) {
        _selectedArr = [NSMutableArray arrayWithObjects:@{@"name":@"全部", @"type":@""}, @{@"name":@"全部", @"rateMin":@"", @"rateMax":@""}, @{@"name":@"全部", @"type":@""}, nil];
    }
    return _selectedArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
