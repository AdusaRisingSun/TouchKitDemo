//
//  DragView.m
//  TouchKitDemo
//
//  Created by Adusa on 15/8/27.
//  Copyright (c) 2015年 Adusa. All rights reserved.
//

#import "DragView.h"

@implementation DragView
{
    CGPoint startLocation;
    CGFloat rotation;
}
-(instancetype)initWithImage:(UIImage *)anImage
{
    self=[super initWithImage:anImage];
    rotation=0.0f;
    if ( self) {
        self.userInteractionEnabled=YES;
        UILongPressGestureRecognizer *pressGesture=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
        [self addGestureRecognizer:pressGesture];
    }
    return self;
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)uilpgr
{
    if (![self becomeFirstResponder]) {
        NSLog(@"Could not become first responder");
        return;
    }
    UIMenuController *menu=[UIMenuController sharedMenuController];
    UIMenuItem *pop=[[UIMenuItem alloc]initWithTitle:@"Pop" action:@selector(popSelf)];
    UIMenuItem *rotate=[[UIMenuItem alloc]initWithTitle:@"Rotation" action:@selector(rotationSelf)];
    UIMenuItem *ghost=[[UIMenuItem alloc]initWithTitle:@"Ghost" action:@selector(ghostSelf)];
    menu.menuItems=@[pop,rotate,ghost];
    [menu setTargetRect:self.bounds inView:self];
    menu.arrowDirection=UIMenuControllerArrowDown;
    [menu update];
    [menu setMenuVisible:YES];
}

- (void)popSelf
{
    [UIView animateWithDuration:0.25f animations:^(){self.transform = CGAffineTransformMakeScale(1.5f, 1.5f);} completion:^(BOOL Done){
        [UIView animateWithDuration:0.25 animations:^(){self.transform=CGAffineTransformIdentity;}] ;}];
}

- (void)rotationSelf
{
    [UIView animateWithDuration:0.25f animations:^(){self.transform = CGAffineTransformMakeRotation(rotation+M_PI * 0.5);} completion:^(BOOL done){
        rotation=M_PI*0.5+rotation;}];
}

- (void)ghostSelf
{
    [UIView animateWithDuration:1.25f animations:^(){self.alpha = 0.0f;} completion:^(BOOL done){
        [UIView animateWithDuration:1.25f animations:^(){} completion:^(BOOL done){
            [UIView animateWithDuration:0.5f animations:^(){self.alpha = 1.0f;}];
        }];
    }];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    startLocation = [[touches anyObject] locationInView:self];
    [self.superview bringSubviewToFront:self];
}

- (void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    float dx = pt.x - startLocation.x;
    float dy = pt.y - startLocation.y;
    CGPoint newcenter = CGPointMake(self.center.x + dx, self.center.y + dy);
    
    self.center = newcenter;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
