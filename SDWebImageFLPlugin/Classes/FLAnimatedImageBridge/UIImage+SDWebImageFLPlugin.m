/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "UIImage+SDWebImageFLPlugin.h"
#import <SDWebImage/SDWebImage.h>
#import "objc/runtime.h"

@implementation UIImage (SDWebImageFLPlugin)

- (FLAnimatedImage *)sd_FLAnimatedImage {
    return objc_getAssociatedObject(self, @selector(sd_FLAnimatedImage));
}

- (void)setSd_FLAnimatedImage:(FLAnimatedImage *)sd_FLAnimatedImage {
    objc_setAssociatedObject(self, @selector(sd_FLAnimatedImage), sd_FLAnimatedImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)sd_imageWithFLAnimatedImage:(FLAnimatedImage *)animatedImage {
    UIImage *posterImage = animatedImage.posterImage;
    CGImageRef imageRef = posterImage.CGImage;
    if (!imageRef) {
        return nil;
    }
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRef scale:posterImage.scale orientation:UIImageOrientationUp];
    
    image.sd_FLAnimatedImage = animatedImage;
    image.sd_isDecoded = YES; // Avoid force decode and loss the associate object
    
    return image;
}

@end
