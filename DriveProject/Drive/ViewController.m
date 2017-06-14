//
//  ViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/3.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "WebPageViewController.h"

@interface ViewController ()
{
    SelectView* _selectView;
}
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //车型视图初始化
    _selectView = [[SelectView alloc] initWithFrame:self.view.frame andBtn:_selectBtn];
    _selectView.alpha = 0;
    [self.view addSubview:_selectView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:   //选择车型
        {
            [UIView animateWithDuration:0.3 animations:^{
                _selectView.alpha=1;
            }];
            
        }
            break;
        case 101:   //科目一
        {
            [self.navigationController pushViewController:[[FirstViewController alloc]init] animated:YES];
        }
            break;
        case 102:   //科目二
        {
            [self.navigationController pushViewController:[[SecondViewController alloc]init] animated:YES];
        }
            break;
        case 103:
        {
            
        }
            break;
        case 104:
        {
            
        }
            break;
        case 105:   // 报名须知
        {
            [self.navigationController pushViewController:[[WebPageViewController alloc]initWithUrl:@"https://www.baidu.com"] animated:YES];
            //对于非https协议网站需要多做处理
        }
            break;
        case 106:
        {
            
        }
            break;
            
        default:
            break;
    }
}


@end
