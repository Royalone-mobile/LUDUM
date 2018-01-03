//
//  MyTextView.h
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol UIContenderDelegate <NSObject>
-(void) setContender:(NSString *)contenderName contenderColor:(UIColor*) color addFlag:(BOOL)flag;
@end
@interface MyTextView : UIView
- (void)handleCheckBoxSelected:(UITapGestureRecognizer*)sender ;
@property (strong, nonatomic) IBOutlet UIImageView *img_checked;
@property (strong, nonatomic) IBOutlet UITextField *txt_contenderName;
@property (strong, nonatomic) IBOutlet UIView *backView;
@property (readonly,nonatomic) BOOL checkBoxSelected;
- (IBAction)onClick:(id)sender;
@property id<UIContenderDelegate> _delegate;
@end
