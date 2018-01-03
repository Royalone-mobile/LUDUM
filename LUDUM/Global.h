//
//  Global.h
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Global : NSObject
+ (Global *)getInstance;
@property NSMutableArray* contenderNameList;

-(void) setContenderWithColor:(NSString *)name WithColor:(UIColor *)color WithFlag:(BOOL)flag;
-(float) randFloatBetween:(float)low and:(float)high;
@end
