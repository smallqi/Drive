//
//  AnswerScrollVIew.m
//  Drive
//
//  Created by BlackApple on 2017/6/5.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "AnswerScrollVIew.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tools.h"
#import "QuestionCollectManager.h"

#define SIZE self.frame.size
#define NUM_OF_ALL_QUES 725

@interface AnswerScrollVIew()<UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    
}

@end
@implementation AnswerScrollVIew
{
    UITableView* _leftTableView;
    UITableView* _rightTableView;
    UITableView* _mainTableView;
    NSArray* _dataArray;
    NSMutableArray* _hadAnswer;
}

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray* )array {
    self = [super initWithFrame:frame];
    if(self) {
        _currentPage = 0;
        _dataArray = [[NSArray alloc]initWithArray:array];
        _hadAnswer = [[NSMutableArray alloc]init];
        for(int i=0; i<NUM_OF_ALL_QUES; i++)   //未答题前全设为0  //！！在dataArray没有取所有数据时，根据mid索引的hadAnswer会越界
            [_hadAnswer addObject:@"0"];

        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        
        _leftTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTableView.dataSource = self;
        _leftTableView.delegate = self;
        _rightTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTableView.dataSource = self;
        _rightTableView.delegate = self;
        _mainTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTableView.dataSource = self;
        _mainTableView.delegate = self;
        
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        if(_dataArray.count > 1) {
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, 0);
        }
        
        [self creatView];
    }
    return self;
}

-(void)creatView {
    
    _leftTableView.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _rightTableView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    _mainTableView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTableView];
    [_scrollView addSubview:_rightTableView];
    [_scrollView addSubview:_mainTableView];
    
    [self addSubview:_scrollView];
}
//查看当前页的答案
-(void)showCurrentAnswer {
    AnswerModel* model = _dataArray[_currentPage];
    int page = [model.mid intValue];
    //已答过，无响应
    if([_hadAnswer[page-1] intValue]!= 0) //！！在dataArray没有取所有数据时，根据mid索引的hadAnswer会越界
        return;
    else {
        NSString* rightChoosen;
        if([model.manswer isEqualToString:@"A"])
            rightChoosen = @"1";
        else if([model.manswer isEqualToString:@"B"])
            rightChoosen = @"2";
        else if([model.manswer isEqualToString:@"C"])
            rightChoosen = @"3";
        else
            rightChoosen = @"4";

      [_hadAnswer replaceObjectAtIndex:page-1 withObject:rightChoosen]; //记录选中的选项
    }
    
    [self reloadData];
}
#pragma mark - tableView delegate
//节数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//节头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    AnswerModel* model = [self getTheFitModel:tableView];
    NSString* question;
    if([model.mtype intValue] == 1) {//选择题
        question = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
    }else {//判断题
        question = model.mquestion;
    }
    UIFont* font = [UIFont systemFontOfSize:16];
    CGFloat height = [Tools getSizeWithString:question withFront:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;

    //规范高度
    if(height<=80) {
        return 80;
    }else {
        return height;
    }
}
//节头视图
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    AnswerModel* model = [self getTheFitModel:tableView];
    NSString* question;
    if([model.mtype intValue] == 1) {//选择题
        question = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:0];
    }else {//判断题
        question = model.mquestion;
    }
    UIFont* font = [UIFont systemFontOfSize:16];
    CGFloat height = [Tools getSizeWithString:question withFront:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text = [NSString stringWithFormat:@"%@.%@", model.mid, question];//!!题目编号有待优化
    label.font = font;
    label.numberOfLines=0;
    [view addSubview:label];
    
    return view;
}
//节尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    AnswerModel* model = [self getTheFitModel:tableView];
    NSString* desc = [NSString stringWithFormat:@"答案解析：%@", model.mdesc];
    UIFont* font = [UIFont systemFontOfSize:16];
    CGFloat height = [Tools getSizeWithString:desc withFront:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    
    return height;
}
//节尾视图-答案解析
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    AnswerModel* model = [self getTheFitModel:tableView];
    //如果该题未答不显示解析
    if([_hadAnswer[[model.mid intValue]-1] intValue]  == 0)//！！在dataArray没有取所有数据时，根据mid索引的hadAnswer会越界
        return nil;
    
    NSString* desc = [NSString stringWithFormat:@"答案解析：%@", model.mdesc];
    UIFont* font = [UIFont systemFontOfSize:16];
    CGFloat height = [Tools getSizeWithString:desc withFront:font withSize:CGSizeMake(tableView.frame.size.width-20, 400)].height + 20;
    
    UIView* view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, height)];
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, height-20)];
    label.text = desc;
    label.font = font;
    label.numberOfLines=0;
    label.textColor = [UIColor greenColor];
    [view addSubview:label];
    
    return view;
}
//单元数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
//单元格式
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取单元格
    static NSString* cellID = @"AnswerTableViewCell";
    AnswerTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        //设置圆角
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 10;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //获取当前章节下当前页数的题目数据
    AnswerModel* model = [self getTheFitModel:tableView];
    //设置单元格信息
    cell.numberLabel.text = [NSString stringWithFormat:@"%c", (char)('A'+indexPath.row)];
    //从整页的内容中获取当前单元选项所需的内容
    if([model.mtype intValue] == 1) {//选择题
        cell.answerLaber.text = [[Tools getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row + 1];
    }
    //处理答案显示
    int page = [model.mid intValue];
    //已答,直接显示单元格
    if([_hadAnswer[page-1] intValue]!= 0) {//！！在dataArray没有取所有数据时，根据mid索引的hadAnswer会越界
        NSString* currentChosen = [NSString stringWithFormat:@"%c", 'A'+(int)indexPath.row];
        if([model.manswer isEqualToString:currentChosen]) {//当前要设置的单元是正确答案
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"19.png"];
        }else if(indexPath.row+1 == [_hadAnswer[page-1] intValue]) {//当前要设置的单元是用户之前错选的选项
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"20.png"];
        }
    }else {//未答题，不显示答案
        cell.numberImage.hidden = YES;
    }
    
    return cell;
}

//获取当前章节下当前页数的题目数据
-(AnswerModel*)getTheFitModel:(UITableView*)tableView {
    AnswerModel* model; //保存当前整道题目的信息内容
    //区分当前更新的tableView的数据源
    if(tableView == _leftTableView) {
        if(_currentPage == 0)
            model = _dataArray[_currentPage];
        else
            model = _dataArray[_currentPage-1];
    }else if(tableView == _mainTableView) {
        if(_currentPage == 0)
            model = _dataArray[_currentPage+1];
        else if(_currentPage == _dataArray.count -1)
            model = _dataArray[_currentPage-1];
        else
            model = _dataArray[_currentPage];
    }else {//rightTableView
        if(_currentPage == _dataArray.count-1)
            model = _dataArray[_currentPage];
        else
            model = _dataArray[_currentPage+1];
        
    }
    return model;
}
//单元选中时
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerModel* model = [self getTheFitModel:tableView];
    int page = [model.mid intValue];
    //已答过，无响应
    if([_hadAnswer[page-1] intValue]!= 0)//！！在dataArray没有取所有数据时，根据mid索引的hadAnswer会越界
        return;
    else {
        [_hadAnswer replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]]; //记录选中的选项
        //选错则加入错题本
        AnswerModel* model = [self getTheFitModel:tableView];//获取当前章节下当前页数的题目数据
        NSString* currentChosen = [NSString stringWithFormat:@"%c", 'A'+(int)indexPath.row];
        if(![model.manswer isEqualToString:currentChosen]) {
            [QuestionCollectManager addWrongQuestion:model.mid];
            NSLog(@"%@",[QuestionCollectManager getWrongQuestion]);
        }else {
                _score++;//考试分数
        }
    }
    
    [self reloadData];
}
#pragma mark - scrollView delegate
//屏幕滑动结束
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGPoint currentOffset = scrollView.contentOffset;
    int page = currentOffset.x/SIZE.width;
    if(page > 0 && page < _dataArray.count-1) { //当前还有剩余页，可以继续滑动
        _scrollView.contentSize = CGSizeMake(currentOffset.x + SIZE.width*2, 0);
        
        _mainTableView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTableView.frame = CGRectMake(currentOffset.x - SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTableView.frame = CGRectMake(currentOffset.x + SIZE.width, 0, SIZE.width, SIZE.height);
    }
    
    _currentPage = page;    //更新当前页
    [self reloadData];
}
-(void)reloadData {//调用cellForRowAtIndexPath更新数据
    [_leftTableView reloadData];
    [_rightTableView reloadData];
    [_mainTableView reloadData];
}
//返回题目数量
-(int)getDataCount {
    return (int)_dataArray.count;
}
//返回当前题目的mid
-(NSString*)getCurrentQuestionMid {
    AnswerModel* model = _dataArray[_currentPage];//获取当前章节下当前页数的题目数据
    return model.mid;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
