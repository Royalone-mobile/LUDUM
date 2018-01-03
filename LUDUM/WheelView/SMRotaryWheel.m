//
//  SMRotaryWheel.m
//  RotaryWheelProject
//
//  Created by cesarerocchi on 2/10/12.
//  Copyright (c) 2012 studiomagnolia.com. All rights reserved.


#import "SMRotaryWheel.h"
#import <QuartzCore/QuartzCore.h>
#import "SMCLove.h"
#import "Global.h"
@interface SMRotaryWheel()


    - (void)drawWheel;
    - (float) calculateDistanceFromCenter:(CGPoint)point;
    - (void) buildClovesEven;
    - (void) buildClovesOdd;
    - (UIImageView *) getCloveByValue:(int)value;
    - (NSString *) getCloveName:(int)position;
    - (void) rotateWheel;
    - (void) onTick;

@end
BOOL isRotating;
float wheelSpeed;
static float deltaAngle;
static float minAlphavalue = 0.6;
static float maxAlphavalue = 1.0;

@implementation SMRotaryWheel

@synthesize delegate, container, numberOfSections, startTransform, cloves, currentValue;
@synthesize timer, interval;

- (id) initWithFrame:(CGRect)frame andDelegate:(id)del withSections:(int)sectionsNumber {
    
    if ((self = [super initWithFrame:frame])) {
        self.interval = 10;
        self.currentValue = 0;
        self.numberOfSections = sectionsNumber;
        self.delegate = del;
        isRotating=NO;
		[self drawWheel];
        
	}
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    
    if ((self = [super initWithFrame:frame])) {
        self.interval = 10;
        self.currentValue = 0;
        isRotating=NO;
        [self drawWheel];
        
    }
    return self;
}


- (void) drawWheel {

    container = [[UIView alloc] initWithFrame:self.frame];
        
    CGFloat angleSize = 2*M_PI/numberOfSections;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        UIImageView *im = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"segment.png"]];
//        UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
//        
//        CGFloat hue = (arc4random() %256 /256.0);
//        CGFloat saturation = (arc4random() %128/256.0) + 0.5;
//        CGFloat brightness = (arc4random() %128/256.0) + 0.5;
//        
//        view.layer.backgroundColor = [[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1] CGColor];
//        view.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
//        view.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
//                                                container.bounds.size.height/2.0-container.frame.origin.y);
//        view.transform = CGAffineTransformMakeRotation(angleSize*i);
//        view.alpha = minAlphavalue;
//        view.tag = i;
//        
//        if (i == 0) {
//            view.alpha = maxAlphavalue;
//        }
        im.layer.anchorPoint = CGPointMake(1.0f, 0.5f);
        im.layer.position = CGPointMake(container.bounds.size.width/2.0-container.frame.origin.x,
                                        container.bounds.size.height/2.0-container.frame.origin.y); 
        im.transform = CGAffineTransformMakeRotation(angleSize*i);
        im.alpha = minAlphavalue;
        
        Global *global = [Global getInstance];
        
        int count = global.contenderNameList.count;
        int nameIndex = i % count;
        im.tag = i;


//        if (i == 0) {
//            im.alpha = maxAlphavalue;
//        }
        
        UIImageView *cloveImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 40, 40)];
//        cloveImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%i.png", i]];
                CGFloat hue = (arc4random() %256 /256.0);
                CGFloat saturation = (arc4random() %128/256.0) + 0.5;
                CGFloat brightness = (arc4random() %128/256.0) + 0.5;

        cloveImage.layer.backgroundColor = [[UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1] CGColor];
        //
        [im addSubview:cloveImage];
        
        [container addSubview:im];
        
    }
    
    container.userInteractionEnabled = NO;
    [self addSubview:container];
    
    cloves = [NSMutableArray arrayWithCapacity:numberOfSections];
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:self.frame];
    bg.image = [UIImage imageNamed:@"bg.png"];
    [self addSubview:bg];
    
    UIImageView *mask = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 58)];
    mask.image =[UIImage imageNamed:@"centerButton.png"] ;
    mask.center = self.center;
    mask.center = CGPointMake(mask.center.x, mask.center.y+3);
    
    mask.userInteractionEnabled = YES;
    [mask addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onRotate:)]];
    
    [self addSubview:mask];
    
    if (numberOfSections % 2 == 0) {
        
        [self buildClovesEven];
        
    } else {
        
        [self buildClovesOdd];
        
    }
    
    [self.delegate wheelDidChangeValue:[self getCloveName:currentValue]];

    
}


- (UIImageView *) getCloveByValue:(int)value {

    UIImageView *res;
    
    NSArray *views = [container subviews];
    
    for (UIImageView *im in views) {
        
        if (im.tag == value)
            res = im;
        
    }
    
    return res;
    
}
#define RADIANS_TO_DEGREES(__ANGLE)((__ANGLE)/(float)M_PI*180.0f)
-(IBAction) onRotate:(UITapGestureRecognizer *)singleTap {
    if(isRotating == NO){
     isRotating = YES;
        startTransform = container.transform;
        Global *global = [Global getInstance];
         wheelSpeed = [global randFloatBetween:0.01 and:3];
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(onTick) userInfo:nil repeats:NO];
        
    [self rotateWheel];
    }
}
-(void) onTick{
  
//    CALayer *currentLayer = (CALayer*) [self.container.layer presentationLayer];
//    float currentAngle = [[(NSNumber*) currentLayer valueForKeyPath:@"transform.rotation.z"] floatValue];
//    currentAngle = roundf(RADIANS_TO_DEGREES(currentAngle));
//    NSLog(@"current Angle: %f", currentAngle);
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    
//    
    [self.container.layer removeAnimationForKey:@"SpinAnimation"];
    
    
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    
    CGFloat newVal = 0.0;
    
    for (SMClove *c in cloves) {
        
        if (c.minValue > 0 && c.maxValue < 0) { // anomalous case
            
            if (c.maxValue > radians || c.minValue < radians) {
                
                if (radians > 0) { // we are in the positive quadrant
                    
                    newVal = radians - M_PI;
                    
                } else { // we are in the negative one
                    
                    newVal = M_PI + radians;
                    
                }
                currentValue = c.value;
                
            }
            
        }
        
        else if (radians > c.minValue && radians < c.maxValue) {
            
            newVal = radians - c.midValue;
            currentValue = c.value;
            
        }
        
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    
    [UIView commitAnimations];
    
    [self.delegate wheelDidChangeValue:[self getCloveName:currentValue]];
    
    UIImageView *im = [self getCloveByValue:currentValue];
    im.alpha = maxAlphavalue;
     isRotating =NO;
    
//    animation.toValue= [NSNumber numberWithFloat:(360*M_PI/180)];
//    [self.container.layer addAnimation:animation forKey:@"transform"];
//    CGAffineTransform rot = CGAffineTransformMakeRotation(360*M_PI/180);
//    self.container.layer.transform = rot;
    
//    [self.container.layer.presentationLayer frame];
}
- (void) buildClovesEven {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        
        if (clove.maxValue-fanWidth < - M_PI) {
            
            mid = M_PI;
            clove.midValue = mid;
            clove.minValue = fabsf(clove.maxValue);
            
        }
        
        mid -= fanWidth;
        
        
        NSLog(@"cl is %@", clove);
        
        [cloves addObject:clove];
        
    }
    
}


- (void) buildClovesOdd {
    
    CGFloat fanWidth = M_PI*2/numberOfSections;
    CGFloat mid = 0;
    
    for (int i = 0; i < numberOfSections; i++) {
        
        SMClove *clove = [[SMClove alloc] init];
        clove.midValue = mid;
        clove.minValue = mid - (fanWidth/2);
        clove.maxValue = mid + (fanWidth/2);
        clove.value = i;
        
        mid -= fanWidth;
        
        if (mid < - M_PI) {
            
            mid = -mid;
            mid -= fanWidth; 
            
        }
        
                
        [cloves addObject:clove];
        
        NSLog(@"cl is %@", clove);
        
    }
    
}

- (float) calculateDistanceFromCenter:(CGPoint)point {
    
    CGPoint center = CGPointMake(self.bounds.size.width/2.0f, self.bounds.size.height/2.0f);
	float dx = point.x - center.x;
	float dy = point.y - center.y;
	return sqrt(dx*dx + dy*dy);
    
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchPoint = [touch locationInView:self];
    float dist = [self calculateDistanceFromCenter:touchPoint];
    
    if (dist < 40 || dist > 100) 
    {
        // forcing a tap to be on the ferrule
        NSLog(@"ignoring tap (%f,%f)", touchPoint.x, touchPoint.y);
        return NO;
    }
    
	float dx = touchPoint.x - container.center.x;
	float dy = touchPoint.y - container.center.y;
	deltaAngle = atan2(dy,dx); 
    
    startTransform = container.transform;
    
    UIImageView *im = [self getCloveByValue:currentValue];
    im.alpha = minAlphavalue;
    
    return YES;
    
}

- (BOOL)continueTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
	CGPoint pt = [touch locationInView:self];
    
    float dist = [self calculateDistanceFromCenter:pt];
    
    if (dist < 40 || dist > 100) 
    {
        // a drag path too close to the center
        NSLog(@"drag path too close to the center (%f,%f)", pt.x, pt.y);
        
        // here you might want to implement your solution when the drag 
        // is too close to the center
        // You might go back to the clove previously selected
        // or you might calculate the clove corresponding to
        // the "exit point" of the drag.startTransform

    }
	
	float dx = pt.x  - container.center.x;
	float dy = pt.y  - container.center.y;
	float ang = atan2(dy,dx);
    
    float angleDifference = deltaAngle - ang;
    
    container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
    
    return YES;
	
}
- (void) rotateWheel{
//    if([self.container.layer animationForKey:@"SpinAnimation"]==nil){
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    animation.fromValue = [NSNumber numberWithFloat:0.0f];
//    animation.toValue = [NSNumber numberWithFloat:2*M_PI];
//    animation.duration = 1.26f;
//    animation.repeatCount = INFINITY;
//    [container.layer addAnimation:animation forKey:@"SpinAnimation"];
//    }
    if(isRotating == YES)
    {
        float angleDifference = -0.2f;
        
        container.transform = CGAffineTransformRotate(startTransform, -angleDifference);
        startTransform = container.transform;

        
        [self performSelector:@selector(rotateWheel) withObject:nil afterDelay:wheelSpeed];
    }
}
- (void)endTrackingWithTouch:(UITouch*)touch withEvent:(UIEvent*)event
{
    
    CGFloat radians = atan2f(container.transform.b, container.transform.a);
    
    CGFloat newVal = 0.0;
    
    for (SMClove *c in cloves) {
        
        if (c.minValue > 0 && c.maxValue < 0) { // anomalous case
            
            if (c.maxValue > radians || c.minValue < radians) {
                
                if (radians > 0) { // we are in the positive quadrant
                    
                    newVal = radians - M_PI;
                    
                } else { // we are in the negative one
                    
                    newVal = M_PI + radians;                    
                    
                }
                currentValue = c.value;
                
            }
            
        }
        
        else if (radians > c.minValue && radians < c.maxValue) {
            
            newVal = radians - c.midValue;
            currentValue = c.value;
            
        }
        
    }
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.2];
    
    CGAffineTransform t = CGAffineTransformRotate(container.transform, -newVal);
    container.transform = t;
    
    [UIView commitAnimations];
    
    [self.delegate wheelDidChangeValue:[self getCloveName:currentValue]];
    
    UIImageView *im = [self getCloveByValue:currentValue];
    im.alpha = maxAlphavalue;
    
}

- (NSString *) getCloveName:(int)position {
    Global *global = [Global getInstance];
    int count = global.contenderNameList.count;
    if(count==0)return @"";
    int nameIndex = position % count;

    NSString *name = [global.contenderNameList objectAtIndex:nameIndex];

    
    return name;
}



@end
