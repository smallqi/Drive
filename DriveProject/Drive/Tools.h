//
//  Tools.h
//  Drive
//
//  Created by BlackApple on 2017/6/6.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject
+(NSArray*)getAnswerWithString:(NSString*)answer;
+(CGSize)getSizeWithString:(NSString*)str withFront:(UIFont*) font withSize:(CGSize) size;
//dddddd
@end
