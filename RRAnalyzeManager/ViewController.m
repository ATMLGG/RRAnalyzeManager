//
//  ViewController.m
//  RRAnalyzeManager
//
//  Created by 杨赟鋆 on 2018/10/30.
//  Copyright © 2018 com.webeye. All rights reserved.
//

#import "ViewController.h"
#import "RRAnalyze.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    [RRAnalyzeManager shareManager].trackPattern = AnalyzePatternTrackCustom;
    [RRAnalyzeManager shareManager].trackDictionary = @{
                                                        NSStringFromClass([self class]):@"showViewController"
                                                        };
    
    [RRAnalyzeManager shareManager].trackApproach =
    AnalyzeApproachFirebase | AnalyzeApproachUMeng | AnalyzeApproachFacebook;
    
    [RRAnalyzeManager trackEvent:@"123"];
}


@end
