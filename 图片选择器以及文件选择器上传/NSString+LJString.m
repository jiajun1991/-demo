//
//  NSString+LJString.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "NSString+LJString.h"

@implementation NSString (LJString)
+(NSString *)getFileName
{
    NSString *str = (NSString *)self;
    NSArray *arr = [str componentsSeparatedByString:@"."];
    return arr.firstObject;
}
+(NSString *)getFileType
{
    NSString *str = (NSString *)self;
    NSArray *arr = [str componentsSeparatedByString:@"."];
    return arr[1];
}
@end
