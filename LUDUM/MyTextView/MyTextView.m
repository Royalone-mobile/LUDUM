//
//  MyTextView.m
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import "MyTextView.h"

@implementation MyTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@synthesize checkBoxSelected = _checkBoxSelected;

-(id)init
{
    self = [super init];
    
    if(self != nil)
    {
        [self loadLayout];
    }
    _checkBoxSelected = 0;
    
    //    _contender1.layer.backgroundColor
    
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self != nil)
    {
        [self loadLayout];
    }

    return self;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self != nil)
    {
        [self loadLayout];
    }
    return self;
}

-(void)loadLayout
{
    [[NSBundle mainBundle] loadNibNamed:@"MyTextView"
                                  owner:self
                                options:nil];
    [self addSubview:[self backView]];
    CGFloat hue = (arc4random() %256 /256.0);
    CGFloat saturation = (arc4random() %128/256.0) + 0.5;
    CGFloat brightness = (arc4random() %128/256.0) + 0.5;
    self.txt_contenderName.backgroundColor = [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];

//    self.backView.translatesAutoresizingMaskIntoConstraints = NO;
//    NSLayoutConstraint* top = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_backView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0];
//    
//    NSLayoutConstraint* left = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_backView attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0];
//    
//    NSLayoutConstraint* right = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_backView attribute:NSLayoutAttributeRight multiplier:1.0 constant:0];
//    
//    NSLayoutConstraint* bottom = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_backView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0];
//    
//    NSArray* array = [NSArray arrayWithObjects:top,left,bottom,right, nil];
//    [NSLayoutConstraint activateConstraints:array];
//    
//    _backView.layer.borderColor = [UIColor whiteColor].CGColor;
//    _backView.layer.borderWidth = 2.0;
//    _textView.layer.borderWidth = 0;
    
}

- (void)handleCheckBoxSelected:(UITapGestureRecognizer*)sender {
    UIColor *color = self.txt_contenderName.backgroundColor;
    if (_checkBoxSelected == 0){
        _checkBoxSelected = 1;
        self.img_checked.image =[UIImage imageNamed:@"btn_check_active.png"];
        _checkBoxSelected = 1;
        
        
//        [self._delegate setContender:self.txt_contenderName.text contenderColor:color addFlag:YES];
        
    } else {
        self.img_checked.image = [UIImage imageNamed:@"btn_check_normal.png"];
        _checkBoxSelected = 0;        
//        [self._delegate setContender:self.txt_contenderName.text contenderColor:color addFlag:YES];
    }
}
- (IBAction)onClick:(id)sender {
    [self handleCheckBoxSelected:sender];
}
@end
