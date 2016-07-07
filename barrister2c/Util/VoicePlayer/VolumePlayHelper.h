//
//  VolumePlayHelper.h
//  UTT
//
//  Created by SunGuozhi on 14-4-22.
//  Copyright (c) 2014年 xu. All rights reserved.
//

/*
 VolumePlayHelper 限制只能播放一条语音，recordPlay: 为类的入口函数，
    如果获得的fileName是与上次获取的fileName相同，则调用stop方法，将之前播放的内容从audios队列数组中移除，然后再次加入之前的内容到数组中
    否之为暂停前一条语音，将即将播放的语音文件名加入audios队列数组之中。
 */
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VolumePlayHelper : NSObject<AVAudioPlayerDelegate,AVAudioRecorderDelegate>
@property (nonatomic,retain) AVAudioPlayer *audioPlayer;
@property (nonatomic,retain) NSMutableArray * audios;   //录音的队列，每次队列只保存当前播放的内容
@property (nonatomic,retain) NSString *currentFileName;
@property (assign) BOOL isPlaying;

+ (VolumePlayHelper *)PlayerHelper;
-(void)recordPlay:(NSString*)fileName;
- (void)playSound:(NSString *)fileName;
- (void)audioPlayerStop;
@end
