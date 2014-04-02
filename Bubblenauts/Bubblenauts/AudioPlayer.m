//
//  AudioPlayer.m
//  Bubblenauts
//
//  Created by Breton Goers on 3/23/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

#import "AudioPlayer.h"
@import AVFoundation;

@interface AudioPlayer()
@property (nonatomic, strong) AVAudioPlayer *player;
@end

@implementation AudioPlayer

+ (AudioPlayer *)sharedPlayer {
    static dispatch_once_t pred;
    static AudioPlayer *shared = nil;
    
    dispatch_once(&pred, ^{
        shared = [[AudioPlayer alloc] init];
    });
    
    return shared;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadBackgroundMusicAndPlay:(NSURL *)music {
    if ([self.player.url isEqual:music]) return;
    
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:music error:&error];
    self.player.numberOfLoops = -1;
    [self.player prepareToPlay];
    
    if (![self playerMuted]) {
        [self startPlaying];
    }
}

- (void)stopPlaying {
    [self.player pause];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:YES forKey:@"MUTED"];
    [def synchronize];
}

- (void)startPlaying {
    [self.player play];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:NO forKey:@"MUTED"];
    [def synchronize];
}

- (BOOL)playerMuted {
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    BOOL muteStatus = [def boolForKey:@"MUTED"];
    return muteStatus;
}

@end
