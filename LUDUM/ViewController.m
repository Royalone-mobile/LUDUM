//
//  ViewController.m
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import "ViewController.h"
#import "WheelViewController.h"
#import "Global.h"
@interface ViewController ()
-(void) setContender:(MyTextView*)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _contender1._delegate = self;
    _contender2._delegate = self;
    _contender3._delegate = self;
    _contender4._delegate = self;
    _contender5._delegate = self;
    _contender6._delegate = self;
    _contender7._delegate = self;
    _contender8._delegate = self;
    _contender9._delegate = self;
    _contender10._delegate = self;
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)onWheelClicked:(id)sender {
    if(_contender1.checkBoxSelected) [self setContender:_contender1];
    if(_contender2.checkBoxSelected) [self setContender:_contender2];
    if(_contender3.checkBoxSelected) [self setContender:_contender3];
    if(_contender4.checkBoxSelected) [self setContender:_contender4];
    if(_contender5.checkBoxSelected) [self setContender:_contender5];
    if(_contender6.checkBoxSelected) [self setContender:_contender6];
    if(_contender7.checkBoxSelected) [self setContender:_contender7];
    if(_contender8.checkBoxSelected) [self setContender:_contender8];
    if(_contender9.checkBoxSelected) [self setContender:_contender9];
    if(_contender10.checkBoxSelected) [self setContender:_contender10];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WheelViewController *wheelController = (WheelViewController *)[storyboard instantiateViewControllerWithIdentifier:@"idsWheelViewController"];
    [self.navigationController pushViewController:wheelController animated:YES];
    
//    LoginViewController *loginController = (LoginViewController *)[storyboard instantiateViewControllerWithIdentifier:@"idcLoginSubjectViewController"];
//    //[self presentViewController:loginController animated:YES completion:nil];
//    [self.navigationController pushViewController:loginController animated:YES];
}

-(void) setContender:(NSString *)contenderName contenderColor:(UIColor*) color addFlag:(BOOL)flag{
    Global *global = [Global getInstance];
    [global setContenderWithColor:contenderName WithColor:color WithFlag:flag];
}
    
-(void) setContender:(MyTextView*)sender{
    UIColor *color = sender.txt_contenderName.backgroundColor;
    NSString *name = sender.txt_contenderName.text;
    [self setContender:name contenderColor:color addFlag:YES];
}
@end
