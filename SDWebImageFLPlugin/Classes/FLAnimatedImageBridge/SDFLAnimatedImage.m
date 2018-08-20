/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDFLAnimatedImage.h"

@interface SDFLAnimatedImage ()

@property (nonatomic, strong, nullable) FLAnimatedImage *animatedImage;

@end

@implementation SDFLAnimatedImage

- (instancetype)initWithAnimatedImage:(FLAnimatedImage *)animatedImage {
    NSParameterAssert(animatedImage);
    UIImage *posterImage = animatedImage.posterImage;
    self = [super initWithCGImage:posterImage.CGImage scale:posterImage.scale orientation:posterImage.imageOrientation];
    if (self) {
        self.animatedImage = animatedImage;
    }
    return self;
}

+ (instancetype)imageWithContentsOfFile:(NSString *)path {
    return [[self alloc] initWithContentsOfFile:path];
}

+ (instancetype)imageWithData:(NSData *)data {
    return [[self alloc] initWithData:data];
}

+ (instancetype)imageWithData:(NSData *)data scale:(CGFloat)scale {
    return [[self alloc] initWithData:data scale:scale];
}

- (instancetype)initWithData:(NSData *)data {
    return [self initWithData:data scale:1];
}

- (instancetype)initWithContentsOfFile:(NSString *)path {
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [self initWithData:data];
}

- (instancetype)initWithData:(NSData *)data scale:(CGFloat)scale {
    FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:data];
    if (!animatedImage) {
        return nil;
    }
    return [self initWithAnimatedImage:animatedImage];
}

#pragma mark - NSSecureCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSData *animatedImageData = [aDecoder decodeObjectOfClass:[NSData class] forKey:NSStringFromSelector(@selector(animatedImageData))];
        if (!animatedImageData) {
            return nil;
        }
        FLAnimatedImage *animatedImage = [[FLAnimatedImage alloc] initWithAnimatedGIFData:animatedImageData];
        if (!animatedImage) {
            return nil;
        }
        self.animatedImage = animatedImage;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    NSData *animatedImageData = self.animatedImageData;
    if (animatedImageData) {
        [aCoder encodeObject:animatedImageData forKey:NSStringFromSelector(@selector(animatedImageData))];
    }
}

#pragma mark - SDAnimatedImage

- (instancetype)initWithAnimatedCoder:(id<SDAnimatedImageCoder>)animatedCoder scale:(CGFloat)scale {
    // Does not support progressive load for GIF images at all
    return nil;
}

- (nullable NSData *)animatedImageData {
    return self.animatedImage.data;
}

- (NSTimeInterval)animatedImageDurationAtIndex:(NSUInteger)index {
    return [self.animatedImage.delayTimesForIndexes[@(index)] doubleValue];
}

- (nullable UIImage *)animatedImageFrameAtIndex:(NSUInteger)index {
    return [self.animatedImage imageLazilyCachedAtIndex:index];
}

- (NSUInteger)animatedImageFrameCount {
    return self.animatedImage.frameCount;
}

- (NSUInteger)animatedImageLoopCount {
    return self.animatedImage.loopCount;
}

@end
