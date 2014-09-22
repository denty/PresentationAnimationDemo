//
//  RootViewController.m
//  AniamtionReseach
//
//  Created by broy denty on 14-9-12.
//  Copyright (c) 2014年 denty. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    __weak IBOutlet UIView *animationView;
    __weak IBOutlet UIButton *button1;
    __weak IBOutlet UIButton *button2;
    
    UIView *animationSubView;
    
}
@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Animation";
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Action" style:UIBarButtonItemStylePlain target:self action:@selector(animationAction)]];
    [button1 addTarget:self action:@selector(buttion1Listener) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(buttion2Listener) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer * m_recongzer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTouchAnalyze:)];
    [self.view addGestureRecognizer:m_recongzer];
    [m_recongzer setDelegate:self];
    
    
    //    test frame and bounds
//    [animationView setBounds:CGRectMake(-50, -50, animationView.frame.size.width, animationView.frame.size.height)];
    animationSubView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    [animationSubView setBackgroundColor:[UIColor grayColor]];
    [animationView addSubview:animationSubView];
    

    // add 高斯模糊
//    UIImage * testImage = [[UIImage alloc] initwith]
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)animationAction
{
    [self animationStartButtion1];
    [self animationStartButtion2];
    [self animationStartButtion3];
}

- (void)animationStartButtion1
{
    [UIView animateWithDuration:2 animations:^{
        [button1 setFrame:CGRectMake(button1.frame.origin.x+100, button1.frame.origin.y, button1.frame.size.width, button1.frame.size.height)];
    }];
}

- (void)animationStartButtion3
{

    CABasicAnimation * aCABasicAnimation = [[CABasicAnimation alloc] init];
    [aCABasicAnimation setKeyPath:@"transform"];
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = 1.0f/500.0f;
    [aCABasicAnimation setFromValue:[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    [aCABasicAnimation setToValue:[NSValue valueWithCATransform3D:CATransform3DRotate(trans, M_PI/4, 1, 0, 0)]];
    [aCABasicAnimation setDuration:2];
    [aCABasicAnimation setRemovedOnCompletion:NO];
    aCABasicAnimation.fillMode = kCAFillModeForwards;
    [aCABasicAnimation setDelegate:self];
    [animationView.layer addAnimation:aCABasicAnimation forKey:nil];
}

- (void)animationStartButtion2
{
    CABasicAnimation *aCABasicAnimation = [[CABasicAnimation alloc] init];
    [aCABasicAnimation setKeyPath:@"position"];
    [aCABasicAnimation setDuration:2];
    [aCABasicAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [aCABasicAnimation setFromValue:[NSValue valueWithCGPoint:CGPointMake(button2.layer.position.x, button2.layer.position.y)]];
    [aCABasicAnimation setToValue:[NSValue valueWithCGPoint:CGPointMake(button2.layer.position.x+100, button2.layer.position.y)]];
    [aCABasicAnimation setRemovedOnCompletion:NO];
    aCABasicAnimation.fillMode = kCAFillModeForwards;
    [aCABasicAnimation setDelegate:self];
    [button2.layer addAnimation:aCABasicAnimation forKey:@"button2"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if ([anim isEqual:[button2.layer animationForKey:@"button2"]]) {
        if (flag) {
//            button2.layer.frame = [(CALayer *)[[button2 layer] presentationLayer] frame];
        }
    }
}

- (void)buttion1Listener
{
    UIAlertView * aUIAlertView = [[UIAlertView alloc] initWithTitle:@"button1" message:@"onTouch" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
    [aUIAlertView show];
}

- (void)buttion2Listener
{
    UIAlertView * aUIAlertView = [[UIAlertView alloc] initWithTitle:@"button2" message:@"onTouch" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles: nil];
    [aUIAlertView show];
}

- (void)onTouchAnalyze:(UIGestureRecognizer *) gesture
{
    CGPoint touchPoint = [gesture locationInView:self.view];
    if ([button2.layer.presentationLayer hitTest:touchPoint])
    {
        [self buttion2Listener];
    }
}
@end
