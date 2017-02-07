//
//  RingManager.h
//  MaskCall
//
//  Created by Mark on 4/20/14.
//  Copyright (c) 2014 Mark Studio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RingManager : NSObject

@property (nonatomic, strong) NSString *strRingPath;   // ring file path

#pragma mark -
#pragma mark Custom Methods

- (void)playRing;
- (void)shock;
- (void)playSound;
- (void)stopRing;
- (void)overrideAudioRouteSpeaker:(BOOL)isSpeaker;

@end
