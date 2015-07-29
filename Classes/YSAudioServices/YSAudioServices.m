//
//  YSAudioServices.m
//  YSAudioServicesExample
//
//  Created by Yu Sugawara on 2014/08/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "YSAudioServices.h"
@import AudioToolbox;

static BOOL __disabled;

static inline SystemSoundID SystemSoundIDFromNSNumber(NSNumber *number) {
#if __LP64__
    return [number unsignedIntValue];
#else
    return [number unsignedLongValue];
#endif
}

static inline void ys_dispatch_main_sync_safe(void(^block)(void))
{
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
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
    ys_dispatch_main_sync_safe(^{
        SystemSoundID systemSoundID;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &systemSoundID);
        [self.sounds setObject:@(systemSoundID)
                        forKey:[NSString stringWithFormat:@"%zd", soundID]];
    });
}

- (void)playSoundEffect:(NSInteger)soundID
{
    ys_dispatch_main_sync_safe(^{
        if (__disabled) return ;
        
        NSNumber *systemSoundIDNum = [self.sounds objectForKey:[NSString stringWithFormat:@"%zd", soundID]];
        if (systemSoundIDNum) {
            AudioServicesPlaySystemSound(SystemSoundIDFromNSNumber(systemSoundIDNum));
        }
    });
}

+ (void)setDisabled:(BOOL)disabled
{
    __disabled = disabled;
}

+ (BOOL)disabled
{
    return __disabled;
}

@end
