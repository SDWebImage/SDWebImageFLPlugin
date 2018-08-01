/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <SDWebImage/SDWebImage.h>

// A coder which decode the GIF image, into `FLAnimatedImage` representation and bind the associated object. See `UIImage+SDWebImageFLPlugin` for more detailed information.
// When you want to use `FLAnimatedImageView` to load image, be sure to add this coder before `SDImageGIFCoder`, to ensure this coder been processed before `SDImageGIFCoder`

@interface SDWebImageFLCoder : NSObject <SDImageCoder>

@property (nonatomic, class, readonly, nonnull) SDWebImageFLCoder *sharedCoder;

@end
