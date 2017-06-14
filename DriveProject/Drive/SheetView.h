//
//  SheetView.h
//  Drive
//
//  Created by BlackApple on 2017/6/7.
//  Copyright © 2017年 BlackApple. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SheetViewDelegate <NSObject>

-(void)SheetViewClick:(int)index;   //btn响应

@end

@interface SheetView : UIView
{
    @public
    UIView* _backView;
}
@property(nonatomic, weak)id<SheetViewDelegate> delegate;//代理

-(instancetype)initWithFrame:(CGRect)frame withSuperView:(UIView*) superView withCount:(int)count;

@end
