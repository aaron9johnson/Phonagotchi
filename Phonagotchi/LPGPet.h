//
//  LPGPet.h
//  Phonagotchi
//
//  Created by Aaron Johnson on 2017-10-12.
//  Copyright © 2017 Lighthouse Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LPGPet : NSObject
@property (readonly) bool grumpy;
-(void)pet:(CGPoint)velocity;
@end
