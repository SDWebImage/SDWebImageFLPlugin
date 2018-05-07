/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import <FLAnimatedImage/FLAnimatedImage.h>

/**
 *  FLAnimatedImage is not a subclass of UIImage, so it's not possible to store it into the memory cache currently. However, for performance issue and cell reuse on FLAnimatedImageView, we use associate object to bind a FLAnimatedImage into UIImage when an animated GIF image load. For most cases, you don't need to touch this.
 */
@interface UIImage (SDWebImageFLPlugin)

/**
 *  The FLAnimatedImage associated to the UIImage instance when an animated GIF image load.
 *  For most cases this is read-only and you should avoid manually setting this value. Util some cases like using placeholder with a `FLAnimatedImage`.
 */
@property (nonatomic, strong, nullable) FLAnimatedImage *sd_FLAnimatedImage;

@end
