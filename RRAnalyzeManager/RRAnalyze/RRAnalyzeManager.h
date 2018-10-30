//
//  RRAnalyzeManager.h
//  LocationProtector
//
//  Created by Ruin on 2018/10/23.
//  Copyright © 2018 com.yyj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Firebase.h>
#import <AppsFlyerLib/AppsFlyerTracker.h>
#import <UMAnalytics/MobClick.h>

typedef NS_ENUM(NSUInteger, AnalyzePattern) {
    AnalyzePatternDebug,        //Debug模式，不跟踪页面和事件
    AnalyzePatternTrackAll,     //默认跟踪所有页面，可设置Controller中trackScreen为No不跟踪
    AnalyzePatternTrackNone,    //默认不跟踪页面，可设置Controller中trackScreen为YES跟踪
    AnalyzePatternTrackCustom,  //跟踪trackDictionary中的页面,Key为页面名，Value为统计数据中页面显示名。
};


/*
 *可同时使用多种方式
 */
typedef enum AnalyzeApproach {
    AnalyzeApproachNone         = 0,
    AnalyzeApproachFacebook     = 1 << 0,
    AnalyzeApproachFirebase     = 1 << 1,
    AnalyzeApproachAppsFlyer    = 1 << 2,
    AnalyzeApproachUMeng        = 1 << 3,
} AnalyzeApproach;


@interface RRAnalyzeManager : NSObject

@property (nonatomic) AnalyzePattern trackPattern;

@property (nonatomic) AnalyzeApproach trackApproach;

@property (nonatomic, strong) NSDictionary * trackDictionary;

+ (instancetype) shareManager;

+ (void) trackEvent:(NSString *) event;

+ (void) trackEvent:(NSString *) event value:(NSDictionary *) paramter;

+ (void) trackScreen:(NSString *) screenName;

+ (void) trackUMengBeginScreen:(NSString *) screenName;

+ (void) trackUMengEndScreen:(NSString *) screenName;

@end
