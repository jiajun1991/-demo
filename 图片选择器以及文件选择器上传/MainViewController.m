//
//  MainViewController.m
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import "MainViewController.h"
#import "SelectFileViewController.h"
#import <ZLPhotoBrowser/ZLPhotoBrowser-Swift.h>
#import "ImageCollectionViewCell.h"
#import "ImageAddCollectionViewCell.h"
@interface MainViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *fileCV;
@property (strong ,nonatomic)NSMutableArray *imageArray;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:236/255.0 green:67/255.0 blue:62/255.0 alpha:1]];
    UIButton *uploadBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
    [uploadBtn setTitle:@"上传" forState:UIControlStateNormal];
    [uploadBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    uploadBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [uploadBtn addTarget:self action:@selector(uploadAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:uploadBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    [self.fileCV registerNib:[UINib nibWithNibName:@"ImageAddCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"addImageCellID"];
    [self.fileCV registerNib:[UINib nibWithNibName:@"ImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"imageCellID"];
    self.fileCV.delegate = self;
    self.fileCV.dataSource = self;
}
- (IBAction)selectPhotoDidClick:(id)sender {
    __weak typeof(self)weakSelf = self;
    [ZLPhotoConfiguration default].allowSelectVideo = NO;
    [ZLPhotoConfiguration default].themeColorDeploy.thumbnailBgColor = UIColor.blackColor;
    ZLPhotoPreviewSheet *ps = [[ZLPhotoPreviewSheet alloc]initWithSelectedAssets:@[]];
    ps.selectImageBlock = ^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        [weakSelf.imageArray addObjectsFromArray:images];
        [weakSelf.fileCV reloadData];
    };
    [ps showPreviewWithAnimate:YES sender:self];
    
}
- (IBAction)selectFileDidClick:(id)sender {
    SelectFileViewController *selectVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:@"selectFileVCID"];
    [self.navigationController pushViewController:selectVC animated:YES];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageArray.count + 1;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self)weakSelf = self;
    
   
        if ((indexPath.row == self.imageArray.count && self.imageArray.count != 0) || self.imageArray.count == 0) {
            ImageAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addImageCellID" forIndexPath:indexPath];
//            添加的cell
           
            return cell;
        }
            ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"imageCellID" forIndexPath:indexPath];
            //一般的图片展示cell
    cell.iv.image = self.imageArray[indexPath.row];
    [cell close:^{
        //删除数组中的元素
        [weakSelf.imageArray removeObjectAtIndex:indexPath.row];
        //reload
        [weakSelf.fileCV reloadData];
    }];
            return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.imageArray.count) {
        __weak typeof(self)weakSelf = self;
        ZLPhotoPreviewSheet *ps = [[ZLPhotoPreviewSheet alloc]initWithSelectedAssets:@[]];
        ps.selectImageBlock = ^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
            [weakSelf.imageArray addObjectsFromArray:images];
            [weakSelf.fileCV reloadData];
        };
        [ps showPreviewWithAnimate:YES sender:self];
    }
}
- (NSMutableArray *)imageArray
{
    if(!_imageArray){
        self.imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _imageArray;
}
//上传图片
- (void)uploadAction
{
    NSLog(@"上传!");
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
