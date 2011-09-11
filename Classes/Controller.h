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

@interface Controller : NSObject <AVAudioRecorderDelegate> {
	NSURL * recordedTmpFile;
	AVAudioRecorder * recorder;
	NSError * error;
	BOOL recording; // NO => not recording; YES: recording
}

-(IBAction)listen:(id)sender;
-(IBAction)record:(id)sender;
-(IBAction)play:(id)sender;

@property (nonatomic, retain) AVAudioPlayer *avPlayer;

-(void)startRecording;

@end
