# RRAnalyzeManager
AF/FB/Firbase/友盟打点集成，屏幕追踪

``` ruby
    pod 'RRAnalyzeManager', '~> 1.0.2'
```

使用方法:
```objc
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    //UMeng
    [RRAnalyzeManager initUMengWithAppkey:@"" andChannel:@"" andScenarioType:E_UM_NORMAL];

    //FB
    [RRAnalyzeManager initFacebookWithApplication:application andLaunchOptions:launchOptions];

    //Firbase
    [RRAnalyzeManager initFirebaseWithNothing];

    //AppsFlyer
    [RRAnalyzeManager initAppsFlyerWithAppsFlyerDevKey:@"" andAppleAppID:@""];


    [RRAnalyzeManager shareManager].trackPattern = AnalyzePatternDebug;
    [RRAnalyzeManager shareManager].trackDictionary = @{
                                                        @"ViewController":@"showViewController",
                                                        @"OtherViewController":@"showOtherVC"
                                                        };

    [RRAnalyzeManager trackEvent:@"123"];
    [RRAnalyzeManager trackEvent:@"withValue" value:@{
                                                        @"userName":@"yyj"
                                                        }];

    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

    [RRAnalyzeManager activeTrack];
}
```


