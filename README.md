# SDWebImageFLPlugin

[![CI Status](https://img.shields.io/travis/SDWebImage/SDWebImageFLPlugin.svg?style=flat)](https://travis-ci.org/SDWebImage/SDWebImageFLPlugin)
[![Version](https://img.shields.io/cocoapods/v/SDWebImageFLPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImageFLPlugin)
[![License](https://img.shields.io/cocoapods/l/SDWebImageFLPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImageFLPlugin)
[![Platform](https://img.shields.io/cocoapods/p/SDWebImageFLPlugin.svg?style=flat)](https://cocoapods.org/pods/SDWebImageFLPlugin)

Starting with the SDWebImage 5.0 version, we move the [FLAnimatedImage](https://github.com/Flipboard/FLAnimatedImage) support code from the Core Repo to this stand-alone repo. Core which previously use FLAnimatedImage with SDWebImage can continue to work with this plugin.

## What's for
SDWebImageFLPlugin is a plugin for [SDWebImage](https://github.com/rs/SDWebImage/) framework, which provide the image loading support for [FLAnimatedImage](https://github.com/Flipboard/FLAnimatedImage) animated GIF engine.

By using SDWebImageFLPlugin, you can use all you familiar SDWebImage's loading method, on the `FLAnimatedImageView`, which is the base component of FLAnimatedImage.

To use it, simply make sure you use `FLAnimatedImageView` instead of `UIImageView` and import this plugin.

## Usage
**Important**: From v0.2.0, to load a network image on `FLAnimatedImageView`, at first you must ensure you added the `SDWebImageFLCodcer` to your coders manager (its priority should be higher than `SDImageGIFCoder`, or it will fallback to normal GIF rendering). You can add this on AppDelegate or somewhere earlier than usage, once is enough.

+ Objective-C

```objectivec
// The later added coders contains higher priority
[SDImageCodersManager.sharedManager addCoder:[SDWebImageFLCoder.sharedCoder]];
```

+ Swift

```swift
// The later added coders contains higher priority
SDImageCodersManager.shared.addCoder(SDWebImageFLCoder.shared)
```

Then, just simply call the View Category method like normal UIImageView.

+ Objective-C

```objectivec
FLAnimatedImageView *imageView;
[imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.gif"]];
```

+ Swift

```swift
let imageView: FLAnimatedImageView
imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.gif"))
```

For placeholder, you can even provide a GIF image which use `FLAnimatedImage` instance (bind it on a `UIImage` instance), to allow GIF placeholder on `FLAnimatedImageView`

+ Objective-C

```objectivec
FLAnimatedImageView *imageView;
FLAnimatedImage *animatedImage = [FLAnimatedImage animatedImageWithGIFData:gifData];
UIImage *placeholder = [UIImage sd_imageWithFLAnimatedImage:animatedImage];
[imageView sd_setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.gif"] placeholderImage:placeholder];
```

+ Swift

```swift
let imageView: FLAnimatedImageView
let animatedImage = FLAnimatedImage(animatedGIFData: gifData)
let placeholder = UIImage.sd_image(with: animatedImage)
imageView.sd_setImage(with: URL(string: "http://www.domain.com/path/to/image.gif"), placeholderImage: placeholder)
```

## Requirements

+ iOS 8+
+ Xcode 9+

## Installation

SDWebImageFLPlugin is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'SDWebImageFLPlugin'
```

## Author

DreamPiggy, lizhuoli1126@126.com

## License

SDWebImageFLPlugin is available under the MIT license. See the LICENSE file for more info.


