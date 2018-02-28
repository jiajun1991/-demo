//
//  AnimatedAlert.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/13.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "AnimatedAlert.h"

@interface AnimatedAlert()
@property (copy ,nonatomic)NSString *leftBtnTitle;
@property (copy ,nonatomic)NSString *rightBtnTitle;
@property (copy ,nonatomic)NSString *contentText;
@end

@implementation AnimatedAlert
- (instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle contentText:(NSString *)contentText cancel:(cancelBlock)cancel confirm:(confirmBlock)confirm
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.leftBtnTitle = leftTitle;
        self.rightBtnTitle = rightTitle;
        self.contentText = contentText;
        self.cancel = cancel;
        self.confirm = confirm;
        self.alpha = 0;
        [self initView];
    }
    return self;
}
- (void)layoutSubviews
{
    //       动画效果
    [self animate];
}
- (void)animate
{
//    弹簧效果
    [UIView animateWithDuration:1 delay:0.2 usingSpringWithDamping:0.4 initialSpringVelocity:0.6 options:UIViewAnimationOptionCurveEaseIn animations:^{
//        self.frame = CGRectMake(0, 0, 300, 150);
        self.center = self.superview.center;
        self.alpha = 1;
    } completion:nil];
}
- (void)initView
{
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height * 0.2)];
    titleLabel.backgroundColor = [UIColor greenColor];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.text = @"提示";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.2, self.frame.size.width, self.frame.size.height * 0.6)];
    contentLabel.textColor = [UIColor greenColor];
    contentLabel.font = [UIFont systemFontOfSize:16];
    contentLabel.numberOfLines = 0;
    contentLabel.text = self.contentText;
    [self addSubview:contentLabel];
    
    UIButton *cancelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, self.frame.size.height * 0.8, self.frame.size.width/2-1, self.frame.size.height * 0.2)];
    [cancelBtn setTitle:self.leftBtnTitle forState:UIControlStateNormal];
    cancelBtn.backgroundColor = [UIColor greenColor];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [cancelBtn addTarget:self action:@selector(cancelDidTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIButton *confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.frame.size.width/2+1, self.frame.size.height * 0.8, self.frame.size.width/2-1, self.frame.size.height * 0.2)];
    [confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    confirmBtn.backgroundColor = [UIColor greenColor];
    [confirmBtn setTitle:self.rightBtnTitle forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [confirmBtn addTarget:self action:@selector(confirmDidTouch) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
}
- (void)cancelDidTouch
{
    if (self.cancel) {
        self.cancel(self);
    }
}
- (void)confirmDidTouch
{
    if (self.confirm) {
        self.confirm(self);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
