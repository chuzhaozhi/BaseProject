//
//  UIImage+Cache.m
//  EmbroideryAndCarving
//
//  Created by iOS-Czz on 2023/2/28.
//  Copyright © 2023 JackerooChu. All rights reserved.
//

#import "UIImage+Cache.h"

@implementation UIImage (Cache)
//保存图片到沙盒内,并返回存储图片的后缀地址
+ (NSString *)saveImageToCacheUseImage:(UIImage *)image
{
    //获取当前时间戳拼接到文件尾部,防止存储图片多时地址重复
    NSDate *currentDate = [NSDate dateWithTimeIntervalSinceNow:0];
    // *1000 是精确到毫秒，不乘就是精确到秒
    NSTimeInterval currentTime=[currentDate timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", currentTime];
    
    //这个路径是存储到本地用的图片后缀地址
    NSString *savePath= [NSString stringWithFormat:@"Documents/image_%@.png", timeString];
    //这个路径是将图片存入沙盒时的路径
    NSString *imageAllPath = [NSHomeDirectory() stringByAppendingPathComponent:savePath];
    //存储图片到沙盒,并返回结果
    BOOL result =[UIImagePNGRepresentation(image) writeToFile:imageAllPath atomically:YES];
    
    if (result == YES) {
        NSLog(@"保存成功");
    } else {
        NSLog(@"保存失败");
    }
    return savePath;
}

//根据图片的后缀地址, 重新拼接完成路径获取图片
+ (UIImage *)getCacheImageUseImagePath:(NSString *)imagePath
{
    //防止每次启动程序沙盒前缀地址改变,只存储后边文件路径,调用时再次拼接
    NSString *imageAllPath = [NSHomeDirectory() stringByAppendingPathComponent:imagePath];
    return [UIImage imageWithContentsOfFile:imageAllPath];
}
@end
