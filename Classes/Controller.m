#include<stdlib.h>

#import "Controller.h"

@implementation Controller

-(id)init {
    if (self = [super init]) {
		recorder2 = [[Recorder alloc] init];
        [self newWord:nil];
        AVAudioSession * audioSession = [AVAudioSession sharedInstance];
        //Setup the audioSession for playback and record.
        [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: &error];
        //Activate the session
        [audioSession setActive:YES error: &error];
    }
    return self;
}

-(IBAction)newWord:(id)sender {
    NSLog(@"%@", self);
    currWord = [[NSArray arrayWithObjects:words count:10] objectAtIndex:arc4random()%10];
    NSLog(@"new word %@", currWord);
    NSLog(@"display %@", display);
    [display setText:currWord];
    [self listen:nil];
}

-(IBAction)listen:(id)sender {
    NSLog(@"listen: %@", currWord);
    NSString *resFilename = [currWord stringByAppendingString:@".wav"];
    NSString *tmpPath = [[NSBundle mainBundle] pathForResource:resFilename ofType:nil];
    NSURL *audioURL = [NSURL fileURLWithPath:tmpPath];
    [self playClip:audioURL];
}


-(IBAction)record:(id)sender {
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
	[recorder2 dealloc];
    recordedTmpFile = nil;
}

@end
