//
//  AnimatedAlert.h
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/13.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^cancelBlock)(UIView *animateAlert);
typedef void (^confirmBlock)(UIView *animateAlert);
@interface AnimatedAlert : UIView
@property (copy ,nonatomic)cancelBlock cancel;
@property (copy ,nonatomic)confirmBlock confirm;
- (instancetype)initWithFrame:(CGRect)frame leftTitle:(NSString *)leftTitle rightTitle:(NSString *)rightTitle contentText:(NSString *)contentText cancel:(cancelBlock)cancel confirm:(confirmBlock)confirm;
@end
