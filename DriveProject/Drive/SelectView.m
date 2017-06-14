//
//  SelectView.m
//  Drive
//
//  Created by BlackApple on 2017/6/4.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "SelectView.h"

@implementation SelectView
{
    UIButton* _button;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame andBtn:(UIButton *)btn
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];   //设置黑色透明背景
        [self creatBtn];
    
        _button = btn;
    }
    return self;
}

//创建选择的4个按钮
-(void)creatBtn
{
    for(int i=0; i<4; i++)
    {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(self.frame.size.width/4*i + self.frame.size.width/4/2 - 30, self.frame.size.height - 80, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png", i+1]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
    }
}

//重写视图点击事件
//实现渐变效果
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}

//btn点击事件
//更新viewbutton的样式
-(void)click:(UIButton*)btn
{
    [_button setImage:[btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }]; //渐变动画
}

@end
