//
//  UIViewController+Analyze.m
//  LocationProtector
//
//  Created by Ruin on 2018/10/30.
//  Copyright © 2018 com.yyj. All rights reserved.
//

#import "UIViewController+Analyze.h"
#import <objc/runtime.h>
#import "RRAnalyzeManager.h"

static char * TrackKey = "TrackKey";
static char * TrackSeted = "TrackSeted";

@implementation UIViewController (Analyze)

+ (void) load{
    [UIViewController exchangeMethod:@selector(viewWillAppear:) targetSEL:@selector(ex_viewWillAppear:)];
    [UIViewController exchangeMethod:@selector(viewWillDisappear:) targetSEL:@selector(ex_viewWillDisappear:)];
    [UIViewController exchangeMethod:@selector(viewDidLoad) targetSEL:@selector(ex_viewDidLoad)];
}

+ (void) exchangeMethod:(SEL) originSEL targetSEL:(SEL) targetSEL{
    
    Method originMethod = class_getInstanceMethod(self, originSEL);
    Method targetMethod = class_getInstanceMethod(self, targetSEL);
    
    IMP originIMP = class_getMethodImplementation(self, originSEL);
    IMP targetIMP = class_getMethodImplementation(self, targetSEL);
    
    BOOL didAddMethod = class_addMethod(self, originSEL, targetIMP, method_getTypeEncoding(originMethod));
    
    if (didAddMethod) {
        class_replaceMethod(self, targetSEL, originIMP, method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, targetMethod);
    }
}

- (void) ex_viewDidLoad{
    switch ([RRAnalyzeManager shareManager].trackPattern) {
        case AnalyzePatternTrackAll:{
            if (!self.trackScreen && self.trackSeted) {
                break;
            }
            [RRAnalyzeManager trackScreen:NSStringFromClass([self class])];
        }
            break;
        case AnalyzePatternTrackNone:{
            if (self.trackScreen) {
                [RRAnalyzeManager trackScreen:NSStringFromClass([self class])];
            }
        }
            break;
        default:
            if (!self.trackScreen && self.trackSeted) {
                break;
            }
            [RRAnalyzeManager trackScreen:NSStringFromClass([self class])];
            break;
    }
    
    [self ex_viewDidLoad];
}

- (void) ex_viewWillAppear:(BOOL) animated{
    switch ([RRAnalyzeManager shareManager].trackPattern) {
        case AnalyzePatternTrackAll:{
            if (!self.trackScreen && self.trackSeted) {
                break;
            }
            [RRAnalyzeManager trackUMengBeginScreen:NSStringFromClass([self class])];
        }
            break;
        case AnalyzePatternTrackNone:{
            if (self.trackScreen) {
                [RRAnalyzeManager trackUMengBeginScreen:NSStringFromClass([self class])];
            }
        }
            break;
        default:{
            if (!self.trackScreen && self.trackSeted) {
                break;
            }
            [RRAnalyzeManager trackUMengBeginScreen:NSStringFromClass([self class])];
        }
            break;
    }
    [self ex_viewWillAppear:animated];
}

- (void) ex_viewWillDisappear:(BOOL) animated{
    switch ([RRAnalyzeManager shareManager].trackPattern) {
        case AnalyzePatternTrackAll:{
            if (!self.trackScreen && self.trackSeted) {
                break;
            }
            [RRAnalyzeManager trackUMengEndScreen:NSStringFromClass([self class])];
        }
            break;
        case AnalyzePatternTrackNone:{
            if (self.trackScreen) {
                [RRAnalyzeManager trackUMengEndScreen:NSStringFromClass([self class])];
            }
        }
            break;
        default:{
            if (!self.trackScreen && self.trackSeted) {
                break;
            }
            [RRAnalyzeManager trackUMengEndScreen:NSStringFromClass([self class])];
        }
            break;
    }
    [self ex_viewWillDisappear:animated];
}

- (BOOL) trackScreen{
    NSNumber * number = objc_getAssociatedObject(self, TrackKey);
    return [number boolValue];
}

- (void) setTrackScreen:(BOOL)trackScreen{
    self.trackSeted = YES;//只有手动设置过此值才能作为是否跟踪的依据
    objc_setAssociatedObject(self, TrackKey, @(trackScreen), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL) trackSeted{
    NSNumber * number = objc_getAssociatedObject(self, TrackSeted);
    return [number boolValue];
}

- (void) setTrackSeted:(BOOL)trackSeted{
    objc_setAssociatedObject(self, TrackKey, @(trackSeted), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
