//
//  postingVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "postingVC.h"
#import "postCell0.h"
#import "postCell1.h"


@interface postingVC ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate,HXPhotoViewDelegate>
{
    __block NSString *str0;
    __block NSString *str1;
    __block NSString *str2;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) UIImageView *demoimg;

@property (nonatomic,copy) NSString *imgstr0;
@property (nonatomic,copy) NSString *imgstr1;
@property (nonatomic,copy) NSString *imgstr2;
@end


static NSString *postidentfid0 = @"postidentfid0";
static NSString *postidentfid1 = @"postidentfid1";

@implementation postingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"发帖";

    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    
    [self.view addSubview:self.demoimg];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor colorWithHexString:@"f1f1f1"];
    }
    return _table;
}


-(UIImageView *)demoimg
{
    if(!_demoimg)
    {
        _demoimg = [[UIImageView alloc] init];
        _demoimg.frame = CGRectMake(40, 340, 100, 100);
//        _demoimg.backgroundColor = [UIColor orangeColor];
    }
    return _demoimg;
}



#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        postCell0 *cell = [tableView dequeueReusableCellWithIdentifier:postidentfid0];
        if (!cell) {
            cell = [[postCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postidentfid0];
        }
        cell.titletext.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    if (indexPath.row==1) {
        postCell1 *cell = [tableView dequeueReusableCellWithIdentifier:postidentfid1];
        if (!cell) {
            cell = [[postCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:postidentfid1];

            cell.photoView.delegate = self;
            cell.textView.tag = 203;
           
        }
        cell.textView.delegate = self;
        [cell.submitBtn addTarget:self action:@selector(sendbtnclick) forControlEvents:UIControlEventTouchUpInside];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 40*HEIGHT_SCALE;
    }
    if (indexPath.row==1) {
        return 200*HEIGHT_SCALE;
    }
    return 0.01f;
}

-(void)sendbtnclick
{
    NSLog(@"str-----%@%@%@",self.imgstr0,self.imgstr1,self.imgstr2);
}

#pragma mark - 实现方法

- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
   // NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    
  
   [HXPhotoTools getSelectedListResultModel:allList complete:^(NSArray<HXPhotoResultModel *> *alls, NSArray<HXPhotoResultModel *> *photos, NSArray<HXPhotoResultModel *> *videos) {
        NSSLog(@"\n全部类型:%@\n照片:%@\n视频:%@",alls,photos,videos);
       if (photos.count==1) {
           HXPhotoResultModel *model0 = [photos objectAtIndex:0];
           UIImage *img0 = model0.displaySizeImage;
           NSData *imageData0 = UIImageJPEGRepresentation(img0, 1.0);
           NSString *picture0 = [imageData0 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr0 = picture0;
       }
       if (photos.count==2) {
           HXPhotoResultModel *model0 = [photos objectAtIndex:0];
           UIImage *img0 = model0.displaySizeImage;
           NSData *imageData0 = UIImageJPEGRepresentation(img0, 1.0);
           NSString *picture0 = [imageData0 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr0 = picture0;
           
           
           HXPhotoResultModel *model1 = [photos objectAtIndex:1];
           UIImage *img1 = model1.displaySizeImage;
           NSData *imageData1 = UIImageJPEGRepresentation(img1, 1.0);
           NSString *picture1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr1 = picture1;
       }
       if (photos.count==3) {
           
           
           HXPhotoResultModel *model0 = [photos objectAtIndex:0];
           UIImage *img0 = model0.displaySizeImage;
           NSData *imageData0 = UIImageJPEGRepresentation(img0, 1.0);
           NSString *picture0 = [imageData0 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr0 = picture0;
           
           
           HXPhotoResultModel *model1 = [photos objectAtIndex:1];
           UIImage *img1 = model1.displaySizeImage;
           NSData *imageData1 = UIImageJPEGRepresentation(img1, 1.0);
           NSString *picture1 = [imageData1 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr1 = picture1;
           
           HXPhotoResultModel *model2 = [photos objectAtIndex:2];
           UIImage *img2 = model2.displaySizeImage;
           NSData *imageData2 = UIImageJPEGRepresentation(img2, 1.0);
           NSString *picture2 = [imageData2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
           self.imgstr2 = picture2;
           
       }
      
       if (photos.count==0) {
           self.imgstr0 = @"";
           self.imgstr1 = @"";
           self.imgstr2 = @"";
       }
    }];
    
}

#pragma mark - delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

@end
