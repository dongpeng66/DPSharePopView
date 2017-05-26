//
//  ViewController.m
//  DPSharePopView
//
//  Created by dp on 17/5/26.
//  Copyright © 2017年 dp. All rights reserved.
//
static const float RealSrceenHight =  667.0;
static const float RealSrceenWidth =  375.0;
#define DPRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define DPSCREEN_HEIGHT [[UIScreen mainScreen]bounds].size.height
#define DPSCREEN_WIDTH [[UIScreen mainScreen]bounds].size.width
#define DPSCREEN_BOUNDS         [UIScreen mainScreen].bounds
#define DPAdaptationH(x) x/RealSrceenHight*[[UIScreen mainScreen]bounds].size.height
#define DPAdaptationW(x) x/RealSrceenWidth*[[UIScreen mainScreen]bounds].size.width
//适配iOS10字体变大的缘故
#define IOS_VERSION_10_OR_LATER (([[[UIDevice currentDevice]systemVersion]floatValue]>=10.0)? (YES):(NO))

#define DPAdapationLabelFont(n) (IOS_VERSION_10_OR_LATER?((n-1)*([[UIScreen mainScreen]bounds].size.width/375.0f)):(n*([[UIScreen mainScreen]bounds].size.width/375.0f)))
#import "ViewController.h"
#import "DPSharePopView.h"
#import "TableViewCell.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.tableView];
}
-(UITableView *)tableView{
    if (_tableView==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, DPSCREEN_WIDTH, DPSCREEN_HEIGHT-64) style:UITableViewStylePlain];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
    }
    return _tableView;
}
//datasource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *Identifier = @"tableViewCell";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             Identifier];
    if (cell == nil) {
        cell = [[TableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:Identifier];
        // 点击cell的时候不要变色
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    cell.downButton.tag=indexPath.row;
    [cell.downButton addTarget:self action:@selector(btnDidClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 230;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)btnDidClick:(UIButton *)sender{
    
    UIButton *btn=sender;
    DPSharePopView *view=[DPSharePopView initWithSuperView:btn menuCellNameArray:@[@"QQ好友",@"QQ空间",@"微信好友",@"微信朋友圈"] imageNameArray:@[@"share_qq_friend",@"share_qq_kongjian",@"share_wx_friend",@"share_wx_pengyouquan"] cellDidClickBlock:^(NSInteger index) {
        
    }];
    [view show];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
