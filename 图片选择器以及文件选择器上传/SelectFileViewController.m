//
//  SelectFileViewController.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "SelectFileViewController.h"
#import "Headerfile.h"
#import "SelectedFileCollectionViewCell.h"
#import "AnimatedAlert.h"
#import "PreviewViewController.h"
@interface SelectFileViewController ()<UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (strong ,nonatomic)UICollectionView *fileCV;
@property (strong ,nonatomic)NSMutableArray *fileArray;
@property (strong ,nonatomic)NSMutableArray *flagArray;
@end

@implementation SelectFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"文件";
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(144, 144);
    self.fileCV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-60) collectionViewLayout:flowLayout];
    [self.view addSubview:self.fileCV];
    
    [self.fileCV registerNib:[UINib nibWithNibName:@"SelectedFileCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"fileCellID"];
    self.fileCV.delegate = self;
    self.fileCV.dataSource = self;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    self.fileArray = [[NSMutableArray alloc]initWithArray:[fileManager contentsOfDirectoryAtPath:DocumentPath error:nil]];
    NSLog(@"%@",self.fileArray);
    
    [self.fileCV reloadData];
    
}
//标志位数组初始化
- (NSMutableArray *)flagArray
{
    if (!_flagArray) {
        _flagArray = [NSMutableArray array];
        for (int i = 0; i < self.fileArray.count; i++) {
            [self.flagArray addObject:@0];
        }
    }
    return _flagArray;
}
//点击目标给数组内的对象取反
- (void)getOpposedObject:(NSInteger)index
{
    if ([self.flagArray[index] isEqual:@0]) {
        self.flagArray[index] = @1;
    }else{
        self.flagArray[index] = @0;
    }
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

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SelectedFileCollectionViewCell *fileCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fileCellID" forIndexPath:indexPath];
    fileCell.fileNameLbl.text = self.fileArray[indexPath.row];
    if ([self.flagArray[indexPath.row] isEqualToValue: @0]) {
        fileCell.selectIV.image = [UIImage imageNamed:@"unselectedIcon"];
    }else{
        fileCell.selectIV.image = [UIImage imageNamed:@"selectedIcon"];
    }
    //添加长按手势
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressAction:)];
    [fileCell.contentView addGestureRecognizer:longPress];
    
    return fileCell;
}
- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
{
    __weak typeof(self)weakSelf = self;
    if ([longPress state] == UIGestureRecognizerStateBegan) {
        CGPoint p = [longPress locationInView:self.fileCV];
        NSLog(@"press at %f,%f",p.x,p.y);
        NSIndexPath *indexPath = [self.fileCV indexPathForItemAtPoint:p];
        NSString *str =[NSString stringWithFormat:@"%@/%@",DocumentPath,weakSelf.fileArray[indexPath.row]];
        AnimatedAlert *animateAlert = [[AnimatedAlert alloc]initWithFrame:CGRectMake(0, 0, 300, 150) leftTitle:@"查看" rightTitle:@"删除" contentText:@"您要删除这个文件吗？" cancel:^(UIView *animateAlert) {
            PreviewViewController *previewVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"previewVCID"];
            NSURL *url = [NSURL fileURLWithPath:str];
            previewVC.url = url;
            [weakSelf presentViewController:previewVC animated:YES completion:^{
                [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    animateAlert.transform =CGAffineTransformMakeScale(0.1, 0.1);
                    animateAlert.alpha = 0;
                } completion:^(BOOL finished) {
                    [animateAlert removeFromSuperview];
                }];
            }];
        } confirm:^(UIView *animateAlert) {
            //删除文件
            [[NSFileManager defaultManager]removeItemAtPath:str error:nil];
            NSArray *tempArr = [[NSArray alloc]initWithArray:[[NSFileManager defaultManager] contentsOfDirectoryAtPath:DocumentPath error:nil]];
            NSLog(@"%@",tempArr);
            //把数据源数组删除
            [weakSelf.fileArray removeObjectAtIndex:indexPath.row];
            //把对应的flag也删除
            [weakSelf.flagArray removeObjectAtIndex:indexPath.row];
            //刷新collectionview
            [weakSelf.fileCV reloadData];
            [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                animateAlert.transform =CGAffineTransformMakeScale(0.1, 0.1);
                animateAlert.alpha = 0;
            } completion:^(BOOL finished) {
                [animateAlert removeFromSuperview];
            }];
        }];
        [self.view addSubview:animateAlert];
    }
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fileArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(144, 144);
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 15;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self getOpposedObject:indexPath.row];
    [self.fileCV reloadData];
}

@end
