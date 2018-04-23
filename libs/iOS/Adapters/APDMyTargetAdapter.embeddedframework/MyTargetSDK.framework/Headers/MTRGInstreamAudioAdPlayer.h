//
//  MTRGInstreamAudioAdPlayer.h
//  myTargetSDK 4.6.22
//
//  Created by Andrey Seredkin on 20.12.16.
//  Copyright © 2016 Mail.ru Group. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTRGInstreamAudioAdPlayerDelegate <NSObject>

- (void)onAdAudioStart;

- (void)onAdAudioPause;

- (void)onAdAudioResume;

- (void)onAdAudioStop;

- (void)onAdAudioErrorWithReason:(NSString *)reason;

- (void)onAdAudioComplete;

@end

@protocol MTRGInstreamAudioAdPlayer <NSObject>

@property(nonatomic, readonly) NSTimeInterval adAudioDuration;
@property(nonatomic, readonly) NSTimeInterval adAudioTimeElapsed;
@property(nonatomic, weak, nullable) id <MTRGInstreamAudioAdPlayerDelegate> adPlayerDelegate;
@property(nonatomic) float volume;

- (void)playAdAudioWithUrl:(NSURL *)url;

- (void)pauseAdAudio;

- (void)resumeAdAudio;

- (void)stopAdAudio;

@end

NS_ASSUME_NONNULL_END
