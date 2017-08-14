//
//  MultiButton.m
//  Predicate
//
//  Created by xiaofei on 2017/6/29.
//  Copyright © 2017年 xiaofei. All rights reserved.
//

#import "MultiButton.h"
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT   [UISCreen mainScreen].bounds.size.height

@interface XFRecordsButton : UIButton

@property (nonatomic, assign)NSInteger countBtn;

@end

@implementation XFRecordsButton

- (instancetype)initWithCount:(NSInteger)count {
    if (self = [super init]) {
        self.countBtn = count;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = CGRectMake((SCREEN_WIDTH/self.countBtn - 80)/2, 12, 80, 20);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(SCREEN_WIDTH/self.countBtn / 2 + 40, 20, 7, 4);
}

@end

@interface MultiButton ()

@property (nonatomic, strong)NSArray *titArr;

@end

@implementation MultiButton

- (instancetype)initWithFrame:(CGRect)frame TitArr:(NSArray *)titArr {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titArr = titArr;
        [self createBtn];
    }
    return self;
}

- (void)createBtn {
    if (self.titArr.count == 0) {
        return;
    }
    CGFloat width = CGRectGetMaxX(self.frame)/self.titArr.count;
    for (NSInteger i=0; i<self.titArr.count; i++) {
        XFRecordsButton *btn = [[XFRecordsButton alloc] initWithCount:self.titArr.count];
        btn.frame = CGRectMake(width * i, 0, width, 44);
        btn.tag = 100 + i;
        btn.selected = NO;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setTitle:self.titArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"records_unselected"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"records_selected"] forState:UIControlStateSelected];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i != 0) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(width * i, 0, 0.5, 44)];
            lineView.backgroundColor = [UIColor lightGrayColor];
            [self addSubview:lineView];
        }
    }
    UIView *vLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, self.frame.size.width, 0.5)];
//    vLineView.backgroundColor = [UIColor lightGrayColor];
    vLineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:vLineView];
    
}

- (void)btnClick:(UIButton *)btn {
    for (UIView *view in btn.superview.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *selectBtn = (UIButton *)view;
            if (selectBtn.tag == btn.tag) {
                selectBtn.selected = !selectBtn.selected;
            }else {
                selectBtn.selected = NO;
            }
        }
    }
    if (_btnBlock) {
        _btnBlock(btn.tag - 100, self.isSelected);
    }
//    if ([self.delegate respondsToSelector:@selector(typeButtonSelectedWithIndex:isSelected:)]) {
//        [self.delegate typeButtonSelectedWithIndex:btn.tag - 100 isSelected:btn.selected];
//        btn.selected = !btn.selected;
//    }
}

- (void)setTitleWithStr:(NSString *)titleStr ForBtn:(NSInteger)tag {
    UIButton *btn = [self viewWithTag:100 + tag];
    [btn setTitle:titleStr forState:UIControlStateNormal];
}

- (void)resetButtonStatus {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            btn.selected = NO;
        }
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
