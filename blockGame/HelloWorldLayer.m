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
		_leftKey = [CCMenuItemImage itemWithNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(leftKeyPressed:)];
        [_leftKey setPosition:ccp(50,50)];
        CCMenu *leftKeyMenu = [CCMenu menuWithItems:_leftKey, nil];
        leftKeyMenu.position = CGPointZero;
        [self addChild:leftKeyMenu];
        
        _rightKey = [CCMenuItemImage itemWithNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(rightKeyPressed:)];
        [_rightKey setPosition:ccp(270,50)];
        CCMenu *rightKeyMenu = [CCMenu menuWithItems:_rightKey, nil];
        rightKeyMenu.position = CGPointZero;
        [self addChild:rightKeyMenu];
        
        _rotateKey = [CCMenuItemImage itemWithNormalImage:@"r1.png" selectedImage:@"r2.png" target:self selector:@selector(rotateKeyPressed:)];
        [_rotateKey setPosition:ccp(160,50)];
        CCMenu *rotateKeyMenu = [CCMenu menuWithItems:_rotateKey, nil];
        rotateKeyMenu.position = CGPointZero;
        [self addChild:rotateKeyMenu];

        [self initBlock];
        
        [self schedule:@selector(drawBlock:) interval:1/60];
        
	}
	return self;
}

- (void)leftKeyPressed:(id)sender {
    NSLog(@"left!");
    for (int i=0; i < 4; i++) {
        arr[i][0]--;
    }
}

- (void)rightKeyPressed:(id)sender {
    NSLog(@"right!");
    for (int i=0; i < 4; i++) {
        arr[i][0]++;
    }
}

- (void)rotateKeyPressed:(id)sender {
    NSLog(@"rotate!");
    for (int i=0; i < 4; i++) {
        CGPoint result = [self rotateX:(CGFloat)arr[i][0] Y:(CGFloat)arr[i][1] degree:M_PI/2];
        arr[i][0] = (int)result.x;
        arr[i][1] = (int)result.y;
    }
}

int arr[4][2] = {
// ㄴ
    {0,1},
    {0,0},
    {1,0},
    {2,0}
};

- (void) initBlock {
    _block = [CCNode node];
    for (int i=0; i < 4; i++) {
        CCSprite *block = [self blankSpriteWithSize:CGSizeMake(50, 50)];
        [block setColor:ccc3(100, i*20, i*20)];
        [block setPosition:ccp(160+(50*arr[i][0]), 240+(50*arr[i][1]))];
        [_block addChild:block z:i];
    }
    [self addChild:_block];
}

- (void) drawBlock:(ccTime)dt {
    for (int i=0; i < 4; i++) {
        //CGPoint result = [self rotateX:(CGFloat)arr[i][0] Y:(CGFloat)arr[i][1] degree:M_PI/2];
        //arr[i][0] = (int)result.x;
        //arr[i][1] = (int)result.y;
        [[[_block children]objectAtIndex:i]setPosition:ccp(160+(50*arr[i][0]), 240+(50*arr[i][1]))];
    }
}

- (CCSprite*)blankSpriteWithSize:(CGSize)size
{
    CCSprite *sprite = [CCSprite node];
    GLubyte *buffer = malloc(sizeof(GLubyte)*4);
    for (int i=0;i<4;i++) {buffer[i]=255;}
    CCTexture2D *tex = [[CCTexture2D alloc] initWithData:buffer pixelFormat:kCCTexture2DPixelFormat_RGB5A1 pixelsWide:1 pixelsHigh:1 contentSize:size];
    [sprite setTexture:tex];
    [sprite setTextureRect:CGRectMake(0, 0, size.width, size.height)];
    free(buffer);
    return sprite;
}

- (CGPoint)rotateX:(CGFloat)x Y:(CGFloat)y degree:(CGFloat)degree {
    CGFloat newX, newY;
    newX = x*cos(degree) +  y*sin(degree);
    newY = x*sin(degree)*(-1) + y*cos(degree);
    NSLog(@"%i , %i", (int)newX , (int)newY );
    return CGPointMake(newX, newY);
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
