//
//  LPGViewController.m
//  Phonagotchi
//
//  Created by Steven Masuch on 2014-07-26.
//  Copyright (c) 2014 Lighthouse Labs. All rights reserved.
//

#import "LPGViewController.h"
#import "LPGPet.h"

@interface LPGViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;
@property int restfulness;
@property bool sleep;
@property (nonatomic) UIImageView *petImageView;
@property (nonatomic) UIImageView *movingApple;
@property (weak, nonatomic) IBOutlet UIImageView *apple;
@property LPGPet *cat;
@property bool grabbedApple;

@end

@implementation LPGViewController
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if(self.grabbedApple){
        UITouch *touch = [touches anyObject];
        CGPoint point = [touch locationInView:self.view];
        self.movingApple.center = CGPointMake(point.x, point.y);
    }
}
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.grabbedApple = false;
}
- (IBAction)pinchGesture:(UIPinchGestureRecognizer *)sender {
    NSLog(@"pinch");
    if(!self.grabbedApple){
        self.movingApple.center = self.apple.center;
        self.movingApple.hidden = false;
        self.grabbedApple = true;
    }
}
- (IBAction)panGesture:(UIPanGestureRecognizer *)sender {
    [self.cat pet:[sender velocityInView:self.view]];
    if(self.cat.grumpy){
        self.petImageView.image = [UIImage imageNamed:@"grumpy"];
    } else {
        self.petImageView.image = [UIImage imageNamed:@"default"];
    }
}
-(void)tick{
    if(self.sleep){
        self.restfulness += 1;
    } else {
        self.restfulness -= 1;
    }
    if(self.restfulness <= 0){
        self.sleep = true;
        self.petImageView.image = [UIImage imageNamed:@"sleeping"];
    }
    if(self.restfulness >= 1000){
        self.sleep = false;
        self.petImageView.image = [UIImage imageNamed:@"default"];
    }

    self.label.text = [NSString stringWithFormat:@"Restfulness: %d",self.restfulness];
    
    if(!self.grabbedApple){
        self.movingApple.center = CGPointMake(self.movingApple.center.x, self.movingApple.center.y + 1);
        if(CGRectIntersectsRect(self.movingApple.frame, self.petImageView.frame) && self.movingApple.center.y == self.petImageView.center.y){
            self.movingApple.hidden = true;
        }
        if(!CGRectIntersectsRect(self.movingApple.frame, self.view.frame)){
            self.movingApple.hidden = true;
        }
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(tick) userInfo:nil repeats:YES];
    self.cat = [LPGPet new];
    self.grabbedApple = false;
    self.sleep = false;
    self.restfulness = 1000;
	
    self.view.backgroundColor = [UIColor colorWithRed:(252.0/255.0) green:(240.0/255.0) blue:(228.0/255.0) alpha:1.0];
    
    self.petImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.petImageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.petImageView.image = [UIImage imageNamed:@"default"];
    
    [self.view addSubview:self.petImageView];
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    
    [NSLayoutConstraint constraintWithItem:self.petImageView
                                  attribute:NSLayoutAttributeCenterY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.view
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1.0
                                   constant:0.0].active = YES;
    self.movingApple = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.movingApple.image = [UIImage imageNamed:@"apple"];
//    self.movingApple.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.movingApple];
//    [NSLayoutConstraint constraintWithItem:self.movingApple
//                                 attribute:NSLayoutAttributeHeight
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                  constant:80.0].active = YES;
//
//    [NSLayoutConstraint constraintWithItem:self.movingApple
//                                 attribute:NSLayoutAttributeWidth
//                                 relatedBy:NSLayoutRelationEqual
//                                    toItem:nil
//                                 attribute:NSLayoutAttributeNotAnAttribute
//                                multiplier:1.0
//                                  constant:102.0].active = YES;
    self.movingApple.hidden = true;
}

@end
