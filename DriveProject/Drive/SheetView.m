//
//  SheetView.m
//  Drive
//
//  Created by BlackApple on 2017/6/7.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "SheetView.h"

@interface SheetView()
{
    UIView* _superView;
    
    BOOL _startingMove;
    float _hight;
    float _width;
    float _y;   //视图在父视图中原始的相对位置
    
    UIScrollView* _scrollView;
    int _count;
}

@end

@implementation SheetView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView*) superView withCount:(int)count {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor whiteColor];
        _superView = superView;
        _hight = self.frame.size.height;
        _width = self.frame.size.width;
        _y = self.frame.origin.y;
        _count = count;
        [self creatView];
    }
    return self;
}
//创建子视图
-(void)creatView {
    //创建背景
    _backView = [[UIView alloc]initWithFrame:_superView.frame];
    _backView.backgroundColor = [UIColor grayColor];
    _backView.alpha = 0;
    [_superView addSubview:_backView];
    //创建滑动视图
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 70, self.frame.size.width, self.frame.size.height - 70)];
    _scrollView.backgroundColor = [UIColor redColor];
    int lineAdd = _count%6 ? 0 : 1;
    _scrollView.contentSize = CGSizeMake(0, 30 + 44*(_count/6 + 1 + lineAdd));
    [self addSubview:_scrollView];
    //添加按钮
    for(int i=0; i<_count; i++) {
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((_width - 44*6)/2 + 44*(i%6), 10 + 44*(i/6), 40, 40);
        btn.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [btn setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 8;
        
        btn.tag = 101+i;
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:btn];
    }
    
}
//题目按钮点击事件
-(void)click:(UIButton*)btn {
    int index = (int)btn.tag-100;
    for(int i=0; i<_count; i++) {//将颜色复原
        UIButton* questionBtn = (UIButton*)[self viewWithTag:i+101];
        questionBtn.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
    }
    btn.backgroundColor = [UIColor orangeColor];
    [_delegate SheetViewClick:index];
}
//手势拖动
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch* touch = [touches anyObject];
    CGPoint point = [touch locationInView:[touch view]];//在当前视图的点击相对位置
    if(point.y < 25) {
        _startingMove = true;
    }
    //随着手指移动更新视图位置
    //!!这一块不是很理解
    if(_startingMove && self.frame.origin.y >= _y-_hight) {
        self.frame = CGRectMake(0, [self convertPoint:point toView:_superView].y, _width, _hight);
        
        float offset = (_superView.frame.size.height - self.frame.origin.y)/_superView.frame.size.height * 0.8;
        _backView.alpha = offset;
    }
}
//根据结束位置自动返回
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _startingMove = NO;
    //!!这里的判断不是很理解
    if(self.frame.origin.y > _y-_hight/2) {//隐藏
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y, _width, _hight);
            _backView.alpha = 0;
        }];
    }else{//显示
        [UIView animateWithDuration:0.3 animations:^{
            self.frame = CGRectMake(0, _y-_hight, _width, _hight);
            _backView.alpha = 0.8;
        }];
    }
}
@end
