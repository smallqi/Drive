//
//  AnswerViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/5.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollVIew.h"
#import "Screen.h"
#import "MyDataManager.h"
#import "AnswerModel.h"
#import "SelectModelView.h"
#import "SheetView.h"
#import "SubTestSelectModel.h"
#import "QuestionCollectManager.h"

@interface AnswerViewController ()<SheetViewDelegate, UIAlertViewDelegate>
{
    AnswerScrollVIew* view;
    SelectModelView* selectModelView;
    SheetView* sheetView;
    
    NSTimer* _timer;    //考试模式下的时间
    int time;
    UILabel* _timeLabel; //显示时间
}
@end

@implementation AnswerViewController
-(instancetype)initWithNumber:(int)number WithType:(int)type {
    self = [super init];
    if(self) {
        self.number = number;
        self.type = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor redColor];
    
    [self creatModelView];//创建模式视图
    
    view = [[AnswerScrollVIew alloc]initWithFrame:CGRectMake(0, 0, screen.width, screen.height-64-60) withDataArray:[self getChapterData]];
    view.score = 0;//分数初始化为0
    
    [self.view addSubview:view];
    
    [self creatToolBar];//创建标签栏
    [self creatSheetView];//创建题目列表图
}
//获取当前章节的题目
-(NSArray* )getChapterData {
    NSMutableArray* result = [[NSMutableArray alloc]init];
    NSArray* allChaperData = [MyDataManager getData:answer];    //获得所有章节的题目
    switch (_type) {
        case 1: //章节练习
        {
            for(int i=0; i<allChaperData.count; i++) {
                AnswerModel* model = allChaperData[i];
                if([model.pid intValue] == _number+1)   //隶属于目前章节则加入
                    [result addObject:model];
            }
        }
            break;
        case 2: //顺序练习
        {
            [result addObjectsFromArray:allChaperData];
        }
            break;
        case 3: //随机练习
        {
            NSMutableArray* tempArr = [[NSMutableArray alloc]initWithArray:allChaperData];
            int len = (int)tempArr.count;
            for(int i=0; i<len; i++) {
                int index = arc4random()%(tempArr.count);
                [result addObject:tempArr[index]];
                [tempArr removeObjectAtIndex:index];
            }
        }
            break;
        case 4: //专项练习
        {
            for(int i=0; i<allChaperData.count; i++) {
                AnswerModel* model = allChaperData[i];
                if([model.sid isEqualToString:_subChepterSid])   //隶属于目前章节则加入
                    [result addObject:model];
            }

        }
            break;
        case 5: //全真考试
        {
            NSMutableArray* tempArr = [[NSMutableArray alloc]initWithArray:allChaperData];
            for(int i=0; i<100; i++) {
                int index = arc4random()%(tempArr.count);
                [result addObject:tempArr[index]];
                [tempArr removeObjectAtIndex:index];
            }
            //创建导航栏
            [self creatNavBtn];
            [self creatTimeLabel];//创建时间显示
        }
            break;
        case 7: //错题本
        {
            NSArray* wrongQuestions = [QuestionCollectManager getWrongQuestion];
            //根据错题本的mid从所有的数据中索引到题目，添加
            for(int i=0; i<wrongQuestions.count; i++) {
                int index = [wrongQuestions[i] intValue];
                AnswerModel* model = allChaperData[index];
                [result addObject:model];
            }
        }
            break;
        case 8: //收藏夹
        {
            NSArray* collectQuestions = [QuestionCollectManager getCollectQuestion];
            //根据错题本的mid从所有的数据中索引到题目，添加
            for(int i=0; i<collectQuestions.count; i++) {
                int index = [collectQuestions[i] intValue];
                AnswerModel* model = allChaperData[index];
                [result addObject:model];
            }
        }
            break;
        default:
            break;
    }
    return result;
}
//创建导航栏
-(void)creatNavBtn {
    UIBarButtonItem* itemLeft = [[UIBarButtonItem alloc]init];
    itemLeft.title = @"返回";
    itemLeft.style = UIBarButtonItemStylePlain;
    [itemLeft setTarget:self];
    [itemLeft setAction:@selector(clickNavBtnReturn)];
    self.navigationItem.leftBarButtonItem = itemLeft;
    
    UIBarButtonItem* itemRight = [[UIBarButtonItem alloc]init];
    itemRight.title = @"交卷";
    itemRight.style = UIBarButtonItemStylePlain;
    [itemRight setTarget:self];
    [itemRight setAction:@selector(clickNavBtnRight)];
    self.navigationItem.rightBarButtonItem = itemRight;
}
//返回键点击事件
-(void)clickNavBtnReturn {
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"时间还多，确定要离开？" delegate:self cancelButtonTitle:@"不离开" otherButtonTitles:@"离开", nil];
    [alert show];
    
}
//导航栏右键“交卷“点击事件
-(void)clickNavBtnRight {
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"确定交卷？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"交卷", nil];
    [alert show];
    
}
#pragma mark - AlertViewDellegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            //考试交卷
            //NSLog(@"分数为：%d",view.score);
            [QuestionCollectManager setScore:view.score];
            [self.navigationController popViewControllerAnimated:YES];
        }
        default:
            break;
    }
}
//创建时间显示
-(void)creatTimeLabel {
    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 64)];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.text = @"60:00";
    self.navigationItem.titleView = _timeLabel;
    
    time = 3600;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(runTime) userInfo:nil repeats:YES];
}
//时间回调函数
-(void)runTime {
    time--;
    _timeLabel.text = [NSString stringWithFormat:@"%d:%d", time/60, time%60];
}
//创建答题表的视图
-(void)creatSheetView {
    sheetView = [[SheetView alloc]initWithFrame:CGRectMake(0, screen.height, screen.width, screen.height-80) withSuperView:self.view withCount:[view getDataCount]];
    sheetView.delegate = self;
    [self.view addSubview:sheetView];
}
#pragma mark - delegate
-(void)SheetViewClick:(int)index {
    UIScrollView* scrollView = view->_scrollView;
    scrollView.contentOffset = CGPointMake((index-1) * scrollView.frame.size.width, 0);
    [scrollView.delegate scrollViewDidEndDecelerating:scrollView];
}

//创建模式视图
-(void)creatModelView {
    selectModelView = [[SelectModelView alloc]initWithFrame:self.view.frame addTouch:^(SelectModel model) {
        NSLog(@"当前模式为：%d",model);
    }];
    selectModelView.alpha = 0;
    [self.view addSubview:selectModelView];
    //创建导航按钮
    UIBarButtonItem* item = [[UIBarButtonItem alloc]initWithTitle:@"答题模式" style:UIBarButtonItemStylePlain target:self action:@selector(modelChange:)];
    self.navigationItem.rightBarButtonItem = item;
}
//导航栏点击事件
-(void)modelChange:(UIBarButtonItem*)item {
    [UIView animateWithDuration:0.3 animations:^{
        selectModelView.alpha = 1;
    }];
}

//创建答题栏下的标签栏
-(void)creatToolBar {
    UIView* barView = [[UIView alloc]initWithFrame:CGRectMake(0, screen.height-70-64, screen.width, 70)];
    barView.backgroundColor = [UIColor whiteColor];
    
    NSArray* labelText = @[[NSString stringWithFormat:@"%d", [view getDataCount]], @"查看答案", @"收藏本题"];
    for(int i=0; i<3; i++) {
        if(i==1 && _type == 5)//考试模式不显示答案
            continue;
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(screen.width/3 * i + screen.width/3/2 - 18, 0, 36, 36);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", 16+i]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d-2.png", 16+i]] forState:UIControlStateHighlighted];
        btn.tag = 301+i;
        [btn addTarget:self action:@selector(clickToolBar:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* label = [[UILabel alloc]init];
        label.frame = CGRectMake(btn.center.x - 30, 40, 60, 18);
        label.textAlignment = NSTextAlignmentCenter;
        label.text = labelText[i];
        label.font = [UIFont systemFontOfSize:14];
        
        [barView addSubview:btn];
        [barView addSubview:label];
    }
    
    [self.view addSubview:barView];
}
//toolbar点击事件
-(void)clickToolBar:(UIButton* )btn {
    switch (btn.tag) {
        case 301://查看题目
        {
            [UIView animateWithDuration:0.3 animations:^{
                sheetView.frame = CGRectMake(0, 80, screen.width, screen.height-80);
                sheetView->_backView.alpha = 0.8;
            }];
        }
            break;
        case 302://查看答案
        {
            [view showCurrentAnswer];
        }
            break;
        case 303://收藏本题
        {
            NSString* mid = [view getCurrentQuestionMid];
            [QuestionCollectManager addCollectQuestion:mid];
            //NSLog(@"%@", [QuestionCollectManager getCollectQuestion]);
        }
            break;
        default:
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
