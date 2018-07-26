/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDWebImageFLCoder.h"
#import "FLAnimatedImageView+WebCache.h"

@implementation SDWebImageFLCoder

+ (SDWebImageFLCoder *)sharedCoder {
    static SDWebImageFLCoder *coder;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        coder = [[SDWebImageFLCoder alloc] init];
    });
    return coder;
}

- (BOOL)canDecodeFromData:(NSData *)data {
    return ([NSData sd_imageFormatForImageData:data] == SDImageFormatGIF);
}

- (UIImage *)decodedImageWithData:(NSData *)data options:(SDImageCoderOptions *)options {
    SDWebImageContext *context = options[SDImageCoderWebImageContext];
    NSString *operationKey = context[SDWebImageContextSetImageOperationKey];
    
    // Check if image request come from `FLAnimatedImageView`
    if ([operationKey isEqualToString:NSStringFromClass(FLAnimatedImageView.class)]) {
        // Parse args
        BOOL predrawingEnabled = YES;
        if (context[SDWebImageContextPredrawingEnabled]) {
            predrawingEnabled = [context[SDWebImageContextPredrawingEnabled] boolValue];
        }
        NSUInteger optimalFrameCacheSize = 0;
        if (context[SDWebImageContextOptimalFrameCacheSize]) {
            optimalFrameCacheSize = [context[SDWebImageContextOptimalFrameCacheSize] unsignedIntegerValue];
        }
        // Create FLAnimatedImage
        FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data optimalFrameCacheSize:optimalFrameCacheSize predrawingEnabled:predrawingEnabled];
        if (!animatedImage) {
            return nil;
        }
        
        return [UIImage sd_imageWithFLAnimatedImage:animatedImage];
    } else {
        UIImage *image;
        NSArray<id<SDImageCoder>> *coders = [SDImageCodersManager sharedManager].coders;
        for (id<SDImageCoder> coder in coders.reverseObjectEnumerator) {
            if (coder == self) {
                continue;
            }
            if ([coder canDecodeFromData:data]) {
                image = [coder decodedImageWithData:data options:options];
                break;
            }
        }
        
        return image;
    }
}

- (BOOL)canEncodeToFormat:(SDImageFormat)format {
    return NO;
}

- (NSData *)encodedDataWithImage:(UIImage *)image format:(SDImageFormat)format options:(SDImageCoderOptions *)options {
    return nil;
}

@end
