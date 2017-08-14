//
//  MultiButton.h
//  Predicate
//
//  Created by xiaofei on 2017/6/29.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MultiButtonDelegate <NSObject>

- (void)typeButtonSelectedWithIndex:(NSInteger)index isSelected:(BOOL)isSelected;

@end

@interface MultiButton : UIView

@property (nonatomic, strong)id<MultiButtonDelegate> delegate;

@property (nonatomic, strong)void (^btnBlock)(NSInteger, BOOL);

@property (nonatomic, assign)BOOL isSelected;

- (instancetype)initWithFrame:(CGRect)frame TitArr:(NSArray *)titArr;

- (void)setTitleWithStr:(NSString *)titleStr ForBtn:(NSInteger)tag;

- (void)resetButtonStatus;

@end
