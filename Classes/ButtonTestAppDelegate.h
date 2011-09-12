//
//  ButtonTestAppDelegate.h
//  ButtonTest
//
//  Created by Mitul Tiwari on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Controller.h"

@interface ButtonTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	Controller *controller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

