#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioRecorder.h>
#import <AVFoundation/AVAudioPlayer.h>
#import <CoreAudio/CoreAudioTypes.h>

#import "Recorder.h"

static const NSString *words[] = {@"about", @"baby", @"character", @"children", @"decimal", @"dictionary", @"doctor", @"pronunciation", @"salmagundi", @"wednesday", nil};

@interface Controller : NSObject <AVAudioRecorderDelegate> {
	NSString *currWord;
	Recorder *recorder;
	NSError *error;
	BOOL recording; // NO => not recording; YES: recording
	IBOutlet UIButton *recordButton;
	IBOutlet UITextView *display;
}

-(IBAction)newWord:(id)sender;
-(IBAction)record:(id)sender;
-(IBAction)play:(id)sender;
-(IBAction)listen:(id)sender;

-(void)playClip:(NSURL*)filename;

@end
