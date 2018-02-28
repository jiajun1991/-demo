//
//  ImageCollectionViewCell.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/26.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "ImageCollectionViewCell.h"

@implementation ImageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)closeAction:(id)sender {
    if (self.close) {
        self.close();
    }
}
- (void)close:(closeBlock)block
{
    self.close = block;
}
@end
