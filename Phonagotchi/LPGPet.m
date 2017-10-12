//
//  LPGPet.m
//  Phonagotchi
//
//  Created by Aaron Johnson on 2017-10-12.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import "LPGPet.h"
@interface LPGPet()
@property (readwrite) bool grumpy;
@end
@implementation LPGPet
-(void)pet:(CGPoint)velocity{
    if(velocity.x > 500 || velocity.x < -500 ||velocity.y > 500 || velocity.y < -500 ){
        self.grumpy = true;
    } else {
        self.grumpy = false;
    }
}
@end
