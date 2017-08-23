//
//  DemoTableViewCell.m
//  Demo
//
//  Created by venusource on 16/8/31.
//  Copyright © 2016年 venusource.com. All rights reserved.
//

#import "DemoTableViewCell.h"
#import "DemoCellModel.h"
#import "DemoCommentView.h"
#import <SDAutoLayout.h>


@interface DemoTableViewCell ()
//头像
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLable;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic,strong)  UIButton *moreButton;
@property (nonatomic,strong) DemoCommentView *commentView;



@end

@implementation DemoTableViewCell

-(UIImageView *)iconView{
    if (!_iconView){
        _iconView = [[UIImageView alloc]init];
        _iconView.layer.masksToBounds = YES;
        _iconView.layer.cornerRadius = 20;
        _iconView.layer.borderColor = [[UIColor blackColor] CGColor];
        _iconView.layer.borderWidth = 1;
    }
    return _iconView;
}

-(UILabel *)nameLable{
    if (!_nameLable){
        _nameLable = [[UILabel alloc]init];
        _nameLable.font = [UIFont systemFontOfSize:14];
    }
    return _nameLable;
}

-(UILabel *)contentLabel{
    if (!_contentLabel){
        _contentLabel = [[UILabel alloc]init];
        _contentLabel.font = [UIFont systemFontOfSize:12];
        _contentLabel.textColor = [UIColor colorWithHexString:@"333333"];
    }
    return _contentLabel;
}

-(UILabel *)timeLabel{
    if (!_timeLabel){
        _timeLabel = [[UILabel alloc]init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        _timeLabel.textColor = [UIColor grayColor];
        _timeLabel.text = @"就在不久前";
    }
    return _timeLabel;
}

-(UIButton *)moreButton{
    if (!_moreButton){
        _moreButton = [[UIButton alloc]init];
        [_moreButton setTitle:@"加载更多" forState:UIControlStateNormal];
        [_moreButton setTitle:@"收起" forState:UIControlStateSelected];
        [_moreButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_moreButton addTarget:self action:@selector(didClickMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

-(DemoCommentView *)commentView{
    if (!_commentView){
        _commentView = [[DemoCommentView alloc]init];
    }
    return _commentView;
}


-(void)prepareForReuse{
    [super prepareForReuse];
    NSLog(@"over");
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI{
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.nameLable];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.timeLabel];

    _iconView.sd_layout
    .leftSpaceToView(self.contentView,14)
    .topSpaceToView(self.contentView,14)
    .heightIs(40)
    .widthEqualToHeight();
    
    _nameLable.sd_layout
    .topEqualToView(_iconView)
    .leftSpaceToView(_iconView,14)
    .heightIs(25);
    [_nameLable setSingleLineAutoResizeWithMaxWidth:200];
    

    _contentLabel.sd_layout
    .leftSpaceToView(self.contentView,14)
    .rightSpaceToView(self.contentView,14)
    .topSpaceToView(_iconView,20)
    .autoHeightRatio(0);
    
  
}

- (void)setModel:(DemoCellModel *)model{
    _model = model;
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:model.iconName] placeholderImage:nil];
    self.nameLable.text = model.name;
    self.contentLabel.text = model.msgContent;
    UIView *bottomView  = [UIView new];

    if (model.commentArray.count){
        [self.contentView addSubview:self.commentView];

        _commentView.sd_layout
        .leftEqualToView(_contentLabel)
        .rightSpaceToView(self.contentView,10)
        .topSpaceToView(_contentLabel,10);

        self.commentView.commentArray = model.commentArray;
        
        if (model.commentArray.count > 5){
            [self.contentView addSubview:self.moreButton];
            self.moreButton.selected = model.isMore;

            self.moreButton.sd_layout
            .topSpaceToView(self.commentView,10)
            .rightSpaceToView(self.contentView,10)
            .leftEqualToView(self.contentLabel)
            .heightIs(20);
            
            _timeLabel.sd_layout
            .topSpaceToView(self.moreButton,10)
            .leftEqualToView(_contentLabel)
            .heightIs(10)
            .rightSpaceToView(self.contentView, 10);
            
            
            
            if (!model.isMore){
                NSMutableArray * tempArray = [NSMutableArray new];
                for (int i = 0;i < 5; ++i){
                    [tempArray addObject:model.commentArray[i]];
                }
                self.commentView.commentArray = tempArray;
            }
            
        }
        else
        {
            _timeLabel.sd_layout
            .topSpaceToView(self.commentView,10)
            .leftEqualToView(_contentLabel)
            .heightIs(10)
            .rightSpaceToView(self.contentView, 10);
            
        }
   
    } else {
        
        [self.commentView removeFromSuperview];
        
        _timeLabel.sd_layout
        .topSpaceToView(self.contentLabel,10)
        .leftEqualToView(_contentLabel)
        .heightIs(10)
        .rightSpaceToView(self.contentView, 10);
        
    }
    
    bottomView = self.timeLabel;
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:10];
    
    
}

-(void)didClickMoreButton:(UIButton *)sender{
    
    __weak typeof(self) weakSelf = self;
    if ([weakSelf.delegate respondsToSelector:@selector(didClickCellMoreComment:With:)]){
        [weakSelf.delegate didClickCellMoreComment:sender With:weakSelf];
    }
}

@end
