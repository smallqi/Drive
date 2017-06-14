//
//  TestSelectViewController.h
//  Drive
//
//  Created by BlackApple on 2017/6/4.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestSelectViewController : UIViewController

@property(nonatomic, copy)NSString* myTitle;
@property(nonatomic, copy)NSArray* dataArray;   //tableView datasource
@property(nonatomic, assign)int type;   //1,章节练习 2,专项练习

@end
