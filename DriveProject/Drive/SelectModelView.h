//
//  SelectModelView.h
//  Drive
//
//  Created by BlackApple on 2017/6/7.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    testModel,
    lookingModel
}SelectModel;

typedef void(^SelectTouch)(SelectModel model);

@interface SelectModelView : UIView

@property(nonatomic, assign)SelectModel model;

-(SelectModelView* )initWithFrame:(CGRect)frame addTouch:(SelectTouch)touch;

@end
