//
//  UserDefaults.h
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
        

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaults : NSObject
+ (void)setImage:(NSData *)img;
+ (NSData *)getImage;

+ (void)setName:(NSString *)name;
+ (NSString *)getName;

+ (void)setUsed:(BOOL )isUsed;
+ (BOOL )getUsed;
@end

NS_ASSUME_NONNULL_END
