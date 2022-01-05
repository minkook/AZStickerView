# AZStickerView

[![CI Status](https://img.shields.io/travis/minkook/AZStickerView.svg?style=flat)](https://travis-ci.org/minkook/AZStickerView)
[![Version](https://img.shields.io/cocoapods/v/AZStickerView.svg?style=flat)](https://cocoapods.org/pods/AZStickerView)
[![License](https://img.shields.io/cocoapods/l/AZStickerView.svg?style=flat)](https://cocoapods.org/pods/AZStickerView)
[![Platform](https://img.shields.io/cocoapods/p/AZStickerView.svg?style=flat)](https://cocoapods.org/pods/AZStickerView)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

AZStickerView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'AZStickerView'
```

## Usage

Create StickerManager

```objc
// property
@property (nonatomic, strong) AZStickerManager *stickerManager;

// create stickerManager
self.stickerManager = [[AZStickerManager alloc] initWithDataSouce:self];
```

Binding DataSouce

```objc
// property
@property (nonatomic, strong) IBOutlet UIView *playgroundView;

#pragma mark - AZStickerManagerDataSouce
- (UIView *)playgroundViewInStickerManager:(AZStickerManager *)stickerManager {
    return self.playgroundView;
}
```

Sticker Control

```objc
// insert sticker
UIImage *image = [UIImage systemImageNamed:@"tortoise"];
NSUInteger index = [self.stickerManager insertStickerViewWithImage:image];

// select sticker
[self.stickerManager selectAtIndex:index];
```

## Author

minkook, manguks@gmail.com

## License

AZStickerView is available under the MIT license. See the LICENSE file for more info.
