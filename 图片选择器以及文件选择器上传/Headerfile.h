//
//  Headerfile.h
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#ifndef Headerfile_h
#define Headerfile_h
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif
//本地文件路径
#define DocumentPath [NSString stringWithFormat:@"%@/Inbox",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]]
#endif /* Headerfile_h */
