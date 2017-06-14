//
//  QuestionCollectManager.h
//  Drive
//
//  Created by BlackApple on 2017/6/12.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionCollectManager : NSObject
//错题本
+(NSArray*)getWrongQuestion;
+(void)addWrongQuestion:(NSString*)mid;
+(void)removeQuestion:(NSString* )mid;
//收藏夹
+(NSArray*)getCollectQuestion;
+(void)addCollectQuestion:(NSString*)mid;
+(void)removeCollect:(NSString* )mid;
//分数统计
+(int)getScore;
+(void)setScore:(int)score;

@end
