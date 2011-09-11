//
//  Controller.m
//  ButtonTest
//
//  Created by Mitul Tiwari on 9/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Controller.h"

@implementation Controller

@synthesize avPlayer;



-(IBAction)listen:(id)sender {
	NSLog(@"listen");
	NSString *resFilename = @"about.wav";
	NSString *tmpPath = [[NSBundle mainBundle] pathForResource:resFilename ofType:nil];
	
	NSURL *audioURL = [NSURL fileURLWithPath:tmpPath];
	AVAudioPlayer *avPlayerObj = [AVAudioPlayer alloc];
	self.avPlayer = [avPlayerObj initWithContentsOfURL:audioURL error:nil];
	[avPlayer play];
	
}



-(IBAction)record:(id)sender {
	NSLog(@"record");
	NSLog(@"toggle: %d", recording);
	
	AVAudioSession * audioSession = [AVAudioSession sharedInstance];
	//Setup the audioSession for playback and record. 
	[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
	//Activate the session
	[audioSession setActive:YES error: &error];
	
	if(recording){
		recording = NO;
		NSLog(@"Used File called: %@",recordedTmpFile);
		[recorder stop];
	}
	else{
		recording = YES;
		
		NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
		[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
		[recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey]; 
		[recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
		
		recordedTmpFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];
		NSLog(@"Using File called: %@",recordedTmpFile);
		
		recorder = [[ AVAudioRecorder alloc] initWithURL:recordedTmpFile settings:recordSetting error:&error];
		[recorder setDelegate:self];
		[recorder prepareToRecord];
		[recorder record];
		NSLog(@"Recording");
	}
}


-(IBAction)play:(id)sender {
	NSLog(@"play");
	AVAudioPlayer * myPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:recordedTmpFile error:&error];
	[myPlayer prepareToPlay];
	[myPlayer play];
}

-(void)dealloc {
	[super dealloc];
	[avPlayer release];
	[recorder dealloc];
	recorder = nil;
	recordedTmpFile = nil;
}
	
@end
