//
//  MyDataManager.m
//  Drive
//
//  Created by BlackApple on 2017/6/5.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "MyDataManager.h"
#import "FMDatabase.h"
#import "TestSelectModel.h"
#import "AnswerModel.h"
#import "SubTestSelectModel.h"

@implementation MyDataManager

//获取指定表中的数据
+(NSArray* )getData:(DataType)type {
    
    //打开数据库
    static FMDatabase* dataBase=nil;
    if(dataBase == nil) {
        NSString* path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase = [[FMDatabase alloc]initWithPath:path];
    }
    if([dataBase open]) {
        NSLog(@"open success");
    }else {
        NSLog(@"dataBase open fail");
        return nil;
    }
    //获取数据
    NSMutableArray* arr = [[NSMutableArray alloc]init]; //保存获得的数据
    switch (type) {
        case chapter://获取章节信息
        {
            NSString* sql = @"select pid,pname,pcount FROM firstlevel";
            FMResultSet* rs = [dataBase executeQuery:sql];
            
            while([rs next]) {
                TestSelectModel* model = [[TestSelectModel alloc]init];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.pcount = [NSString stringWithFormat:@"%d", [rs intForColumn:@"pcount"]];
                
                [arr addObject:model];
            }
        }
            break;
        case answer://获取所有题目信息
        {
            NSString* sql = @"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM leaflevel";
            FMResultSet* rs = [dataBase executeQuery:sql];
            
            while([rs next]) {
                AnswerModel* model = [[AnswerModel alloc]init];
                model.mquestion = [rs stringForColumn:@"mquestion"];
                model.mdesc = [rs stringForColumn:@"mdesc"];
                model.mid = [NSString stringWithFormat:@"%d", [rs intForColumn:@"mid"] ];
                model.manswer = [rs stringForColumn:@"manswer"];
                model.mimage = [rs stringForColumn:@"mimage"];
                model.pid = [NSString stringWithFormat:@"%d", [rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.sid = [rs stringForColumn:@"sid"];
                model.sname = [rs stringForColumn:@"sname"];
                model.mtype = [NSString stringWithFormat:@"%d", [rs intForColumn:@"mtype"]];
                
                [arr addObject:model];
            }
        }
        default:
            break;
        case subChapter://获取章节信息
        {
            NSString* sql = @"select pid,sname,scount,sid FROM secondlevel";
            FMResultSet* rs = [dataBase executeQuery:sql];
            
            while([rs next]) {
                SubTestSelectModel* model = [[SubTestSelectModel alloc]init];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.sid = [rs stringForColumn:@"sid"];
                model.sname = [rs stringForColumn:@"sname"];
                model.scount = [NSString stringWithFormat:@"%d", [rs intForColumn:@"scount"]];
                
                [arr addObject:model];
            }
        }
            break;
    }
    
    return arr;
}

@end
