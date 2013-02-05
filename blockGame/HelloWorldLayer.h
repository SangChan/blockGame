//
//  HelloWorldLayer.h
//  blockGame
//
//  Created by SangChan Lee on 13. 2. 5..
//  Copyright __MyCompanyName__ 2013년. All rights reserved.
//


#import <GameKit/GameKit.h>
// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "tetromino.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCMenuItem *_leftKey;
    CCMenuItem *_rightKey;
    CCMenuItem *_rotateKey;
    tetromino *_block;
    int map[map_height][map_width];
}



// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
