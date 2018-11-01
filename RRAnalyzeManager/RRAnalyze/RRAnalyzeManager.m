//
//  RRAnalyzeManager.m
//  LocationProtector
//
//  Created by Ruin on 2018/10/23.
//  Copyright © 2018 com.yyj. All rights reserved.
//

#import "RRAnalyzeManager.h"

@implementation RRAnalyzeManager

+ (instancetype) shareManager{
    static dispatch_once_t onceToken;
    static RRAnalyzeManager * manager = nil;
    dispatch_once(&onceToken, ^{
        manager = [RRAnalyzeManager new];
        manager.trackPattern = AnalyzePatternTrackAll;
        manager.trackApproach = AnalyzeApproachNone;
    });
    
    return manager;
}

+ (void) initUMengWithAppkey:(NSString *)appkey
                  andChannel:(NSString *)channel
             andScenarioType:(eScenarioType)type {
    
    [RRAnalyzeManager shareManager].trackApproach |= AnalyzeApproachUMeng;
    
    [UMConfigure initWithAppkey:appkey channel:channel];
    [MobClick setScenarioType:type];
    
#ifdef DEBUG
    [UMConfigure setLogEnabled:YES];
#endif
    
}

+ (void) initFacebookWithApplication:(UIApplication *)application
                    andLaunchOptions:(NSDictionary *)launchOptions {
    
    [RRAnalyzeManager shareManager].trackApproach |= AnalyzeApproachFacebook;
    
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
}

+ (void) initFirebaseWithNothing {
    
    [RRAnalyzeManager shareManager].trackApproach |= AnalyzeApproachFirebase;
    [FIRApp configure];
}

+ (void) initAppsFlyerWithAppsFlyerDevKey:(NSString *)appsFlyerDevKey
                            andAppleAppID:(NSString *)appleAppID {
    
    [RRAnalyzeManager shareManager].trackApproach |= AnalyzeApproachAppsFlyer;
    
    [AppsFlyerTracker sharedTracker].appsFlyerDevKey = appsFlyerDevKey;
    [AppsFlyerTracker sharedTracker].appleAppID = appleAppID;
    
#ifdef DEBUG
    [AppsFlyerTracker sharedTracker].isDebug = true;
#endif
}

+ (void) activeTrack {
    
    if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachFacebook) {
        [FBSDKAppEvents activateApp];
    }
    
    if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachAppsFlyer) {
        [[AppsFlyerTracker sharedTracker] trackAppLaunch];
    }
}

+ (void) trackEvent:(NSString *) event{
    
    if ([RRAnalyzeManager shareManager].trackPattern != AnalyzePatternDebug &&
        [RRAnalyzeManager shareManager].trackApproach != AnalyzeApproachNone) {
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachFirebase) {
            [FIRAnalytics logEventWithName:event parameters:nil];
        }
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachUMeng) {
            [MobClick event:event];
        }
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachAppsFlyer) {
            [[AppsFlyerTracker sharedTracker] trackEvent:event withValues:nil];
        }
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachFacebook) {
            [FBSDKAppEvents logEvent:event];
        }
    }
}

+ (void) trackEvent:(NSString *) event value:(NSDictionary *) paramter{
    
    if ([RRAnalyzeManager shareManager].trackPattern != AnalyzePatternDebug &&
        [RRAnalyzeManager shareManager].trackApproach != AnalyzeApproachNone) {
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachFirebase) {
            [FIRAnalytics logEventWithName:event parameters:paramter];        }
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachUMeng) {
            [MobClick event:event attributes:paramter];
        }
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachAppsFlyer) {
            [[AppsFlyerTracker sharedTracker] trackEvent:event withValues:paramter];
        }
        
        if ([RRAnalyzeManager shareManager].trackApproach & AnalyzeApproachFacebook) {
            [FBSDKAppEvents logEvent:event parameters:paramter];
        }
    }
}

+ (void) trackScreen:(NSString *) screenName{
    
    RRAnalyzeManager * manager = [RRAnalyzeManager shareManager];
    if (manager.trackPattern != AnalyzePatternDebug) {
        if ([[manager.trackDictionary allKeys] containsObject:screenName] && manager.trackPattern == AnalyzePatternTrackCustom) {
            [FIRAnalytics setScreenName:[manager.trackDictionary objectForKey:screenName] screenClass:screenName];
        } else {
            [FIRAnalytics setScreenName:screenName screenClass:screenName];
        }
    }
}

+ (void) trackUMengBeginScreen:(NSString *) screenName{
    
    RRAnalyzeManager * manager = [RRAnalyzeManager shareManager];
    if (manager.trackPattern != AnalyzePatternDebug) {
        if ([[manager.trackDictionary allKeys] containsObject:screenName] && manager.trackPattern == AnalyzePatternTrackCustom) {
            [MobClick beginLogPageView:[manager.trackDictionary objectForKey:screenName]];
        } else {
            [MobClick beginLogPageView:screenName];
        }
    }
}

+ (void) trackUMengEndScreen:(NSString *) screenName{
    
    RRAnalyzeManager * manager = [RRAnalyzeManager shareManager];
    if (manager.trackPattern != AnalyzePatternDebug) {
        if ([[manager.trackDictionary allKeys] containsObject:screenName] && manager.trackPattern == AnalyzePatternTrackCustom) {
            [MobClick endLogPageView:[manager.trackDictionary objectForKey:screenName]];
        } else {
            [MobClick endLogPageView:screenName];
        }
    }
}

@end
