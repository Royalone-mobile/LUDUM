//
//  Global.m
//  LUDUM
//
//  Created by venus on 24/02/2017.
//  Copyright © 2017 VENUS. All rights reserved.
//

#import "Global.h"

@implementation Global
@synthesize contenderNameList;
+ (Global *)getInstance
{
    static dispatch_once_t onceToken;
    static Global *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[Global alloc] init];
    });
    return instance;
}

- (id) init
{
    self = [super init];
    if (self != nil){
        contenderNameList = [NSMutableArray new];
    }
    return self;
}

-(void) setContenderWithColor:(NSString *)name WithColor:(UIColor *)color WithFlag:(BOOL)flag{
    if(flag==YES){
    [contenderNameList addObject:name];
    }
    else if(flag==NO){
        [contenderNameList removeObject:name];
    }
    
}
#define RAND_MAX 0x1000000000
-(float) randFloatBetween:(float)low and:(float)high{
    float diff = high - low;
    float retval =  (((float) rand()/RAND_MAX)*diff)+low;
    return retval;
}
@end
