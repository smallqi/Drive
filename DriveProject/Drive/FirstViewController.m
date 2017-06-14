//
//  FirstViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/4.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "FirstViewController.h"
#import "FirstTableViewCell.h"
#import "TestSelectViewController.h"
#import "Screen.h"
#import "MyDataManager.h"
#import "AnswerViewController.h"
#import "MainTestViewController.h"
#import "QuestionCollectManager.h"

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
    NSArray* _dataArray;
}

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"科目一";
    self.edgesForExtendedLayout = UIRectEdgeNone;   //界面top从20+44处开始
    
    [self creatTableView];
    [self creatView];
    //第一节的单元label信息
    _dataArray = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真考试"];
}

//创建表视图
-(void)creatTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    NSLog(@"tabelView: %f, %f", _tableView.frame.origin.y, _tableView.frame.size.height);
}
//创建视图下半部分
-(void)creatView {
    NSLog(@"screen:%f", screen.height);
    CGFloat resHeight = screen.height - 250 - 64;
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(0, 250 + resHeight/2 - 25 , screen.width, 50)];
    //label.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"-------------我的考试分析-----------------";
    label.alpha = 0.7;
    [self.view addSubview:label];
    NSLog(@"label: %f, %f", label.frame.origin.y, label.frame.size.height);

    NSArray* arr = @[@"我的错题", @"我的收藏", @"我的成绩", @"练习统计"];
    CGFloat currentHeight = 250 + resHeight/2 + 25;
    for(int i=0; i<4; i++) {
        //添加button
        UIButton* btn = [[UIButton alloc]initWithFrame:CGRectMake(screen.width/4*i + screen.width/4/2 - 30, currentHeight + 10, 60, 60)];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", 12+i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(toolbarClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //添加label
        CGFloat btnHeight = currentHeight + 10 + 60;
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(screen.width/4*i + screen.width/4/2 - 30, btnHeight + 5, 60, 30)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = arr[i];
        label.font = [UIFont boldSystemFontOfSize:13];
        label.alpha = 0.7;
        [self.view addSubview:label];
    }
}
//下标栏点击事件
-(void)toolbarClick:(UIButton*)btn {
    switch (btn.tag) {
        case 0://我的错题
        {
            AnswerViewController* con = [[AnswerViewController alloc]initWithNumber:0 WithType:7];
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];

        }
            break;
        case 1://我的收藏
        {
            AnswerViewController* con = [[AnswerViewController alloc]initWithNumber:0 WithType:8];
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];

        }
            break;
        case 2://我的成绩
        {
            NSString* scoreStr = [NSString stringWithFormat:@"%d分", [QuestionCollectManager getScore]];
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"你上一次的分数为" message:scoreStr delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
            break;
        case 3:
        {
            
        }
            break;
        default:
            break;
    }
}
#pragma mark - tableView delegate
//多少节
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//节有多少单元
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
//单元高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
//单元格式
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* cellID = @"FirstTableViewCell";
    FirstTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    
    cell.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png", indexPath.row+7]];
    cell.myLabel.text = _dataArray[indexPath.row];
    return cell;
    
}
//单元点击方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch(indexPath.row) {
        case 0://章节练习
        {
            TestSelectViewController* con = [[TestSelectViewController alloc]init];
            con.myTitle = @"章节练习";
            con.type = 1;
            con.dataArray = [MyDataManager getData:chapter];
            //自定义返回键
            UIBarButtonItem* item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 1://顺序练习
        {
            AnswerViewController* con = [[AnswerViewController alloc]initWithNumber:0 WithType:2];
            //con.type = 2;
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 2://随机练习
        {
            AnswerViewController* con = [[AnswerViewController alloc]initWithNumber:0 WithType:3];
            //con.type = 3;
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 3://专项练习
        {
            TestSelectViewController* con = [[TestSelectViewController alloc]init];
            con.myTitle = @"专项练习";
            con.type = 2;
            con.dataArray = [MyDataManager getData:subChapter];
            //自定义返回键
            UIBarButtonItem* item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
        case 4://模拟考试
        {
            MainTestViewController* con = [[MainTestViewController alloc]init];
            con.title = @"模拟考试";
            //DebugViewController* con = [[DebugViewController alloc]init];
            //自定义返回键
            UIBarButtonItem* item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            //跳转到视图
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
    }
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
