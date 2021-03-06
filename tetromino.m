//
//  tetromino.m
//  blockGame
//
//  Created by SangChan Lee on 13. 2. 5..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import "tetromino.h"


@implementation tetromino

-(id) initTetrimino : (int)type {
    if (self == [super init]) {
        _x = 8;
        _y = 22;
        memcpy(_map, z_type, sizeof(_map));
        for (int i=0; i < 4; i++) {
            CCSprite *block = [self blankSpriteWithSize:CGSizeMake(block_size, block_size)];
            [block setColor:ccc3(arc4random() % 255 , arc4random() % 255, arc4random() % 255)];
            [block setPosition:ccp((_x+_map[i][0])*block_size, (_y+_map[i][1])*block_size)];
            [self addChild:block z:i];
        }
    }
    return self;
}
-(void)draw {
    for (int i=0; i < 4; i++) {
        [[[self children]objectAtIndex:i]setPosition:ccp((_x+_map[i][0])*block_size, (_y+_map[i][1])*block_size)];
    }
}

-(BOOL)rotate {
    for (int i=0; i < 4; i++) {
        CGPoint result = [self rotateX:(CGFloat)_map[i][0] Y:(CGFloat)_map[i][1] degree:M_PI/2];
        _map[i][0] = (int)roundf(result.x);
        _map[i][1] = (int)roundf(result.y);
    }
    
    
    return YES;
}

-(BOOL)move:(int)direction {
    if (direction == mv_left) {
        _x--;
    }
    else if (direction == mv_right) {
        _x++;
    }
    
    return YES;
}

-(BOOL)falling{
    if (_y > 4) {
        _y--;
    }
    return YES;
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
    float newX, newY;
    newX = x*cos(degree) +  y*sin(degree);
    newY = x*sin(degree)*(-1) + y*cos(degree);
    NSLog(@"%f to %f(%i) || %f to %f(%i)",x,newX,(int)roundf(newX), y, newY, (int)roundf(newY));
    return CGPointMake(newX, newY);
}

@end
