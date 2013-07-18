//
//  Jul18AppDelegate.h
//  Jul18
//
//  Created by Udo Hoppenworth on 7/18/13.
//  Copyright (c) 2013 Udo Hoppenworth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioPlayer.h>

@class View;

@interface Jul18AppDelegate: UIResponder <UIApplicationDelegate, AVAudioPlayerDelegate> {
    
	MPMoviePlayerController *_movieController;
	View *_view;
	UIWindow *_window;
    SystemSoundID _sid;
    AVAudioPlayer *_player;
}

@property (strong, nonatomic) UIWindow *window;
@end