//
//  SelectModelView.m
//  Drive
//
//  Created by BlackApple on 2017/6/7.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "SelectModelView.h"

@implementation SelectModelView
{
    SelectTouch block;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(SelectModelView* )initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch {
    self = [super initWithFrame:frame];
    if(self) {
        [self creatUI];
        block = touch;
        _model = testModel;
    }
    return self;
}
//创建屏幕的控件
-(void)creatUI {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];//设置为透明
    
    NSArray* labelText = @[@"答题模式", @"背题模式"];
    for(int i=0; i<2; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        int height = i == 0 ? (self.frame.size.height/2 - 100 - 40 - 64) : (self.frame.size.height/2 + 20);
        btn.frame = CGRectMake(self.frame.size.width/2 - 50, height, 100, 100);
        btn.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d11q.png", i+1]] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        btn.tag = 401 + i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(btn.center.x - 40, height+100+10, 80, 20)];
        label.font = [UIFont systemFontOfSize:15];
        label.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = labelText[i];
        
        [self addSubview:btn];
        [self addSubview:label];
    }
}
//button响应
-(void)click:(UIButton*)btn {
    if(btn.tag == 401) {//答题模式
        _model = testModel;
    }else {//背题模式
        _model = lookingModel;
    }
    block(_model);
}
//点击空白退出
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.alpha = 0;
}
@end
