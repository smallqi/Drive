//
//  MainTestViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/10.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "MainTestViewController.h"
#import "AnswerViewController.h"

@interface MainTestViewController ()

@end

@implementation MainTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.title = @"模拟考试";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)click:(UIButton *)sender {
    switch (sender.tag) {
        case 201://全真模拟考试
        {
            NSLog(@"全真考试");
            AnswerViewController* avc = [[AnswerViewController alloc]initWithNumber:0 WithType:5];
            [self.navigationController pushViewController:avc animated:YES];
        }
            break;
        case 202://优先考未做题
        {
            
        }
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
