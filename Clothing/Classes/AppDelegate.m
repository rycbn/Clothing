//
//  AppDelegate.m
//  Clothing
//
//  Created by Roger Yong on 18/10/2016.
//  Copyright © 2016 rycbn. All rights reserved.
//

#import "AppDelegate.h"
#import "Clothing-Swift.h"

@interface AppDelegate ()

@property (strong, nonatomic) AppDependencies *appDependencies;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.appDependencies = [[AppDependencies alloc] init];
    [self.appDependencies installRootViewControllerInto:self.window];
    return YES;
}

@end
