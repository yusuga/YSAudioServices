//
//  YSAudioServices.h
//  YSAudioServicesExample
//
//  Created by Yu Sugawara on 2014/08/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YSAudioServices : NSObject

- (void)addSoundEffect:(NSInteger)soundID
                   url:(NSURL*)url;
- (void)playSoundEffect:(NSInteger)soundID;

+ (void)setDisabled:(BOOL)disabled;
+ (BOOL)disabled;

@end
