//
//  Recorder.h
//  TalkEnglishWalkEnglish
//
//  Created by Kartik Agaram on 9/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioRecorder.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <CoreAudio/CoreAudioTypes.h>

@interface Recorder : NSObject <AVAudioRecorderDelegate> {
    NSURL *recordedFile;
    AVAudioRecorder *recorder;
    NSError *error;
}

-(void)start;
-(void)stop;

@property (retain) NSURL *recordedFile;

@end
