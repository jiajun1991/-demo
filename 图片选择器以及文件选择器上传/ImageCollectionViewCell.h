//
//  ImageCollectionViewCell.h
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/26.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^closeBlock)(void);
@interface ImageCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iv;
@property (copy, nonatomic)closeBlock close;
- (void)close:(closeBlock)block;
@end
