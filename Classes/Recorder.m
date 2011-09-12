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
}

-(void)stop {
}

@end
