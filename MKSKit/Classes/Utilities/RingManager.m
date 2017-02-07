//
//  RingManager.m
//  MaskCall
//
//  Created by Mark on 4/20/14.
//  Copyright (c) 2014 Mark Studio. All rights reserved.
//

#import "RingManager.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface RingManager () <AVAudioPlayerDelegate>

@property (nonatomic, strong) AVAudioPlayer *ringPlayer;

#pragma mark -

- (void)initApplicationAudio;

@end

@implementation RingManager

- (void)playRing
{
    if (_strRingPath.length < 1) {
        return;
    }
    
    NSURL *urlRing = [[NSURL alloc] initFileURLWithPath:_strRingPath];
    NSError *error = nil;
    _ringPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:urlRing error:&error];
    if (error == nil) {
        [_ringPlayer prepareToPlay];
        [_ringPlayer setVolume:1.0];
        [_ringPlayer setDelegate:self];
        [_ringPlayer setNumberOfLoops:-1];      // 无限播放
        [_ringPlayer play];
    }
    
    return;
}//

- (void)shock
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    return;
}//

- (void)playSound
{
    static SystemSoundID soundID = 1;
    NSURL *urlRing = [NSURL fileURLWithPath:_strRingPath];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)urlRing, &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    return;
}//

- (void)stopRing
{
    if (_ringPlayer != nil &&
        _ringPlayer.isPlaying) {
        [_ringPlayer stop];
    }
    
    return;
}//

- (void)overrideAudioRouteSpeaker:(BOOL)isSpeaker
{
    if (isSpeaker) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback
                                         withOptions:AVAudioSessionCategoryOptionMixWithOthers
                                               error:nil];
    }
    // 听筒模式必须是PlayAndRecord
    else {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord
                                         withOptions:AVAudioSessionCategoryOptionDuckOthers
                                               error:nil];
    }
}//

#pragma mark -
#pragma mark Private Methods

- (void)initApplicationAudio
{
    [[AVAudioSession sharedInstance] setDelegate:self];
//    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategorySoloAmbient error:nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    NSError *activeError = nil;
    [[AVAudioSession sharedInstance] setActive:YES error:&activeError];
}//

#pragma mark -
#pragma mark AVAudioPlayerDelegate

@end
