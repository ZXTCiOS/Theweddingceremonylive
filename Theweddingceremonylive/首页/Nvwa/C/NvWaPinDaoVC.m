//
//  NvWaPinDaoVC.m
//  Theweddingceremonylive
//
//  Created by apple on 17/8/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "NvWaPinDaoVC.h"
#import "NvWaCell.h"


@interface NvWaPinDaoVC ()

@end

@implementation NvWaPinDaoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"女娲频道";
    // 注册 cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([NvWaCell class]) bundle:nil] forCellReuseIdentifier:@"cell"];
    
}

- (void)netWorking{
    
    
    [self.tableView addHeaderRefresh:^{
        [self headerRefresh];
    }];
}

- (void)headerRefresh{
    
}

- (void)footerRefresh{
    
}

- (BOOL)isSuShu:(uint) a{
    int i = 2;
    do {
        if (a % i == 0) {
            return NO;
        }
        i++;
    } while (i * (i + 1) < a);
    return YES;
}



#pragma mark tableveiw   delegate && datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section ? 6 : 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:{
            
        }
            break;
        case 1:{
            NvWaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
            
            cell.time.text = @"123456789";
            //cell.img sd_setImageWithURL:<#(nullable NSURL *)#> placeholderImage:<#(nullable UIImage *)#>
            cell.desc.text = @"description";
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSLog(@"section%ld, row%ld", indexPath.section, indexPath.row);
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
