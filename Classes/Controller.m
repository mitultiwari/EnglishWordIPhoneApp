#include<stdlib.h>

#import "Controller.h"

@implementation Controller

-(id)init {
	if (self = [super init]) {
		recorder = [[Recorder alloc] init];
		[self newWord:nil];
	}
	return self;
}

-(IBAction)newWord:(id)sender {
	currWord = [[NSArray arrayWithObjects:words count:10] objectAtIndex:arc4random()%10];
	NSLog(@"new word %@", currWord);
	[self listen:nil];
	NSLog(@"display %@", display);
	[display setText:currWord];
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
		[recorder start];
	}
}

-(IBAction)play:(id)sender {
	NSLog(@"play");
	[self playClip:recorder.recordedFile];
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
}

@end
