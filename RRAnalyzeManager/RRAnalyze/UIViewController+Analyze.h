//
//  UIViewController+Analyze.h
//  LocationProtector
//
//  Created by Ruin on 2018/10/30.
//  Copyright © 2018 com.yyj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Analyze)

/**
 是否跟踪页面
 */
@property (nonatomic) BOOL trackScreen;
/**
 确认trackScreen是否被设置过
 */
@property (nonatomic) BOOL trackSeted;

@end

NS_ASSUME_NONNULL_END
