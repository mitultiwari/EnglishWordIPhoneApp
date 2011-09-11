//
//  Controller.m
//  ButtonTest
//
//  Created by Mitul Tiwari on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"

@implementation Controller


-(IBAction)listen:(id)sender {
	NSLog(@"listen");
	NSString *resFilename = @"about.wav";
	NSString *tmpPath = [[NSBundle mainBundle] pathForResource:resFilename ofType:nil];

	NSURL *audioURL = [NSURL fileURLWithPath:tmpPath];
	[self playClip:audioURL];
}


-(IBAction)record:(id)sender {
	AVAudioSession * audioSession = [AVAudioSession sharedInstance];
	//Setup the audioSession for playback and record. 
	[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
	//Activate the session
	[audioSession setActive:YES error: &error];
	
	if(recording){
		NSLog(@"Recording stopped");
		recording = NO;
		[recordButton setTitle:@"record" forState: UIControlStateNormal];
		[recorder stop];
	}
	else{
		NSLog(@"Recording started");
		recording = YES;
		[recordButton setTitle:@"stop" forState: UIControlStateNormal];
		[self startRecording];
	}
}

-(void)startRecording {
	NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
	[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; 
	[recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];

	recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];

	recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:&error];
	[recorder setDelegate:self];
	[recorder prepareToRecord];
	[recorder record];
}

-(IBAction)play:(id)sender {
	NSLog(@"play");
	[self playClip:recordedTmpFile];
}

-(void)playClip:(NSURL*)filename {
	AVAudioPlayer * myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:filename error:&error];
	[myPlayer prepareToPlay];
	[myPlayer play];
}

-(void)dealloc {
	[super dealloc];
	[recorder dealloc];
	recorder = nil;
	recordedTmpFile = nil;
}
	
@end
