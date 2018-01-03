//
//  WheelViewController.h
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMRotaryProtocol.h"
#import "SMRotaryWheel.h"
@interface WheelViewController : UIViewController<SMRotaryProtocol>
@property (strong, nonatomic) IBOutlet UIButton *radio_regular;
@property (strong, nonatomic) IBOutlet UIButton *radio_quick;
- (IBAction)onRegularClicked:(id)sender;
- (IBAction)onQuickClicked:(id)sender;
@property (nonatomic, strong) UILabel *valueLabel;
@property SMRotaryWheel *wheel;
@end
