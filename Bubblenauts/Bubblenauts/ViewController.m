//
//  ViewController.m
//  buublenautsmenu
//
//  Created by kahayes3 on 1/28/14.
//  Copyright (c) 2014 kahayes3. All rights reserved.
//

#import "ViewController.h"
#import "IntroScene.h"
#import "GameCenterManager.h"

@interface ViewController () <GameCenterManagerDelegate>
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showScoreboard) name:@"SHOW_SCOREBOARD" object:nil];
    [[GameCenterManager sharedManager] setDelegate:self];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [IntroScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}

- (void)showScoreboard {
    [[GameCenterManager sharedManager] presentLeaderboardsOnViewController:self];
}

- (void)gameCenterManager:(GameCenterManager *)manager authenticateUser:(UIViewController *)gameCenterLoginController {
    [self presentViewController:gameCenterLoginController animated:YES completion:^{
        NSLog(@"Finished Presenting Authentication Controller");
    }];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
