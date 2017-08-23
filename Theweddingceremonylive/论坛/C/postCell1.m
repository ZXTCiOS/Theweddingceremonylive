//
//  postCell1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "postCell1.h"

@interface postCell1()

@end

@implementation postCell1

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        [self.contentView addSubview:self.textView];
        HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
        photoView.frame = CGRectMake(12, 100*HEIGHT_SCALE, kScreenW - 24, 0);
        photoView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:photoView];
        self.photoView = photoView;
        [self.contentView addSubview:self.submitBtn];
        [self setuplayout];
    }
    return self;
}

-(void)setuplayout
{
    __weak typeof (self) weakSelf = self;
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).with.offset(20*WIDTH_SCALE);
        make.top.equalTo(weakSelf).with.offset(20*HEIGHT_SCALE);
        make.right.equalTo(weakSelf).with.offset(-20*WIDTH_SCALE);
        make.height.mas_offset(100*HEIGHT_SCALE);
    }];
    
    [self.submitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf).with.offset(-20*WIDTH_SCALE);
        make.top.equalTo(weakSelf.textView.mas_bottom).with.offset(20*HEIGHT_SCALE);
        make.width.mas_offset(80*WIDTH_SCALE);
        make.height.mas_offset(20*HEIGHT_SCALE);
    }];
}

#pragma mark - getters

-(WJGtextView *)textView
{
    if(!_textView)
    {
        _textView = [[WJGtextView alloc] init];
        _textView.customPlaceholder = @"说点什么吧...";
    }
    return _textView;
}

-(UIButton *)submitBtn
{
    if(!_submitBtn)
    {
        _submitBtn = [[UIButton alloc] init];
        [_submitBtn setTitle:@"提交" forState:normal];
        [_submitBtn setTitleColor:[UIColor whiteColor] forState:normal];
        _submitBtn.backgroundColor = [UIColor colorWithHexString:@"ed5e40"];
        _submitBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _submitBtn.layer.masksToBounds = YES;
        _submitBtn.layer.cornerRadius = 2;
    }
    return _submitBtn;
}

- (HXPhotoManager *)manager {
    if (!_manager) {
        _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _manager.openCamera = YES;
        _manager.cacheAlbum = YES;
        _manager.lookLivePhoto = YES;
        //        _manager.outerCamera = YES;
        _manager.open3DTouchPreview = YES;
        _manager.cameraType = HXPhotoManagerCameraTypeSystem;
        _manager.photoMaxNum = 3;
        _manager.videoMaxNum = 3;
        _manager.maxNum = 8;
        _manager.saveSystemAblum = NO;
    }
    return _manager;
}



@end
