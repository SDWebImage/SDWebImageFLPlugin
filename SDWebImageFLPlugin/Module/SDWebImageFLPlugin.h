#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#if __has_include(<SDWebImage/SDWebImage.h>)
#import <SDWebImage/SDWebImage.h>
#else
@import SDWebImage;
#endif
#if __has_include(<FLAnimatedImage/FLAnimatedImage.h>)
#import <FLAnimatedImage/FLAnimatedImage.h>
#else
@import FLAnimatedImage;
#endif


FOUNDATION_EXPORT double SDWebImageFLPluginVersionNumber;
FOUNDATION_EXPORT const unsigned char SDWebImageFLPluginVersionString[];

