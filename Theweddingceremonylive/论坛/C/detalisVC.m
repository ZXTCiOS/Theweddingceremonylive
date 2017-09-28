//
//  detalisVC.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/22.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "detalisVC.h"
#import "detalisCell0.h"
#import "detalisCell1.h"
#import "detalisCell2.h"
#import "detalisModel.h"
#import "keyboardView.h"
#import "IQKeyboardManager.h" 

@interface detalisVC ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
{
    BOOL _wasKeyboardManagerEnabled;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSDictionary *headdic;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) keyboardView *keyView;
@property (nonatomic,strong) UIView *bgview;
@property (nonatomic,strong) NSString *fromkeyboard;
@property (nonatomic,assign) UIEdgeInsets insets;
@end

static NSString *detalisidentfid0 = @"detalisidentfid0";
static NSString *detalisidentfid1 = @"detalisidentfid1";
static NSString *detalisidentfid2 = @"detalisidentfid2";

@implementation detalisVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    self.fromkeyboard = @"pinlun0";
    self.headdic = [NSDictionary dictionary];
    self.dataSource = [NSMutableArray array];
    [self.view addSubview:self.table];
    self.table.tableFooterView = [UIView new];
    [self loaddata];
    [self setkeyborard];
    [self bgviewadd];
    self.insets = UIEdgeInsetsMake(0, 14*WIDTH_SCALE, 0, 14*WIDTH_SCALE);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)loaddata
{
    [self.dataSource removeAllObjects];
    NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
    NSString *uid = [defat objectForKey:user_uid];
    NSString *token = [defat objectForKey:user_token];
    self.bbs_id = @"22";
    NSDictionary *para = @{@"uid":uid,@"token":token,@"bbs_id":self.bbs_id};
    [DNNetworking postWithURLString:post_getallinfo parameters:para success:^(id obj) {
        NSLog(@"obj-----%@",obj);
        NSString *msg = [obj objectForKey:@"msg"];
        if ([[obj objectForKey:@"code"] intValue]==1000) {
            NSDictionary *datadic = [obj objectForKey:@"data"];
            self.headdic = [NSDictionary dictionary];
            self.headdic = [datadic objectForKey:@"bbsinfo"];
            NSArray *huifu = [datadic objectForKey:@"huifu"];
            for (int i = 0; i<huifu.count; i++) {
                NSDictionary *dic = [huifu objectAtIndex:i];
                detalisModel *model = [[detalisModel alloc] init];
                model.bbs_content = [dic objectForKey:@"bbs_content"];
                model.bbs_content_addtime = [dic objectForKey:@"bbs_content_addtime"];
                model.bbs_content_bbs_id = [dic objectForKey:@"bbs_content_bbs_id"];
                model.bbs_content_id = [dic objectForKey:@"bbs_content_id"];
                model.bbs_content_send_uid = [dic objectForKey:@"bbs_content_send_uid"];
                model.bbs_content_to_name = [dic objectForKey:@"bbs_content_to_name"];
                model.bbs_content_to_uid = [dic objectForKey:@"bbs_content_to_uid"];
                model.bbs_content_type = [dic objectForKey:@"bbs_content_type"];
                NSDictionary *user1info = [NSDictionary dictionary];
                NSDictionary *user2info = [NSDictionary dictionary];
                user1info = [dic objectForKey:@"user1info"];
                user2info = [dic objectForKey:@"user2info"];
                model.user1infouid = [user1info objectForKey:@"uid"];
                model.user1infoname = [user1info objectForKey:@"name"];
                model.user2infouid = [user2info objectForKey:@"uid"];
                model.user2infoname = [user2info objectForKey:@"name"];
                [self.dataSource addObject:model];
            }
        }
        [MBProgressHUD showSuccess:msg];
        [self.table reloadData];
    } failure:^(NSError *error) {
        [MBProgressHUD showSuccess:@"没有网络"];
    }];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

#pragma mark -UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section==0) {
        return 1;
    }
    if (section==1) {
        return 1;
    }
    if (section==2) {
        return self.dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        detalisCell2 *cell = [tableView dequeueReusableCellWithIdentifier:detalisidentfid2];
        cell = [[detalisCell2 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalisidentfid2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentlab.text = [self.headdic objectForKey:@"bbs_title"];
        return cell;
    }
    if (indexPath.section==1) {
        detalisCell0 *cell = [tableView dequeueReusableCellWithIdentifier:detalisidentfid0];
        cell = [[detalisCell0 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalisidentfid0];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.headdic];
        return cell;
    }
    if (indexPath.section==2) {
        detalisCell1 *cell = [tableView dequeueReusableCellWithIdentifier:detalisidentfid1];
        cell = [[detalisCell1 alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:detalisidentfid1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setdata:self.dataSource[indexPath.row]];
        return cell;
    }
    return nil;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView cellHeightForIndexPath:indexPath
                        cellContentViewWidth:[UIScreen mainScreen].bounds.size.width
                                   tableView:tableView];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        [self.keyView.textview becomeFirstResponder];
        self.keyView.indexstr = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
        self.fromkeyboard = @"pinlun1";
    }
}

-(void)setkeyborard
{
    _keyView = [[keyboardView alloc] init];
    //增加监听，当键盘出现或改变时收出消息
    _keyView.textview.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    //增加监听，当键退出时收出消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    _keyView.textview.delegate = self;
    [_keyView.sendbtn addTarget:self action:@selector(sendbtnclick) forControlEvents:UIControlEventTouchUpInside];
    _keyView.backgroundColor = [UIColor whiteColor];
    _keyView.textview.backgroundColor = [UIColor whiteColor];
    _keyView.textview.customPlaceholder = @"写评论";
    _keyView.textview.layer.masksToBounds = YES;
    _keyView.textview.layer.borderWidth = 1;
    _keyView.layer.masksToBounds = YES;
    _keyView.layer.borderWidth = 0.6;
    _keyView.layer.borderColor = [UIColor colorWithHexString:@"C7C7CD"].CGColor;
    _keyView.textview.layer.borderColor = [UIColor colorWithHexString:@"C7C7CD"].CGColor;
    _keyView.textview.customPlaceholderColor = [UIColor colorWithHexString:@"C7C7CD"];
    _keyView.frame = CGRectMake(0, kScreenH-64, kScreenW, 64);
    _wasKeyboardManagerEnabled = [[IQKeyboardManager sharedManager] isEnabled];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [self.view addSubview:self.keyView];
}


//当键盘出现或改变时调用

- (void)keyboardWillShow:(NSNotification *)aNotification
{
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.keyView.transform=CGAffineTransformMakeTranslation(0, -height);
        self.bgview.alpha = 0.6;
        self.bgview.frame = CGRectMake(0, 0, kScreenW, kScreenH-44-14-height);
        self.bgview.hidden = NO;
    } completion:^(BOOL finished) {
        
    }];
}

//当键退出时调用

- (void)keyboardWillHide:(NSNotification *)aNotification
{
    [UIView animateWithDuration:[aNotification.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.keyView.transform=CGAffineTransformIdentity;
        self.bgview.hidden = YES;
        self.bgview.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        self.bgview.alpha = 1;
    } completion:^(BOOL finished) {
        self.keyView.textview.text=@"";
        _keyView.textview.customPlaceholder = @"回帖";
        self.fromkeyboard = @"pinlun0";
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length==0) {
        [self.keyView.sendbtn setTitleColor:[UIColor  colorWithHexString:@"C7C7CD"] forState:normal];
        
    }else
    {
        [self.keyView.sendbtn setTitleColor:[UIColor colorWithHexString:@"576b95"] forState:normal];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    //_keyView.textview.customPlaceholder = [NSString stringWithFormat:@"%@%@",@"评论@",self.namestr];
}

-(void)bgviewadd
{
    //添加屏幕的蒙罩
    self.bgview = [[UIView alloc]initWithFrame:self.view.frame];
    self.bgview.backgroundColor = [UIColor blackColor];
    self.bgview.alpha = 0.0;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backgroundTapped:)];
    [self.bgview addGestureRecognizer:tap];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:self.bgview];
}

-(void)backgroundTapped:(UIGestureRecognizer *)tgp
{
    [self.keyView.textview resignFirstResponder];
    NSLog(@"空白处");
    self.fromkeyboard = @"pinlun0";
}

#pragma mark - UITextViewDelegate

//将要结束/退出编辑模式

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    NSLog(@"退出编辑模式");
    return YES;
}

//发送按钮

-(void)sendbtnclick
{
    NSLog(@"sendclick");
    if ([self.fromkeyboard isEqualToString:@"pinlun0"]) {

        NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defat objectForKey:user_uid];
        NSString *token = [defat objectForKey:user_token];
        NSString *bbs_id = [self.headdic objectForKey:@"bbs_id"];
        NSString *content = @"";
        if (self.keyView.textview.text.length==0) {
            content = @"";
        }
        else
        {
            content = self.keyView.textview.text;
        }
        NSDictionary *para = @{@"uid":uid,@"token":token,@"bbs_id":bbs_id,@"content":content};
        [DNNetworking postWithURLString:post_sendmes parameters:para success:^(id obj) {
            NSString *mes = [obj objectForKey:@"mes"];
            [MBProgressHUD showSuccess:mes toView:self.view];
            [self loaddata];
             [self.keyView.textview resignFirstResponder];
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"网络错误" toView:self.view];
             [self.keyView.textview resignFirstResponder];
        }];
    }
    else
    {
        NSUserDefaults *defat = [NSUserDefaults standardUserDefaults];
        NSString *uid = [defat objectForKey:user_uid];
        NSString *token = [defat objectForKey:user_token];
        NSString *bbs_id = [self.headdic objectForKey:@"bbs_id"];
        NSString *content = @"";
        if (self.keyView.textview.text.length==0) {
            content = @"";
        }
        else
        {
            content = self.keyView.textview.text;
        }
        NSInteger inter = [self.keyView.indexstr intValue];
        detalisModel *model = [self.dataSource objectAtIndex:inter];
        NSString *sendmesto_uid = model.user1infouid;
        NSDictionary *para = @{@"uid":uid,@"token":token,@"bbs_id":bbs_id,@"content":content,@"sendmesto_uid":sendmesto_uid};
        [DNNetworking postWithURLString:post_sendmestouser parameters:para success:^(id obj) {
            NSString *mes = [obj objectForKey:@"mes"];
            [MBProgressHUD showSuccess:mes];
            [self loaddata];
            [self.keyView.textview resignFirstResponder];
        } failure:^(NSError *error) {
            [MBProgressHUD showSuccess:@"网络错误"];
             [self.keyView.textview resignFirstResponder];
        }];
    }
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

#pragma mark 用于将cell分割线补全

-(void)viewDidLayoutSubviews {
    if ([self.table respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.table setSeparatorInset:self.insets];
    }
    if ([self.table respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.table setLayoutMargins:self.insets];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath{
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            [cell setLayoutMargins:self.insets];
        }
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
            [cell setSeparatorInset:self.insets];
        }
}
@end
