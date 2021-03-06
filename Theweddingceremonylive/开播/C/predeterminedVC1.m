//
//  predeterminedVC1.m
//  Theweddingceremonylive
//
//  Created by 王俊钢 on 2017/8/24.
//  Copyright © 2017年 wangjungang. All rights reserved.
//

#import "predeterminedVC1.h"
#import "predetermindCell.h"
#import "predeterheadView0.h"
#import "YUDatePicker.h"
#import "weddingproductsVC.h"

@interface predeterminedVC1 ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) predeterheadView0 *headView;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) UIButton *setBtn;

@property (nonatomic,strong) NSString *pricestr;

@property (nonatomic,strong) NSString *numstr;
@property (nonatomic,strong) NSString *timestr;

@property (nonatomic,assign) BOOL istuijian;
@end

static NSString *predeterminedidentfid01 = @"predeterminedidentfid01";

@implementation predeterminedVC1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"下一步" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor colorWithHexString:@"E95F46"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"E95F46"]}];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.title = @"预定房间";
    

    self.numstr = @"5000";
    self.pricestr = @"2999";
    
    self.istuijian = NO;
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.headView;
    self.table.tableFooterView = self.footView;
    [self nowtime];
}

#pragma mark - getters

-(UITableView *)table
{
    if(!_table)
    {
        _table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _table;
}

-(predeterheadView0 *)headView
{
    if(!_headView)
    {
        _headView = [[predeterheadView0 alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 300*HEIGHT_SCALE)];
        _headView.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
        [_headView.btn0 addTarget:self action:@selector(numselbtnclick0) forControlEvents:UIControlEventTouchUpInside];
        [_headView.btn1 addTarget:self action:@selector(numselbtnclick1) forControlEvents:UIControlEventTouchUpInside];
        _headView.btn0.numlab.text = @"5000人";
        _headView.btn1.numlab.text = @"10000人";
        [_headView.btn2 setHidden:YES];
        [_headView.btn3 setHidden:YES];
        _headView.userInteractionEnabled = YES;
        _headView.bgimg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectHeaderImage)];
        [_headView.bgimg addGestureRecognizer:tap];
        [_headView.selectbtn addTarget:self action:@selector(tuijianchoost) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _headView;
}


-(UIView *)footView
{
    if(!_footView)
    {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, 80*HEIGHT_SCALE)];
        _footView.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
        [_footView addSubview:self.setBtn];
    }
    return _footView;
}

-(UIButton *)setBtn
{
    if(!_setBtn)
    {
        _setBtn = [[UIButton alloc] init];
        [_setBtn addTarget:self action:@selector(setBtnclick) forControlEvents:UIControlEventTouchUpInside];
        
        _setBtn.backgroundColor = [UIColor whiteColor];
        // [_setBtn setTitleColor:[UIColor colorWithHexString:@"333333"] forState:normal];
        _setBtn.frame = CGRectMake(10*WIDTH_SCALE, 5, kScreenW-20*WIDTH_SCALE, 50*HEIGHT_SCALE);
        
        NSString *netstr = [NSString stringWithFormat:@"%@%@",@"价格:",_pricestr];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:netstr];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,3)];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ed5e40"] range:NSMakeRange(3,_pricestr.length)];
        [_setBtn setAttributedTitle:str forState:UIControlStateNormal];
        
    }
    return _setBtn;
}

#pragma mark - UITableViewDataSource&&UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    predetermindCell *cell = [tableView dequeueReusableCellWithIdentifier:predeterminedidentfid01];
    cell = [[predetermindCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:predeterminedidentfid01];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.predetext.placeholder = @"输入推荐码";
    cell.predetext.tag = 301;
    cell.backgroundColor = [UIColor colorWithHexString:@"e8e8e8"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60*HEIGHT_SCALE;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)datePickerValueChanged:(UIDatePicker *)datePicker {
    NSLog(@"UIDatePicker:%@", datePicker.date);
}

#pragma mark - 实现方法

-(void)numselbtnclick0
{
    self.headView.btn0.selimg.image = [UIImage imageNamed:@"zb_oroom_po_s"];
    self.headView.btn0.numlab.textColor = [UIColor colorWithHexString:@"ed5e40"];
    self.headView.btn1.selimg.image = [UIImage imageNamed:@"zb_oroom_pt"];
    self.headView.btn1.numlab.textColor = [UIColor colorWithHexString:@"333333"];
    self.headView.btn2.selimg.image = [UIImage imageNamed:@"zb_oroom_pth"];
    self.headView.btn2.numlab.textColor = [UIColor colorWithHexString:@"333333"];
    self.headView.btn3.selimg.image = [UIImage imageNamed:@"zb_oroom_pf"];
    self.headView.btn3.numlab.textColor = [UIColor colorWithHexString:@"333333"];
    self.pricestr = @"2999";
    NSString *netstr = [NSString stringWithFormat:@"%@%@",@"价格:",_pricestr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:netstr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ed5e40"] range:NSMakeRange(3,_pricestr.length)];
    [_setBtn setAttributedTitle:str forState:UIControlStateNormal];
}

-(void)numselbtnclick1
{
    self.headView.btn0.selimg.image = [UIImage imageNamed:@"zb_oroom_po"];
    self.headView.btn0.numlab.textColor = [UIColor colorWithHexString:@"333333"];
    self.headView.btn1.selimg.image = [UIImage imageNamed:@"zb_oroom_pt_s"];
    self.headView.btn1.numlab.textColor = [UIColor colorWithHexString:@"ed5e40"];
    self.headView.btn2.selimg.image = [UIImage imageNamed:@"zb_oroom_pth"];
    self.headView.btn2.numlab.textColor = [UIColor colorWithHexString:@"333333"];
    self.headView.btn3.selimg.image = [UIImage imageNamed:@"zb_oroom_pf"];
    self.headView.btn3.numlab.textColor = [UIColor colorWithHexString:@"333333"];
    self.pricestr = @"3999";
    NSString *netstr = [NSString stringWithFormat:@"%@%@",@"价格:",_pricestr];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:netstr];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"333333"] range:NSMakeRange(0,3)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ed5e40"] range:NSMakeRange(3,_pricestr.length)];
    [_setBtn setAttributedTitle:str forState:UIControlStateNormal];
}



-(void)selectHeaderImage
{
    // 需要更多自定义设置
    YUDatePicker *datePicker = [[YUDatePicker alloc] init];
    
    [datePicker.leftBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [datePicker.rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    // 比如:
    // 先设置 datePickerModel 再设置 dateFormatStr
    datePicker.dateFormatStr = @"yyyy/MM/dd"; // 修改显示时间格式
    
    [datePicker setMinimumDate:[NSDate date]]; // 设置最小日期
    //        [datePicker setMaximumDate:[NSDate date]];
    
    [datePicker yu_datePickerHandleClick:^(NSString *dateStr, NSInteger buttonIndex) {
        NSLog(@"date=%@,buttonIndex=%ld", dateStr, (long)buttonIndex);
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的日期格式
        [formatter setTimeStyle:NSDateFormatterFullStyle];// 修改下面提到的北京时间的时间格式
        [formatter setDateFormat:@"YYYY-MM-dd"];// 此行代码与上面两行作用一样，故上面两行代码失效
        NSDate *date = [formatter dateFromString:dateStr];
        NSLog(@"%@", date);// 这个时间是格林尼治时间
        NSString *dateStrddd = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
        NSLog(@"%@", dateStrddd);// 这个时间是北京时间戳
        self.timestr = dateStrddd;

        
        NSString *yearstr = [dateStr substringWithRange:NSMakeRange(2, 2)];
        NSString *monthstr = [dateStr substringWithRange:NSMakeRange(5, 2)];
        NSString *daystr =[dateStr substringWithRange:NSMakeRange(8, 2)];
        self.headView.numlab0.text = yearstr;
        self.headView.numlab1.text = monthstr;
        self.headView.numlab2.text = daystr;
        //self.timestr = [NSString stringWithFormat:@"%@%@%@%@%@%@",yearstr,@"年",monthstr,@"月",daystr,@"日"];

    }];
    [datePicker show];
}

-(void)rightAction
{
    weddingproductsVC *vc = [[weddingproductsVC alloc] init];
    vc.order_pattern = @"3";
    UITextField *text1 = [self.table viewWithTag:301];
    vc.tuijian = text1.text;
    vc.pricestr = self.pricestr;
    vc.create_time = self.timestr;
    vc.room_count = self.numstr;
    vc.typenamestr = @"公众人物直播";
    [self.navigationController pushViewController:vc animated:YES];
}

//推荐码选择

-(void)tuijianchoost
{
    self.istuijian = !self.istuijian;
    if (self.istuijian) {
        [self.headView.selectbtn setImage:[UIImage imageNamed:@"zb_oroom_sel_s"] forState:normal];
    }
    else
    {
        [self.headView.selectbtn setImage:[UIImage imageNamed:@"zb_oroom_sel"] forState:normal];
    }
}

-(void)setBtnclick
{
    NSLog(@"setbtnclick");
}

- (void)nowtime
{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY/MM/dd"];
    NSString *DateTime = [formatter stringFromDate:date];
    NSString *yearstr = [DateTime substringWithRange:NSMakeRange(2, 2)];
    NSString *monthstr = [DateTime substringWithRange:NSMakeRange(5, 2)];
    NSString *daystr =[DateTime substringWithRange:NSMakeRange(8, 2)];
    self.headView.numlab0.text = yearstr;
    self.headView.numlab1.text = monthstr;
    self.headView.numlab2.text = daystr;
    [formatter setDateFormat:@"YYYY-MM-dd"];// 此行代码与上面两行作用一样，故上面两行代码失效
    NSDate *date2 = [formatter dateFromString:DateTime];
    NSLog(@"%@", date2);// 这个时间是格林尼治时间
    NSString *dateStrddd = [NSString stringWithFormat:@"%ld", (long)[date2 timeIntervalSince1970]];
    NSLog(@"%@", dateStrddd);// 这个时间是北京时间戳
    self.timestr = dateStrddd;
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
