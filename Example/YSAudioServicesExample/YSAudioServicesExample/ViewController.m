//
//  ViewController.m
//  YSAudioServicesExample
//
//  Created by Yu Sugawara on 2014/08/04.
//  Copyright (c) 2014年 Yu Sugawara. All rights reserved.
//

#import "ViewController.h"
#import "YSAudioServices.h"

typedef NS_ENUM(NSUInteger, Sound) {
    SoundCoin,
    SoundJump,
};

@interface ViewController ()

@property (nonatomic) YSAudioServices *soundManager;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.soundManager = [[YSAudioServices alloc] init];
    
    [self.soundManager addSoundEffect:SoundCoin
                                  url:[[NSBundle mainBundle] URLForResource:@"coin"
                                                              withExtension:@"wav"]];
    
    [self.soundManager addSoundEffect:SoundJump
                                  url:[[NSBundle mainBundle] URLForResource:@"jump"
                                                              withExtension:@"wav"]];
}

- (IBAction)coinButtonDidPush:(id)sender
{
    [self.soundManager playSoundEffect:SoundCoin];
}

- (IBAction)jumpButtonDidPush:(id)sender
{
    [self.soundManager playSoundEffect:SoundJump];
}

@end
