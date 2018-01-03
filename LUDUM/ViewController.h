//
//  ViewController.h
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTextView.h"
@interface ViewController : UIViewController<UIContenderDelegate>
- (IBAction)onWheelClicked:(id)sender;
@property (strong, nonatomic) IBOutlet MyTextView *contender1;
@property (strong, nonatomic) IBOutlet MyTextView *contender2;
@property (strong, nonatomic) IBOutlet MyTextView *contender3;
@property (strong, nonatomic) IBOutlet MyTextView *contender4;
@property (strong, nonatomic) IBOutlet MyTextView *contender5;
@property (strong, nonatomic) IBOutlet MyTextView *contender6;
@property (strong, nonatomic) IBOutlet MyTextView *contender7;
@property (strong, nonatomic) IBOutlet MyTextView *contender8;
@property (strong, nonatomic) IBOutlet MyTextView *contender9;
@property (strong, nonatomic) IBOutlet MyTextView *contender10;

@end

