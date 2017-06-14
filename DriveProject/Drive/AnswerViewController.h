//
//  AnswerViewController.h
//  Drive
//
//  Created by BlackApple on 2017/6/5.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerViewController : UIViewController

@property(nonatomic, assign)int type;   //1,章节练习 2,顺序练习 3,随机练习 4,专项练习 5,全真考试 7,错题本 8,收藏夹
@property(nonatomic, assign)int number; //章节的组号
@property(nonatomic, weak)NSString* subChepterSid;  //专项练习的组号

-(instancetype)initWithNumber:(int)number WithType:(int)type;

@end
