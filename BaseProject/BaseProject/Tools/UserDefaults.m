//
//  UserDefaults.m
//  Project01
//  Created by JackerooChu on 2019/3/4.
//  Copyright © 2019 JackerooChu. All rights reserved.
//
//  
//  If debugging a program bothers you, don't give up. 
//	Success is always around the corner. 
//	You never know how far you are from him unless you come to the corner. 
//	So remember,
//	persevere until you succeed.
//
        

#import "UserDefaults.h"

@implementation UserDefaults
+ (void)setImage:(NSData *)img
{
    [[NSUserDefaults standardUserDefaults] setObject:img forKey:@"img"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSData *)getImage
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"img"];
}
+ (void)setName:(NSString *)name
{
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)getName
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
}

+(void )setUsed:(BOOL)isUsed{
    [[NSUserDefaults standardUserDefaults] setBool:YES  forKey:@"use"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+ (BOOL )getUsed{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"use"];
}
@end
