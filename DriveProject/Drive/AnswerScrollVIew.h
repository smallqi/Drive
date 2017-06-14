//
//  AnswerScrollVIew.h
//  Drive
//
//  Created by BlackApple on 2017/6/5.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollVIew : UIView
{
    @public
    UIScrollView* _scrollView;
}
@property(nonatomic, readonly)int currentPage;
@property(nonatomic, assign)int score;//考试分数

-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray*) array;
-(void)showCurrentAnswer;  //查看答案
-(int)getDataCount;//返回题目数量
-(NSString*)getCurrentQuestionMid;//返回当前题目的mid

@end
