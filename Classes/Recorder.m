//
//  Recorder.m
//  TalkEnglishWalkEnglish
//
//  Created by Kartik Agaram on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Recorder.h"

@implementation Recorder

@synthesize recordedFile;

-(id)init {
	if (self = [super init]) {
		AVAudioSession * audioSession = [AVAudioSession sharedInstance];
		//Setup the audioSession for playback and record.
		[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
		//Activate the session
		[audioSession setActive:YES error: &error];
	}
	return self;
}

-(void)start {
	NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
	[recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
	[recordSetting setValue:[NSNumber numberWithFloat:44100.0] forKey:AVSampleRateKey];
	[recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
	
	recordedFile = [NSURL fileURLWithPath:[NSTemporaryDirectory() stringByAppendingPathComponent: [NSString stringWithFormat: @"%.0f.%@", [NSDate timeIntervalSinceReferenceDate] * 1000.0, @"caf"]]];

	recorder = [[ AVAudioRecorder alloc] initWithURL:recordedFile settings:recordSetting error:&error];
	[recorder setDelegate:self];
	[recorder prepareToRecord];
	[recorder record];
}

-(void)stop {
	[recorder stop];
}

- (void)dealloc {
	[recorder dealloc];
	recorder = nil;
	recordedFile = nil;
	[super dealloc];
}

@end
