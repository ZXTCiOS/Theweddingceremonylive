//
//  MineTVC.m
//  zhongxunLive
//
//  Created by mahaibo on 17/6/23.
//  Copyright © 2017年 ZhongXun. All rights reserved.
//

#import "MineTVC.h"
#import "ModifyInfoVC.h"
#import "SystemMessageTVC.h"
#import "MyGiftTVC.h"
#import "MyWalletTVC.h"


@interface MineTVC ()

@property (weak, nonatomic) IBOutlet UIImageView *icon;

@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UILabel *gender_id;

@property (weak, nonatomic) IBOutlet UIImageView *bgimageView;


@end

@implementation MineTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self contentInit];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
    self.tableView.tableFooterView = [UIView new];
    self.icon.image = [UIImage imageNamed:@"touxiang"];
    self.bgimageView.image = [UIImage imageNamed:@"touxiang"];
    
}

- (void)contentInit{
    self.icon.layer.cornerRadius = self.icon.frame.size.width / 2.0;
    self.icon.layer.masksToBounds = YES;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"name"]) {
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
        self.name.text = name;
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"icon"]) {
        UIImage *img = [[NSUserDefaults standardUserDefaults] objectForKey:@"icon"];
        self.icon.image = img;
        self.bgimageView.image = img;
    } else {
        self.icon.image = [UIImage imageNamed:@"icon_default"];
        self.bgimageView.image = nil;
    }
    
    
    
    NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:@"uid"];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"gender"]) {
     NSInteger gender = [[[NSUserDefaults standardUserDefaults] objectForKey:@"gender"] integerValue];
     if (gender == 1) {
         NSString *str = [NSString stringWithFormat:@"ID:%@   男", uid];
         self.gender_id.text = str;
     } else if (gender == 2){
         NSString *str = [NSString stringWithFormat:@"ID:%@   女", uid];
         self.gender_id.text = str;
     }
     } else {
         NSString *str = [NSString stringWithFormat:@"ID:%@   未知", uid];
         self.gender_id.text = str;
     }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return section ? 2 : 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

#pragma mark - tableview  delegate

- (IBAction)systemMessage:(id)sender {
    SystemMessageTVC *vc = [[SystemMessageTVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)modifyInfo:(id)sender {
    ModifyInfoVC *vc = [[ModifyInfoVC alloc] initWithNibName:@"ModifyInfoVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)safeCenter:(id)sender {
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (!indexPath.section) {
        switch (indexPath.row) {
            case 0:// 钱包
            {
                MyWalletTVC *wallet = [[MyWalletTVC alloc] init];
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
            case 1:// 礼物
            {
                MyGiftTVC *vc = [[MyGiftTVC alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:// 喜帖
            {
                
            }
                break;
            case 3:// 商家
            {
                
            }
                break;
            default:
                break;
        }
    } else {
        if (indexPath.row) {
            // 客服帮助
            
        } else {
            // 关于我们
            
        }
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
