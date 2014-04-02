//
//  MyScene.m
//  Bubblenauts
//
//  Created by Breton Goers on 1/14/14.
//  Copyright (c) 2014 Corvus. All rights reserved.
//

// Framework
#import "MyScene.h"
#import "IntroScene.h"
#import "EntityManager.h"
#import "EntityFactory.h"
#import "Entity.h"
#import "AudioPlayer.h"
#import "GameCenterManager.h"

// Systems
#import "VelocitySystem.h"
#import "CleanupSystem.h"
#import "ForceSystem.h"
#import "ScrollSystem.h"
#import "FreeMoveSystem.h"
#import "FollowSystem.h"
#import "CollisionSystem.h"
#import "HealthSystem.h"
#import "ShootSystem.h"

// Components
#import "FreeMoveComponent.h"
#import "ForceComponent.h"

#define kGestureThreshold 5.0f
#define kScoreHudName @"ScoreHUD"

@interface MyScene() {
    CGSize scrnSz;
    NSTimeInterval lastTime;
    CGFloat gestureStart;
    NSUInteger score;
    NSUInteger spawnTime;
    BOOL gameStop;
    
    EntityManager *m_EntityManager;
    EntityFactory *m_EntFactory;
    
    VelocitySystem *m_VelocitySys;
    CleanupSystem *m_CleanupSys;
    ForceSystem *m_ForceSys;
    ScrollSystem *m_ScrollSys;
    FreeMoveSystem *m_MoveSys;
    CollisionSystem *m_CollSys;
    FollowSystem *m_FollowSys;
    HealthSystem *m_HealthSys;
    ShootSystem *m_ShootSys;
    
    Entity *hero;
}

@property (strong) UITapGestureRecognizer *tripleTap;

@end

@implementation MyScene

-(id)initWithSize:(CGSize)size {
    self = [super initWithSize:size];
    if (self) {
        scrnSz = [[UIScreen mainScreen] bounds].size;
        
        m_EntityManager = [[EntityManager alloc] init];
        m_EntFactory    = [[EntityFactory alloc] initWithEntityManager:m_EntityManager nodeParent:self];
        
        m_VelocitySys   = [[VelocitySystem alloc] initWithEntityManager:m_EntityManager];
        m_CleanupSys    = [[CleanupSystem alloc] initWithEntityManager:m_EntityManager];
        m_ForceSys      = [[ForceSystem alloc] initWithEntityManager:m_EntityManager];
        m_ScrollSys     = [[ScrollSystem alloc] initWithEntityManager:m_EntityManager];
        m_MoveSys       = [[FreeMoveSystem alloc] initWithEntityManager:m_EntityManager];
        m_FollowSys     = [[FollowSystem alloc] initWithEntityManager:m_EntityManager];
        m_CollSys       = [[CollisionSystem alloc] initWithEntityManager:m_EntityManager];
        m_HealthSys     = [[HealthSystem alloc] initWithEntityManager:m_EntityManager];
        m_ShootSys      = [[ShootSystem alloc] initWithEntityManager:m_EntityManager];
        
//        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
//        SKSpriteNode *bg2 = [SKSpriteNode spriteNodeWithImageNamed:@"Space"];
//        bg.position = ccp(scrnSz.width/2, scrnSz.height/2);
//        bg2.position = ccp(scrnSz.width/2, scrnSz.height/2 + scrnSz.height);
//        [self addChild:bg];
        [m_EntFactory scrollingBackgroundAtPoint:ccp(scrnSz.width/2, scrnSz.height/2)];
        [m_EntFactory scrollingBackgroundAtPoint:ccp(scrnSz.width/2, scrnSz.height/2 + scrnSz.height)];
        
        CGPoint start = ccp(scrnSz.width/2, scrnSz.height/3);
        hero = [m_EntFactory createHeroAtPoint:start];
        
        m_CollSys.toCheck = hero;
        m_CollSys.heroRef = hero;
        m_ShootSys.factory = m_EntFactory;
        
        start = ccp(scrnSz.width/2, scrnSz.height/8);
        [m_EntFactory scrollingBubbleAtPoint:start];
        
        spawnTime = 0;
        gestureStart = 0.0f;
        score = 0.0f;
        gameStop = FALSE;
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"NasalizationRg-Regular"];
        scoreLabel.name = kScoreHudName;
        scoreLabel.fontSize = 20.0f;
        scoreLabel.fontColor = [SKColor whiteColor];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %lu", (unsigned long)score];
        scoreLabel.position = ccp(scrnSz.width/2, scrnSz.height-(20+scoreLabel.frame.size.height/2));
        scoreLabel.zPosition = 999;
        [self addChild:scoreLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(gameOverOccurred) name:GameOverCondition object:nil];
        
        NSURL *backgroundMusicURL = [[NSBundle mainBundle] URLForResource:@"Bubblenautsplay" withExtension:@"mp3"];
        AudioPlayer *player = [AudioPlayer sharedPlayer];
        [player loadBackgroundMusicAndPlay:backgroundMusicURL];
        
        [self setBlank:[[PCGEntity alloc] initWithSymbol:'L' andFrequency:15]];
        [self setBubble:[[PCGEntity alloc] initWithSymbol:'B' andFrequency:8]];
        [self setAsteroid:[[PCGEntity alloc] initWithSymbol:'A' andFrequency:6]];
        [self setFan:[[PCGEntity alloc]initWithSymbol:'F' andFrequency:4]];

        [self setDistribution: [[PCGDistribution alloc] init]];
        [[self distribution] addEntity:[self blank]];
        [[self distribution] addEntity:[self bubble]];
        [[self distribution] addEntity:[self asteroid]];
        [[self distribution] addEntity:[self fan]];
        [self setLineGenerator:[[PCGLineGenerator alloc] init]];
        [[self lineGenerator] setBlank:[self blank]];
        
        [[self lineGenerator] setWidth:50];
        [[self lineGenerator] setScreenWidth:[[UIScreen mainScreen] bounds].size.width];
        [[self lineGenerator] setGlobalDistribution:[self distribution]];
        
    }
    return self;
}

- (void)didMoveToView:(SKView *)view {
    [self addGestureRecognizer];
}

- (void)addGestureRecognizer {
    self.tripleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTripleTap:)];
    self.tripleTap.numberOfTapsRequired = 3;
    [self.view addGestureRecognizer:self.tripleTap];
}

- (void)removeGestureRecognizer {
    [self.view removeGestureRecognizer:self.tripleTap];
    self.tripleTap = nil;
}

- (void)handleTripleTap:(UIGestureRecognizer*)gesture {
    gameStop = TRUE;
    [self removeGestureRecognizer];
    [self addGameStoppedUIWithResume:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    gestureStart = [[touches anyObject] locationInNode:self].x;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGFloat curX = [[touches anyObject] locationInNode:self].x;
    CGFloat dX = curX - gestureStart;
    
    if (fabsf(dX) > kGestureThreshold) {
        CGPoint force = ccpMult((CGPoint){2, 0}, dX);
        ForceComponent *forceC = [[ForceComponent alloc] initWithForce:force];
        [m_EntityManager addComponent:forceC toEntity:hero];
        return;
    }
}

- (void)createItem:(PCGEntity*) item atPoint:(CGPoint) point
{
    Entity* ent;
    if ([item symbol] == 'B')
    {
        ent = [m_EntFactory scrollingBubbleAtPoint:point];
    }
    else if([item symbol] == 'F')
    {
        ent = [m_EntFactory scrollingForceShooterAtPoint:point];
    }
    else if([item symbol] == 'A')
    {
        ent = [m_EntFactory scrollingAsteroidAtPoint:point];
    }
    
}

-(void)update:(CFTimeInterval)currentTime {
    if (gameStop) return;
    
    // Handle time delta.
    CFTimeInterval dt = currentTime - lastTime;
    if (dt > 1) dt = 1.0 / 60.0;
    lastTime = currentTime;
    spawnTime++;

    FreeMoveComponent *move = (FreeMoveComponent*)[hero getComponentOfClass:[FreeMoveComponent class]];
    m_ScrollSys.active = move.goodToScroll;
    m_ShootSys.active = move.goodToScroll;
    
    if (m_ScrollSys.active) {
        score += 3;
        SKLabelNode *scoreLabel = (SKLabelNode*)[self childNodeWithName:kScoreHudName];
        scoreLabel.text = [NSString stringWithFormat:@"Score: %lu", (unsigned long)score];
        
        if (spawnTime >= 23) {
            // Insert code here, Gregg
            NSArray* line = [[self lineGenerator] generateLine];
            for(NSInteger i = 0; i < [line count]; ++i)
            {
                CGPoint point;
                point.x = ([[self lineGenerator] width] * i) + [[self lineGenerator] width];
                point.y = scrnSz.height + 50;
                [self createItem:[line objectAtIndex:i] atPoint:point];
            }
            spawnTime = 0;
        }
    }
    
    [m_MoveSys update:dt];
    [m_ForceSys update:dt];
    [m_FollowSys update:dt];
    [m_ScrollSys update:dt];
    [m_ShootSys update:dt];
    [m_CollSys update:dt];
    [m_HealthSys update:dt];
    [m_VelocitySys update:dt];
    [m_CleanupSys update:dt];
}

- (void)gameOverOccurred {
    gameStop = TRUE;
    
    [self removeGestureRecognizer];
    NSString *lID = @"BubblenautsHighScores";
    [[GameCenterManager sharedManager] saveAndReportScore:(int)score leaderboard:lID sortOrder:GameCenterSortOrderHighToLow];
    [self addGameStoppedUIWithResume:NO];
}

- (void)addGameStoppedUIWithResume:(BOOL)addResume {
    UIView *flashView = [[UIView alloc] initWithFrame:self.view.frame];
    flashView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15];
    flashView.alpha = 0.0;
    flashView.tag = 100;
    [self.view addSubview:flashView];
    
    CGPoint center = flashView.center;
    
    if (addResume) {
        UIButton *resumeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [resumeBtn setFrame:(CGRect){0, 0, 100, 50}];
        [resumeBtn setCenter:center];
        [resumeBtn setTitle:@"Resume" forState:UIControlStateNormal];
        [[resumeBtn titleLabel] setFont:[UIFont fontWithName:@"NasalizationRg-Regular" size:20.0f]];
        [resumeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [resumeBtn addTarget:self action:@selector(resumeGame) forControlEvents:UIControlEventTouchUpInside];
        [flashView addSubview:resumeBtn];
        center.y += 50;
    }
    
    UIButton *restartBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [restartBtn setFrame:(CGRect){0, 0, 100, 50}];
    [restartBtn setCenter:center];
    [restartBtn setTitle:@"Restart" forState:UIControlStateNormal];
    [[restartBtn titleLabel] setFont:[UIFont fontWithName:@"NasalizationRg-Regular" size:20.0f]];
    [restartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [restartBtn addTarget:self action:@selector(restartGame) forControlEvents:UIControlEventTouchUpInside];
    [flashView addSubview:restartBtn];
    center.y += 50;
    
    UIButton *quitButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [quitButton setFrame:(CGRect){0, 0, 100, 50}];
    [quitButton setCenter:center];
    [quitButton setTitle:@"Quit" forState:UIControlStateNormal];
    [[quitButton titleLabel] setFont:[UIFont fontWithName:@"NasalizationRg-Regular" size:20.0f]];
    [quitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [quitButton addTarget:self action:@selector(quitGame) forControlEvents:UIControlEventTouchUpInside];
    [flashView addSubview:quitButton];
    
    [UIView animateWithDuration:0.25 animations:^{
        flashView.alpha = 1.0;
    }];
}

- (void)resumeGame {
    [UIView animateWithDuration:1.0 animations:^{
        [[self.view viewWithTag:100] setAlpha:0.0];
    } completion:^(BOOL finished) {
        [[self.view viewWithTag:100] removeFromSuperview];
        gameStop = FALSE;
    }];
}

- (void)restartGame {
    [UIView animateWithDuration:0.25 animations:^{
        [[self.view viewWithTag:100] setAlpha:0.0];
    } completion:^(BOOL finished) {
        [[self.view viewWithTag:100] removeFromSuperview];
        
        SKTransition *restart = [SKTransition fadeWithDuration:0.5];
        MyScene *newScene = [[MyScene alloc] initWithSize:self.size];
        [self.view presentScene:newScene transition:restart];
    }];
}

- (void)quitGame {
    [UIView animateWithDuration:0.25 animations:^{
        [[self.view viewWithTag:100] setAlpha:0.0];
    } completion:^(BOOL finished) {
        [[self.view viewWithTag:100] removeFromSuperview];
        
        SKTransition *quit = [SKTransition fadeWithDuration:1.0];
        IntroScene *introScene = [[IntroScene alloc] initWithSize:self.size];
        [self.view presentScene:introScene transition:quit];
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
