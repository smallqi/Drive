//
//  Tools.m
//  Drive
//
//  Created by BlackApple on 2017/6/6.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import "Tools.h"

@implementation Tools

+(NSArray*)getAnswerWithString:(NSString*)questionAndChoosen {
    NSMutableArray* result = [[NSMutableArray alloc]init]; //保存结果
    NSArray* contents = [questionAndChoosen componentsSeparatedByString:@"<BR>"];
    [result addObject:contents[0]]; //加入题目
    for(int i=0; i<4; i++)//默认有4个选项，判断题可能越界
    {
        //int a ;
        [result addObject:[contents[i+1] substringFromIndex:2]];//去掉前面的‘A、’
    }
    return result;
}

+(CGSize)getSizeWithString:(NSString*)str withFront:(UIFont*) font withSize:(CGSize) size {
    CGSize newSize = [str sizeWithFont:font constrainedToSize:size];
    return newSize;
}
@end
