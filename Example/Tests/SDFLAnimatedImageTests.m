/*
 * This file is part of the SDWebImage package.
 * (c) Olivier Poitrey <rs@dailymotion.com>
 * (c) Matt Galloway
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

#import "SDTestCase.h"

@interface SDFLAnimatedImageTests : SDTestCase

@end

@implementation SDFLAnimatedImageTests

- (void)testSDFLAnimatedImageInitWithCoder {
    SDFLAnimatedImage *image1 = [SDFLAnimatedImage imageWithContentsOfFile:[self testGIFPath]];
    expect(image1).notTo.beNil();
    NSData *encodedData = [NSKeyedArchiver archivedDataWithRootObject:image1];
    expect(encodedData).notTo.beNil();
    SDFLAnimatedImage *image2 = [NSKeyedUnarchiver unarchiveObjectWithData:encodedData];
    expect(image2).notTo.beNil();
    
    // Check each property
    expect(image1.scale).equal(image2.scale);
    expect(image1.size).equal(image2.size);
    expect(image1.animatedImageData).equal(image2.animatedImageData);
    expect(image1.animatedImageLoopCount).equal(image2.animatedImageLoopCount);
    expect(image1.animatedImageFrameCount).equal(image2.animatedImageFrameCount);
}

// Since `SDFLAnimatedImage` confroms to `SDAnimatedImage` protocol, it should be compatible for `SDAnimatedImageView` rendering. Maybe this may be changed in the future but currently add this test as well.
- (void)testSDFLAnimatedImageWorksForSDAnimatedImageView {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SDFLAnimatedImage works for SDAnimatedImageView"];
    UIWindow *window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [window makeKeyAndVisible];
    SDAnimatedImageView *imageView = [SDAnimatedImageView new];
    [window addSubview:imageView];
    SDFLAnimatedImage *image = [SDFLAnimatedImage imageWithData:[self testGIFData]];
    imageView.image = image;
    expect(imageView.image).notTo.beNil();
    [imageView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        expect(imageView.currentFrame).notTo.beNil(); // current frame
        [expectation fulfill];
        [imageView removeFromSuperview];
        [window removeFromSuperview];
    });
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
