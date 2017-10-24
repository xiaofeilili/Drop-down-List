//
//  DropDownList.h
//  下拉选择框
//
//  Created by xiaofei on 2017/10/24.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DropDownList : NSObject

@property (nonatomic, strong)void (^selectBlock)(NSArray *);        // 点击选项条回调
@property (nonatomic, strong)NSArray *selectArr;                    // 选择
@property (nonatomic, strong)UIViewController *viewController;       // 所在控制器

- (void)initailView;
- (void)showTableViewWithIndex:(NSInteger)index;

@end
