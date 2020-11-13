//
//  PreviewViewController.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "PreviewViewController.h"
#import <WebKit/WKWebView.h>
@interface PreviewViewController ()<UIDocumentInteractionControllerDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (strong, nonatomic) UIDocumentInteractionController *documentController;
@end

@implementation PreviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height-44-20)];
    [self.view addSubview:self.webView];
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [self.webView loadRequest:request];
}

- (IBAction)closeBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)shareOtherAppAction:(id)sender {
    NSLog(@"调用UIDocumentInteractionController分享给其他app");
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:self.url];
    BOOL canOpen = [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    if (!canOpen) {
        NSLog(@"没有程序可以打开选中的文件");
    }
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
