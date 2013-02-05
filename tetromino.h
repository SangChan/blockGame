//
//  tetromino.h
//  blockGame
//
//  Created by SangChan Lee on 13. 2. 5..
//  Copyright 2013년 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

#define type_I 0
#define type_J 1
#define type_L 2
#define type_O 3
#define type_S 4
#define type_T 5
#define type_Z 6

#define block_size 20
#define map_width  15
#define map_height 20

#define border_x 10
#define border_y 30

#define mv_left -1
#define mv_right 1
#define mv_down  0

static int i_type[4][2] = {
    {-1,0},
    {0,0},
    {1,0},
    {2,0},
};

static int j_type[4][2] = {
    {0,1},
    {0,0},
    {1,0},
    {2,0}
};

static int l_type[4][2] = {
    {-2,0},
    {-1,0},
    {0,0},
    {0,1}
};

static int o_type[4][2] = {
    {0,0},
    {1,0},
    {1,1},
    {0,1}
};

static int s_type[4][2] = {
    {-1,0},
    {0,0},
    {0,1},
    {1,1}
};

static int t_type[4][2] = {
    {-1,0},
    {0,0},
    {1,0},
    {0,1}
};

static int z_type[4][2] = {
    {-1,1},
    {0,1},
    {0,0},
    {1,0}
};



@interface tetromino : CCNode {
    int _x;
    int _y;
    int _map[4][2];
}

-(id) initTetrimino : (int)type;
-(BOOL)rotate;
-(BOOL)move:(int)direction;
-(BOOL)falling;

@end
