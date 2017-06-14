//
//  QuestionCollectManager.m
//  Drive
//
//  Created by BlackApple on 2017/6/12.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "QuestionCollectManager.h"

@implementation QuestionCollectManager
//错题本
+(NSArray*)getWrongQuestion {
    NSArray* result = [[NSUserDefaults standardUserDefaults]objectForKey:@"WRONG_QUESTION"];
    if(result == nil)
        return @[];
    return result;
}

+(void)addWrongQuestion:(NSString* )mid {
    NSArray* source = [[NSUserDefaults standardUserDefaults]objectForKey:@"WRONG_QUESTION"];
    NSMutableArray* newArr = [NSMutableArray arrayWithArray:source];
    [newArr addObject:mid];
    
    [[NSUserDefaults standardUserDefaults]setObject:newArr  forKey:@"WRONG_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存到本地
}

+(void)removeQuestion:(NSString* )mid {
    NSArray* source = [[NSUserDefaults standardUserDefaults]objectForKey:@"WRONG_QUESTION"];
    NSMutableArray* newArr = [NSMutableArray arrayWithArray:source];
    for(int i=(int)newArr.count-1; i>=0; i--) {
        if([newArr[i] isEqualToString:mid])
            [newArr removeObjectAtIndex:i];
    }
    [[NSUserDefaults standardUserDefaults]setObject:newArr  forKey:@"WRONG_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存到本地
}
//收藏夹
+(NSArray*)getCollectQuestion {
    NSArray* result = [[NSUserDefaults standardUserDefaults]objectForKey:@"COLLECT_QUESTION"];
    if(result == nil)
        return @[];
    return result;
}

+(void)addCollectQuestion:(NSString* )mid {
    NSArray* source = [[NSUserDefaults standardUserDefaults]objectForKey:@"COLLECT_QUESTION"];
    NSMutableArray* newArr = [NSMutableArray arrayWithArray:source];
    [newArr addObject:mid];
    
    [[NSUserDefaults standardUserDefaults]setObject:newArr  forKey:@"COLLECT_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存到本地
}

+(void)removeCollect:(NSString* )mid {
    NSArray* source = [[NSUserDefaults standardUserDefaults]objectForKey:@"COLLECT_QUESTION"];
    NSMutableArray* newArr = [NSMutableArray arrayWithArray:source];
    for(int i=(int)newArr.count-1; i>=0; i--) {
        if([newArr[i] isEqualToString:mid])
            [newArr removeObjectAtIndex:i];
    }
    [[NSUserDefaults standardUserDefaults]setObject:newArr  forKey:@"COLLECT_QUESTION"];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存到本地
}

//分数统计
+(void)setScore:(int)score {
    [[NSUserDefaults standardUserDefaults]setInteger:score forKey:@"SCORE"];
    [[NSUserDefaults standardUserDefaults] synchronize];//保存到本地
}
+(int)getScore {
    return (int)[[NSUserDefaults standardUserDefaults]integerForKey:@"SCORE"];
}
@end
