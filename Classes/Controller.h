//
//  Controller.h
//  ButtonTest
//
//  Created by Mitul Tiwari on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioRecorder.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <CoreAudio/CoreAudioTypes.h>

static const NSString *words[] = {@"about", @"baby", @"children", @"decimal", @"dictionary", @"doctor", @"pronunciation", @"salmagundi", @"wednesday", nil};

@interface Controller : NSObject <AVAudioRecorderDelegate> {
	NSURL * recordedTmpFile;
	AVAudioRecorder * recorder;
	NSError * error;
	BOOL recording; // NO => not recording; YES: recording
	IBOutlet UIButton *recordButton;
}

-(IBAction)listen:(id)sender;
-(IBAction)record:(id)sender;
-(IBAction)play:(id)sender;

-(void)startRecording;
-(void)playClip:(NSURL*)filename;

@end
