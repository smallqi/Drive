//
//  WebPageViewController.m
//  Drive
//
//  Created by BlackApple on 2017/6/13.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "WebPageViewController.h"

@interface WebPageViewController ()
{
    UIWebView* web;
}
@end

@implementation WebPageViewController

-(instancetype)initWithUrl:(NSString*)url {
    self = [super init];
    if(self) {
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        web = [[UIWebView alloc]initWithFrame:self.view.frame];
        [web loadRequest:request];
        self.view = web;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
