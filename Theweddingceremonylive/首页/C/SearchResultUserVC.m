//
//  SearchResultUserVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/25.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "SearchResultUserVC.h"
#import "infoModel.h"
#import "infoCell.h"
#import "infoVC.h"


@interface SearchResultUserVC ()

@property (nonatomic, copy) NSString *text;

@property (nonatomic, strong) NSMutableArray<infoModel *> *datalist;

@end

@implementation SearchResultUserVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self netWorking];
    self.title = @"搜索结果";
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([infoCell class]) bundle:nil]  forCellReuseIdentifier:@"cell"];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)netWorking{
    
    MJWeakSelf
    
    [self.tableView addFooterRefresh:^{
        [weakSelf footerRefresh];
    }];
    [self footerRefresh];
}
static NSInteger page = 1;
- (void)footerRefresh{
    NSString *uid = [userDefault objectForKey:user_uid];
    NSString *token = [userDefault objectForKey:user_token];
    
    [DNNetworking postWithURLString:post_search parameters:@{@"key": self.text, @"uid": uid, @"token": token, @"type": @(1)} success:^(id obj) {
        
        NSString *code = [NSString stringWithFormat:@"%@", [obj objectForKey:@"code"]];
        if ([code isEqualToString:@"1000"]) {
            NSDictionary *data = [obj objectForKey:@"data"];
            NSArray<infoModel *> *arr = [infoModel parse:data];
            [self.datalist addObjectsFromArray:arr];
            page++;
            [self.tableView reloadData];
        } else {
            //NSString *msg = [NSString stringWithFormat:@"%@", [obj objectForKey:@"mes"]];
            [self.view showWarning:@"error"];
        }
        
        [self.tableView endHeaderRefresh];
    } failure:^(NSError *error) {
        [self.view showWarning:@"网络错误"];
        [self.tableView endHeaderRefresh];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datalist.count ? 1 : 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datalist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    infoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    infoModel *model = self.datalist[indexPath.row];
    [cell.imgV sd_setImageWithURL:model.picture.xd_URL placeholderImage:[UIImage imageNamed:@"touxiang"]];
    cell.nameL.text = model.name;
    NSString *img;
    if ([model.sex isEqualToString:@"0"]) {
        img = @"";
    }else {
        img = @"";
    }
    cell.genderImg.image = [UIImage imageNamed:img];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    infoVC *vc = [[infoVC alloc] init];
    vc.useruid = self.datalist[indexPath.row].uid;
    [self.navigationController pushViewController:vc animated:YES];
}


- (instancetype)initWithSearchtext:(NSString *)text{
    self = [super init];
    if (self) {
        self.text = text;
    }
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 66;
}

- (NSMutableArray<infoModel *> *)datalist{
    if (!_datalist) {
        _datalist = [NSMutableArray<infoModel *> array];
    }
    return _datalist;
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
