//
//  SelectedFileCollectionViewCell.h
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectedFileCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backIV;
@property (weak, nonatomic) IBOutlet UILabel *fileNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *selectIV;
@end
