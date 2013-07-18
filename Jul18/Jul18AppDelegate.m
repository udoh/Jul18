//
//  Jul18AppDelegate.m
//  Jul18
//
//  Created by Udo Hoppenworth on 7/18/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import "Jul18AppDelegate.h"
#import "View.h"

@implementation Jul18AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    
    // setup file paths and urls
    NSBundle *bundle = [NSBundle mainBundle];
    if (!bundle) {
        NSLog(@"could not load main bundle!");
        return YES;
    }
    
    NSString *movieFileName = [bundle pathForResource:@"easy3" ofType:@"mp4"];
    if (!movieFileName) {
        NSLog(@"could not find file easy.mp4");
        return YES;
    }
    
    NSURL *movieUrl = [NSURL fileURLWithPath:movieFileName];
    if (!movieUrl) {
        NSLog(@"could not create url for file %@", movieFileName);
        return YES;
    }
    
    _movieController = [[MPMoviePlayerController alloc] init];
    if (!_movieController) {
        NSLog(@"could not create MPMoviePlayerController");
        return YES;
    }
    
    NSString *soundFileName = [bundle pathForResource: @"birds" ofType: @"mp3"];
    if (!soundFileName) {
        NSLog(@"could not load sound file");
        return YES;
    }
    
	NSURL *soundUrl = [NSURL fileURLWithPath: soundFileName];
    if (!soundUrl) {
        NSLog(@"could not create url for file %@", soundFileName);
        return YES;
    }
    
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundUrl, &_sid);
	if (error != kAudioServicesNoError) {
		NSLog(@"AudioServicesCreateSystemSoundID error == %ld", error);
	}
    
    NSString *musicFileName = [bundle pathForResource:@"music" ofType:@"wav"];
    if (!musicFileName) {
        NSLog(@"could not find file music.wav");
        return YES;
    }
    
    NSURL *musicUrl = [NSURL fileURLWithPath:musicFileName];
    if (!musicUrl) {
        NSLog(@"could not create url for file %@", musicFileName);
        return YES;
    }
    
    
    // movie controller
    _movieController.shouldAutoplay = NO;
    _movieController.scalingMode = MPMovieScalingModeNone;
    _movieController.controlStyle = MPMovieControlStyleFullscreen;
    _movieController.movieSourceType = MPMovieSourceTypeFile;
    [_movieController setContentURL:movieUrl];
    
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	
	[nc addObserver:self selector:@selector(playbackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object: _movieController];
    
    
    NSError *avError = nil;
	_player = [[AVAudioPlayer alloc] initWithContentsOfURL: musicUrl error: &avError];
	if (!_player) {
		NSLog(@"could not initialize player:  %@", avError);
		return YES;
	}
    
    
    // audio player (switch)
    _player.volume = 1.0;
	_player.numberOfLoops = 0;
	_player.delegate = self;
    
    if (![_player prepareToPlay]) {
		NSLog(@"prepareToPlay failed");
		return YES;
	}
    
    
    UIScreen *screen = [UIScreen mainScreen];
	_view = [[View alloc] initWithFrame: screen.applicationFrame];
	self.window = [[UIWindow alloc] initWithFrame: screen.bounds];
	//self.window.backgroundColor = [UIColor whiteColor];
    
	[self.window addSubview: _view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void) playbackDidFinish: (NSNotification *) notification {
	//notification.object is the movie player controller.
	[_movieController.view removeFromSuperview];
	[UIApplication sharedApplication].statusBarHidden = NO;
	[self.window addSubview: _view];
}

- (void) playMovie: (id) sender {

	_movieController.view.frame = _view.frame;
	[_view removeFromSuperview];
	[self.window addSubview: _movieController.view];
	[_movieController play];
}

- (void) playSound: (id) sender {

	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	AudioServicesPlaySystemSound(_sid);
}

- (void) valueChanged: (id) sender {
	UISwitch *s = sender;
	if (s.isOn) {

		if (![_player play]) {
			NSLog(@"[player play] failed.");
		}
		NSLog(@"Playing at %g of %g seconds.", _player.currentTime, _player.duration);
	} else {

		NSLog(@"Paused at %g of %g seconds.", _player.currentTime, _player.duration);
		[_player pause];
        
		if (![_player prepareToPlay]) {
			NSLog(@"prepareToPlay failed");
		}
        
	}
}

- (void) audioPlayerDidFinishPlaying: (AVAudioPlayer *) p successfully: (BOOL) flag {
	if (p == _player) {
		[_view.mySwitch setOn: NO animated: YES];
	}
}


@end
