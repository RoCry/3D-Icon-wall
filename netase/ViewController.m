//
//  ViewController.m
//  netase
//
//  Created by RoCry on 12/19/12.
//  Copyright (c) 2012 http://rocry.com All rights unreserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define HALF_DISTANCE_ANIMATION_DURATION 10.0
#define ROTATE_ANGLE M_PI/4.0
#define HEIGHT 568.0

#define THREE_D_ON YES

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *iv0 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_icons_0"]];
    UIImageView *iv1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_icons_1"]];
    UIImageView *iv2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide_icons_2"]];
    
    iv0.frame = CGRectMake(0, 0, self.containerView.frame.size.width, HEIGHT / 2.0);
    iv1.frame = CGRectMake(0, 0, self.containerView.frame.size.width, HEIGHT / 2.0);
    iv2.frame = CGRectMake(0, 0, self.containerView.frame.size.width, HEIGHT / 2.0);
    

    [self.containerView addSubview:iv0];
    [self.containerView addSubview:iv1];
    [self.containerView addSubview:iv2];
    
    [self startAnimation:iv0 idx:0];
    [self startAnimation:iv1 idx:1];
    [self startAnimation:iv2 idx:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)startAnimation:(UIImageView *)iv idx:(NSInteger)idx{
    CATransform3D t = CATransform3DIdentity;
    if (THREE_D_ON) {        
        t.m34 = 1.0 / -400.0;
        t = CATransform3DRotate(t, ROTATE_ANGLE,1.0,0.0,0.0);
    }else {
        self.topBlackView.hidden = YES;
    }
    t = CATransform3DTranslate(t, 0, (1 - idx) * HEIGHT / 2.0, 0);
    iv.layer.transform = t;
    
    CGFloat m = idx + 1;
    CGFloat ty = m * HEIGHT * 0.5;
    NSTimeInterval duration = m * HALF_DISTANCE_ANIMATION_DURATION;
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        iv.layer.transform = CATransform3DTranslate(iv.layer.transform, 0, ty, 0);
    }completion:^(BOOL finished) {
        [self startAnimation:iv idx:2];
    }];
}

- (void)viewDidUnload {
    [self setContainerView:nil];
    [self setImageView:nil];
    [self setTopBlackView:nil];
    
    [super viewDidUnload];
}
@end
