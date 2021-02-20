//
//  OpenCV.mm
//  LightroomDemoApp
//
//  Created by softwareuser014 on 2020/11/27.
//
#include <vector>
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>
#import "OpenCV.h"

@implementation OpenCV
// 階調
+(UIImage *) tone:(UIImage *)image{
    // Mat 型のsrc, dst1, dst2, dst3を定義
    cv::Mat src, dst;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // src をコピー
    dst = src.clone();
    // ルックアップテーブルを用いたガンマ補正
    // コントラスト
    double toneValue = 64;
    // ルックアップテーブル用配列
    uchar  lut[256];
    for (int i = 0; i < 256; i++) {
        //ポスタリゼーション
        lut[i] = (float)(i / toneValue) / (float)( 255 / toneValue ) * 255.0f;
    }
    //画像の走査 //縦
    for (int i=0; i<src.rows; i++) {
        // 横
        for (int j=0; j<src.cols; j++) {
            // ルックアップテーブル　適用 修正あり
            cv::Vec3b s = src.at<cv::Vec3b>(i, j);
            dst.at<cv::Vec3b>(i, j) = cv::Vec3b(lut[s[0]], lut[s[1]], lut[s[2]]);//BGR
        }
    }
    cv::LUT(src, cv::Mat(1, 256, CV_8UC1, lut), dst);
    return  MatToUIImage(dst);
}
// コントラスト
+(UIImage *) contrast:(UIImage *)image{
    // Mat 型のsrc, dst1, dst2, dst3を定義
    cv::Mat src, dst;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // ルックアップテーブルを用いたガンマ補正
    // コントラスト
    double contrastValue = 2;
    // ルックアップテーブル用配列
    uchar  lut[256];
    for (int i = 0; i < 256; i++) {
        double result = contrastValue * (i - 127) + 127;
        // 明るさ変更
        if(result >= 255.0) {
            lut[i] = 255.0;
        } else if (result <= 0.0) {
            lut[i] = 0.0;
        } else {
            lut[i] = result;
        }
    }
    // ルックアップテーブル変換
    cv::LUT(src, cv::Mat(1, 256, CV_8UC1, lut), dst);
    return  MatToUIImage(dst);
}
// 露光量の変更
+(UIImage *)exposure:(UIImage *)image{
    // Mat 型のsrc, dst1, dst2, dst3を定義
    cv::Mat src, dst;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // ルックアップテーブルを用いたガンマ補正
    // ガンマ値※変数化する
    double gamma = 0.5;
    // ルックアップテーブル用配列
    uchar  lut[256];
    for (int i = 0; i < 256; i++) {
        // ガンマ補正式
        lut[i] = pow(i / 255.0, 1 / gamma) * 255.0;
    }
    // ルックアップテーブル変換
    cv::LUT(src, cv::Mat(1, 256, CV_8UC1, lut), dst);
    return  MatToUIImage(dst);
}

// グレースケール
+(UIImage *)GrayScale:(UIImage *)image{
    // Mat 型のsrcを定義
    cv::Mat src;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // Mat 型のdstを定義。
    cv::Mat dst;
    // グレースケールに加工したsrcをdstへ編集
    cv::cvtColor(src, dst, CV_BGR2GRAY);
    // dstをUIImage型にして返す
    return MatToUIImage(dst);
}
// ２値化する
+(UIImage *) Threshold: (UIImage *) image {
    // Mat 型のsrcを定義
    cv::Mat src;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // Mat 型のdstを定義。
    cv::Mat dst;
    // srcを２値化してdstへ編集
    cv::threshold(src, dst, 0, 255, CV_THRESH_BINARY | CV_THRESH_OTSU);
    // dstをMat型にして返す
    return  MatToUIImage(dst);
}
// RGBからHSV色空間に変換する
+(UIImage *)ColorHSV:(UIImage *)image{
    // Mat 型のsrcを定義
    cv::Mat src;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // Mat 型のdstを定義。
    cv::Mat dst;
    // srcをHSV空間にしてdstへ編集
    cv::cvtColor(src, dst, CV_BGR2HSV);
    // dstをMat型にして返す
    return  MatToUIImage(dst);
}
// HSVからRGB色空間に変換する
+(UIImage *)ColorRGB:(UIImage *)image{
    // Mat 型のsrcを定義
    cv::Mat src;
    // UIImage型のimageをMat型にしてsrcへ編集
    UIImageToMat(image, src);
    // Mat 型のdstを定義。
    cv::Mat dst;
    // srcをRGB空間にしてdstへ編集
    cv::cvtColor(src, dst, CV_HSV2BGR);
    // dstをMat型にして返す
    return  MatToUIImage(dst);
}



@end
