//
//  RedbagDetailListView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "RedbagDetailListView.h"


@interface RedbagDetailListView ()



@property (nonatomic, strong) UIView *bgredV;

@property (weak, nonatomic) IBOutlet UIView *bgwhiteV;




@end

@implementation RedbagDetailListView




- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self tableView];
    
}


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc ] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        [self.bgwhiteV addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.equalTo(0);
            make.top.equalTo(self.last.mas_bottom).equalTo(10);
        }];
    }
    return _tableView;
}

#pragma mark delegate && datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.font = [UIFont systemFontOfSize:11];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
        cell.textLabel.textColor = krgb(51, 51, 51, 1);
        cell.detailTextLabel.textColor = krgb(51, 51, 51, 1);
    }
    //cell.imageView sd_setImageWithURL:<#(nullable NSURL *)#> placeholderImage:
    cell.imageView.image = [UIImage imageNamed:@"touxiang"];
    cell.textLabel.text = @"元稹";
    cell.detailTextLabel.text = @"100元";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}

- (void)netWorking{
    
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    
    NSDictionary *para = @{@"uid": uid, @"token": token, @"redbag_id": @(self.redbagID)};
    
    [DNNetworking postWithURLString:post_redbagRecord parameters:para success:^(id obj) {
        
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            self.datalist = [RedBagModel parse:data];
            [self.tableView reloadData];
            // tofix:
            [self.imaV sd_setImageWithURL:[obj objectForKey:@".............."] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            self.from.text = [NSString stringWithFormat:@"%@的红包", [obj objectForKey:@""]];
            self.total.text = [NSString stringWithFormat:@"%@", [obj objectForKey:@""]];
            self.last.text = [NSString stringWithFormat:@"%@", [obj objectForKey:@""]];
        }
        
        
    } failure:^(NSError *error) {
        [self showWarning:@"网络错误"];
    }];
}










@end
