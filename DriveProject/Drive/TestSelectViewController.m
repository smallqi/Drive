//
//  TestSelectViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/4.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectModel.h"
#import "AnswerViewController.h"
#import "SubTestSelectModel.h"

@interface TestSelectViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView* _tableView;
}
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    
    self.title = _myTitle;
    [self creatTableView];
}

//创建表视图
-(void)creatTableView {
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取基本单元格形式
    static NSString* cellID = @"TestSelectTableViewCell";
    TestSelectTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //圆弧角
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 8;
    }
    //设置单元格信息
    if(_type == 1) {//章节练习目录
        TestSelectModel* model = _dataArray[indexPath.row];
        cell.numberLabel.text = model.pid;
        cell.titleLabel.text = model.pname;
    }else { //专项练习目录
        SubTestSelectModel* model = _dataArray[indexPath.row];
        cell.numberLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row+1];
        cell.titleLabel.text = model.sname;
    }
    
    return cell;
}
//单元点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_type) {
        case 1://章节练习
        {
            AnswerViewController* avc = [[AnswerViewController alloc]initWithNumber:(int)indexPath.row WithType:1];
            [self.navigationController pushViewController:avc animated:YES];
        }
            break;
        case 2://专项练习
        {
            
            AnswerViewController* avc = [[AnswerViewController alloc]initWithNumber:(int)indexPath.row WithType:4];
            SubTestSelectModel* model = _dataArray[indexPath.row];
            avc.subChepterSid = model.sid;
            [self.navigationController pushViewController:avc animated:YES];

        }
            break;
        default:
            break;
    }
    
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
