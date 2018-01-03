//
//  WheelViewController.m
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import "WheelViewController.h"
#import "Global.h"
@interface WheelViewController ()

@end

@implementation WheelViewController
@synthesize  valueLabel ,wheel;

-(void) viewDidDisappear:(BOOL)animated{
    Global *global = [Global getInstance];
    [global.contenderNameList removeAllObjects];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 350, 120, 30)];
    valueLabel.textAlignment = UITextAlignmentCenter;
    valueLabel.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:valueLabel];
    Global *global = [Global getInstance];
    
    int count = global.contenderNameList.count;
    if(count==0) return;
    NSInteger division= 60/count;
    NSInteger wheelCount = division*count;
   self.wheel = [[SMRotaryWheel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)
                                                    andDelegate:self
                                                   withSections:wheelCount];
    
    self.wheel.center = CGPointMake(160, 240);
    [self.view addSubview:self.wheel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) wheelDidChangeValue:(NSString *)newValue {
    
    self.valueLabel.text = newValue;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onRegularClicked:(id)sender {
    UIImage *imageChecked = [UIImage imageNamed:@"btn_check_active.png"];
    UIImage *imageUnChecked = [UIImage imageNamed:@"btn_check_normal.png"];
    [self.radio_quick setImage:imageUnChecked forState:NULL];
    [self.radio_regular setImage:imageChecked forState:NULL];
    self.wheel.interval = 10;
}

- (IBAction)onQuickClicked:(id)sender {
    UIImage *imageChecked = [UIImage imageNamed:@"btn_check_active.png"];
    UIImage *imageUnChecked = [UIImage imageNamed:@"btn_check_normal.png"];
    [self.radio_quick setImage:imageChecked forState:NULL];
    [self.radio_regular setImage:imageUnChecked forState:NULL];
    self.wheel.interval = 2;
}
@end
