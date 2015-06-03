//
//  YSAudioServices.m
//  YSAudioServicesExample
//
//  Created by Yu Sugawara on 2014/08/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "YSAudioServices.h"
@import AudioToolbox;

static inline SystemSoundID SystemSoundIDFromNSNumber(NSNumber *number) {
#if __LP64__
    return [number unsignedIntValue];
#else
    return [number unsignedLongValue];
#endif
}

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
    for (NSNumber *systemSoundIDNum in [self.sounds allValues]) {
        AudioServicesDisposeSystemSoundID(SystemSoundIDFromNSNumber(systemSoundIDNum));
    }
}

- (void)addSoundEffect:(NSInteger)soundID
                   url:(NSURL *)url
{
    SystemSoundID systemSoundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &systemSoundID);
    [self.sounds setObject:@(systemSoundID)
                    forKey:[NSString stringWithFormat:@"%zd", soundID]];
}

- (void)playSoundEffect:(NSInteger)soundID
{
    NSNumber *systemSoundIDNum = [self.sounds objectForKey:[NSString stringWithFormat:@"%zd", soundID]];
    if (systemSoundIDNum) {
        AudioServicesPlaySystemSound(SystemSoundIDFromNSNumber(systemSoundIDNum));
    }
}

@end
