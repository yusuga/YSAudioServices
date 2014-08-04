//
//  YSAudioServices.m
//  YSAudioServicesExample
//
//  Created by Yu Sugawara on 2014/08/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "YSAudioServices.h"
@import AudioToolbox;

@interface YSAudioServices ()

@property (nonatomic) NSMutableDictionary *sounds;

@end

@implementation YSAudioServices

- (instancetype)init
{
    if (self = [super init]) {
        self.sounds = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)dealloc
{
    for (NSNumber *idNum in [self.sounds allValues]) {
        AudioServicesDisposeSystemSoundID(idNum.unsignedIntValue);
    }
}

-(void)addSoundEffect:(NSUInteger)soundNumber url:(NSURL*)url
{
    SystemSoundID soundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &soundID);
    [self.sounds setObject:[NSNumber numberWithUnsignedLong:soundID]
                    forKey:[NSString stringWithFormat:@"%zd",soundNumber]];
}

-(void)playSoundEffect:(NSUInteger)soundNumber
{
    NSNumber *idNum = [self.sounds objectForKey:[NSString stringWithFormat:@"%zd",soundNumber]];
    if (idNum) {
        AudioServicesPlaySystemSound(idNum.unsignedIntValue);
    }
}

@end
