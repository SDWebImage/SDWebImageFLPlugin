/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Matt Galloway
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDTestCase.h"

@interface SDWebCacheCategoriesTests : SDTestCase

@end

@implementation SDWebCacheCategoriesTests

- (void)testFLAnimatedImageViewSetImageWithURL {
    XCTestExpectation *expectation = [self expectationWithDescription:@"FLAnimatedImageView setImageWithURL"];
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    NSURL *originalImageURL = [NSURL URLWithString:kTestGIFURL];
    
    [imageView sd_setImageWithURL:originalImageURL
                        completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                            expect(image).toNot.beNil();
                            expect(error).to.beNil();
                            expect(originalImageURL).to.equal(imageURL);
                            
                            expect(imageView.animatedImage).toNot.beNil();
                            [expectation fulfill];
                        }];
    [self waitForExpectationsWithCommonTimeout];
}

- (void)testFLAnimatedImageViewSetImageWithGIFPlaceholder {
    XCTestExpectation *expectation = [self expectationWithDescription:@"FLAnimatedImageView setImageWithURL with GIF placeholder"];
    
    FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:[self testGIFData]];
    expect(animatedImage).toNot.beNil();
    SDFLAnimatedImage *placeholderImage = [[SDFLAnimatedImage alloc] initWithAnimatedImage:animatedImage];
    expect(placeholderImage).toNot.beNil();
    
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    NSURL *originalImageURL = nil; // invalid URL
    [imageView sd_setImageWithURL:originalImageURL placeholderImage:placeholderImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        expect(error).notTo.beNil();
        FLAnimatedImage *currentAnimatedImage = imageView.animatedImage;
        expect(currentAnimatedImage).equal(placeholderImage.animatedImage);
        
        [expectation fulfill];
    }];
    [self waitForExpectationsWithCommonTimeout];
}

#pragma mark - Util

- (NSString *)testGIFPath {
    NSBundle *testBundle = [NSBundle bundleForClass:[self class]];
    return [testBundle pathForResource:@"TestImage" ofType:@"gif"];
}

- (NSData *)testGIFData {
    NSData *testData = [NSData dataWithContentsOfFile:[self testGIFPath]];
    return testData;
}

@end

