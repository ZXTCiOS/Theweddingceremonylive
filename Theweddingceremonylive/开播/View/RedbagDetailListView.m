//
//  RedbagDetailListView.m
//  Theweddingceremonylive
//
//  Created by apple on 17/9/21.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "RedbagDetailListView.h"
#import "DetailCell.h"

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
        [_tableView registerClass:[DetailCell class] forCellReuseIdentifier:@"cell"];
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
    DetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:11];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    cell.textLabel.textColor = krgb(51, 51, 51, 1);
    cell.detailTextLabel.textColor = krgb(51, 51, 51, 1);
    
    RedBagModel *model = self.datalist[indexPath.row];
    [cell.imgV sd_setImageWithURL:model.picture.xd_URL placeholderImage:[UIImage imageNamed:@"touxiang"]];
    cell.name.text = model.name;
    cell.money.text = model.get_money;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 36;
}

- (void)netWorking{
    
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    
    NSDictionary *para = @{@"uid": uid, @"token": token, @"bag_id": self.redbagID};
    
    [DNNetworking postWithURLString:post_redbagRecord parameters:para success:^(id obj) {
        
        NSString *code = [obj objectForKey:@"code"];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NSDictionary *jilu = [data objectForKey:@"jilu"];
            self.datalist = [RedBagModel parse:jilu];
            [self.tableView reloadData];
            NSDictionary *fahongbao = [obj objectForKey:@"fahongbao"];
            
            [self.imaV sd_setImageWithURL:[fahongbao objectForKey:@"kname"] placeholderImage:[UIImage imageNamed:@"touxiang"]];
            self.from.text = [NSString stringWithFormat:@"%@的红包", [fahongbao objectForKey:@"picture"]];
            self.total.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"allmoney"]];
            self.last.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"yuer"]];
        }
        
        
    } failure:^(NSError *error) {
        [self showWarning:@"网络错误"];
    }];
}










@end
