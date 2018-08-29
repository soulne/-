//
//  ColorToImage.m
//  8thManageNative
//
//  Created by podywu on 13-12-18.
//  Copyright (c) 2013年 WisageTech. All rights reserved.
//

#import "ColorToImage.h"

@implementation ColorToImage

+(UIImage *) createImageWithColor:(UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
