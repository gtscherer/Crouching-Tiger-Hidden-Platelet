//
//  AudioPlayer.h
//  Bubblenauts
//
//  Created by Breton Goers on 3/23/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlayer : NSObject

+ (AudioPlayer*)sharedPlayer;

- (void)loadBackgroundMusicAndPlay:(NSURL*)music;
- (void)stopPlaying;
- (void)startPlaying;

@end
