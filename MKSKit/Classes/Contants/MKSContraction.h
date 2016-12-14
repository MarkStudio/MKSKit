//
//  MSContraction.h
//  Pods
//
//  Created by Mark Yang on 14/12/2016.
//
//

#ifndef MKSContraction_h
#define MKSContraction_h

// 定义weak变量
#define WS(weakSelf) __weak __typeof(&*self)weakSelf = self;

// 设置view圆角化
#define MSViewBorderRadius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
View.layer.masksToBounds = YES;\
[View.layer setBorderColor:[Color CGColor]]

// c is class name like: @"classA"
#define HasClass(c) (NSClassFromString(c))

#endif /* MSContraction_h */
