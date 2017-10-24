//
//  ViewController.m
//  下拉选择框
//
//  Created by xiaofei on 2017/8/14.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "ViewController.h"
#import "DropDownList.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    DropDownList *dList = [[DropDownList alloc] init];
    dList.viewController = self;
    [dList initailView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
