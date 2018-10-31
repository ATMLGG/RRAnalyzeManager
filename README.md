# RRAnalyzeManager
AF/FB/Firbase/友盟打点集成，屏幕追踪

``` ruby
    pod 'RRAnalyzeManager', '~> 1.0.1'
```

使用方法:
```objc
    [RRAnalyzeManager shareManager].trackPattern = AnalyzePatternTrackCustom;
    [RRAnalyzeManager shareManager].trackDictionary = @{
                                                        @"ViewController":@"showViewController",
                                                        @"OtherViewController":@"showOtherVC"
                                                        };
    
    [RRAnalyzeManager shareManager].trackApproach =
    AnalyzeApproachFirebase | AnalyzeApproachUMeng | AnalyzeApproachFacebook;
    
    [RRAnalyzeManager trackEvent:@"123"];
    [RRAnalyzeManager trackEvent:@"withValue" value:@{
                                                      @"userName":@"yyj"
                                                      }];
```
