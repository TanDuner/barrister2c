//
//  VolumePlayHelper.m
//  UTT
//
//  Created by SunGuozhi on 14-4-22.
//  Copyright (c) 2014年 xu. All rights reserved.
//

#import "VolumePlayHelper.h"

@implementation VolumePlayHelper
@synthesize audioPlayer = _audioPlayer;
@synthesize audios = _audios;
static VolumePlayHelper * instance;
+ (VolumePlayHelper *)PlayerHelper{
    if (!instance) {
        instance = [[VolumePlayHelper alloc] init];
        [instance initPlayer];
        instance.audios = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return instance;
}

- (void)dealloc{
    [self release];
    [_audioPlayer release];
    [super dealloc];
}


-(void)initPlayer{
    //初始化播放器的时候如下设置
//    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    extern OSStatus AudioSessionInitialize(CFRunLoopRef inRunLoop,
                                           CFStringRef inRunLoopMode,
                                           AudioSessionInterruptionListener inInterruptionListener,
                                           void *inClientData);
    
//    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
//    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
//                             sizeof (audioRouteOverride),
//                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}


-(void)recordPlay:(NSString*)fileName{
    NSError *error=nil;
    
    [_audioPlayer stop];
    [_audioPlayer release];
    
    [self initPlayer];

    [[NSUserDefaults standardUserDefaults] setObject:fileName forKey:@"currentFileName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PLAY_VOICE object:fileName userInfo:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:fileName];
    _audioPlayer = [[AVAudioPlayer alloc] initWithData:data error:&error];
    _isPlaying = YES;
    if (error) {
        error=nil;
    }
    [_audioPlayer setVolume:1];
    [_audioPlayer prepareToPlay];
    [_audioPlayer setDelegate:self];
    [_audioPlayer play];
}


- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    _isPlaying = NO;
    [_audios removeAllObjects];
    
    NSString *currentFileNameTemp = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentFileName"];
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PLAY_VOICE_FINISH object:nil userInfo:@{@"currentFileName": currentFileNameTemp}];
    [[NSUserDefaults standardUserDefaults] setObject:@"xxx" forKey:@"currentFileName"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

- (void)audioPlayerStop{
    [_audios removeAllObjects];
    [_audioPlayer stop];
    _isPlaying = NO;
}

- (void)playSound:(NSString *)fileName{
    if (_audios.count > 0)
    {
        [_audioPlayer stop];
        _isPlaying = NO;
        if (![_audios[0] isEqualToString:fileName]){
            [self recordPlay:fileName];
            [_audios addObject:fileName];
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"xxx" forKey:@"currentFileName"];
            [[NSUserDefaults standardUserDefaults] synchronize];
             [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_PLAY_VOICE object:@"xxx" userInfo:nil];
        }
        [_audios removeObjectAtIndex:0];
    }
    else
    {
        [self recordPlay:fileName];
        [_audios addObject:fileName];
    }
}


@end