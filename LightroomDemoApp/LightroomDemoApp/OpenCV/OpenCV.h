//
//  OpenCV.h
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OpenCV : NSObject
// 階調
+(UIImage *)tone:(UIImage *)image;
// コントラスト
+(UIImage *)contrast:(UIImage *)image;
// 露光量
+(UIImage *)exposure:(UIImage *)image;
// グレースケール
+(UIImage *)GrayScale:(UIImage *)image;
// RGBからHSV色空間に変換する
+(UIImage *)ColorHSV:(UIImage *)image;
// HSVからRGB色空間に変換する
+(UIImage *)ColorRGB:(UIImage *)image;

@end


NS_ASSUME_NONNULL_END
