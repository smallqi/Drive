//
//  MyDataManager.h
//  Drive
//
//  Created by BlackApple on 2017/6/5.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    chapter, //章节练习
    answer, //答题数据
    subChapter //专项练习
}DataType;

@interface MyDataManager : NSObject

+(NSArray* )getData:(DataType)type;

@end
