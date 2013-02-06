//
//  HelloWorldLayer.m
//  blockGame
//
//  Created by SangChan Lee on 13. 2. 5..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
		[self initBackGround];
        
        _leftKey = [CCMenuItemImage itemWithNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(leftKeyPressed:)];
        [_leftKey setPosition:ccp(50,25)];
        CCMenu *leftKeyMenu = [CCMenu menuWithItems:_leftKey, nil];
        leftKeyMenu.position = CGPointZero;
        [self addChild:leftKeyMenu];
        
        _rightKey = [CCMenuItemImage itemWithNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(rightKeyPressed:)];
        [_rightKey setPosition:ccp(270,25)];
        CCMenu *rightKeyMenu = [CCMenu menuWithItems:_rightKey, nil];
        rightKeyMenu.position = CGPointZero;
        [self addChild:rightKeyMenu];
        
        _rotateKey = [CCMenuItemImage itemWithNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(rotateKeyPressed:)];
        [_rotateKey setPosition:ccp(160,25)];
        CCMenu *rotateKeyMenu = [CCMenu menuWithItems:_rotateKey, nil];
        rotateKeyMenu.position = CGPointZero;
        [self addChild:rotateKeyMenu];
        
        
        [self initBlock];
        
        [self schedule:@selector(drawBlock:) interval:1];
        
	}
	return self;
}

- (void)leftKeyPressed:(id)sender {
    NSLog(@"left!");
    [_block move:mv_left];

}

- (void)rightKeyPressed:(id)sender {
    NSLog(@"right!");
    [_block move:mv_right];
}

- (void)rotateKeyPressed:(id)sender {
    NSLog(@"rotate!");
    [_block rotate];
}

-(void) initBackGround {
    // ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    
    CCSprite *bg = [self blankSpriteWithSize:CGSizeMake(block_size*map_width, block_size*map_height)];
    [bg setColor:ccc3(255, 255, 255)];
    [bg setPosition:ccp(size.width/2, size.height/2+border_y)];
    [self addChild:bg z:-1];
}

- (void) initBlock {
    _block = [[tetromino alloc]initTetrimino:0];
    [self addChild:_block];
}

- (void) drawBlock:(ccTime)dt {
    //[_block draw];
    [_block falling];
}

- (CCSprite*)blankSpriteWithSize:(CGSize)size
{
    CCSprite *sprite = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CCTexture2D *tex = [[CCTexture2D alloc] initWithData:buffer pixelFormat:kCCTexture2DPixelFormat_RGB5A1 pixelsWide:1 pixelsHigh:1 contentSize:size];
    [sprite setTexture:tex];
    [sprite setTextureRect:CGRectMake(0, 0, size.width, size.height)];
    //[sprite setAnchorPoint:CGPointZero];
    free(buffer);
    return sprite;
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
