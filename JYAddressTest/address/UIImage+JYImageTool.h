//
//  UIImage+JYImageTool.h
//  减约
//
//  Created by nick on 16/5/9.
//  Copyright © 2016年 北京减脂时代科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JYImageTool)

+ (instancetype)imageWithColor:(UIColor*)color;

- (UIImage *)fixOrientation;

/**
 *  压缩图片尺寸
 *
 *  @param size 要压缩到的尺寸
 *  @param img  原图片
 *
 *  @return UIImage 压缩后的图片
 */
+ (UIImage *)scaleToSize:(CGSize)size withImage:(UIImage *)img;

//压缩图片质量
+ (NSData *)compressImage:(UIImage *)image withMaxKb:(CGFloat)maxKb;

//剪裁图片
+ (void)clipImage:(UIImage *)image withRect:(CGRect)rect;

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 *  剪切图片为正方形
 *
 *  @param image   原始图片比如size大小为(400x200)pixels
 *  @param newSize 正方形的size比如400pixels
 *
 *  @return 返回正方形图片(400x400)pixels
 */
+ (UIImage *)squareImageFromImage:(UIImage *)image scaledToSize:(CGFloat)newSize;

@end

