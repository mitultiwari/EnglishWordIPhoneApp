#import <UIKit/UIKit.h>
#import "Controller.h"

@interface ButtonTestAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	Controller *controller;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end