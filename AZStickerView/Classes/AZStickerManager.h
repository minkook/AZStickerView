//
//  AZStickerManager.h
//  AZStickerView
//
//  Created by minkook yoo on 2021/12/10.
//

#import "AZStickerView.h"


NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, AZStickerSelectionMode) {
    AZStickerSelectionModeSingle,
    AZStickerSelectionModeMultiple,
    AZStickerSelectionModeNone
};

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//



@class AZStickerManager;
@protocol AZStickerManagerDataSouce <NSObject>


@required

- (UIView *)playgroundViewInStickerManager:(AZStickerManager *)stickerManager;


@end

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//



@interface AZStickerManager : NSObject


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSouce:(id <AZStickerManagerDataSouce>)dataSouce;


/**
 * stickers total count
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 * available AZStickerSelectionModeSingle.
 */
@property (nonatomic, assign, readonly) NSUInteger currentSelectedIndex;

/**
 * available AZStickerSelectionModeMultiple.
 */
@property (nonatomic, assign, readonly) NSUInteger lastSelectedIndex;

/**
 * default : YES
 * YES is playgroundView selected stickers reset.
 */
@property (nonatomic, assign, getter=isEnablePlaygroundViewResetSelection) BOOL enablePlaygroundViewResetSelection;


/**
 * default : AZStickerSelectionModeSingle
 */
@property (nonatomic, assign) AZStickerSelectionMode selectionMode;



#pragma mark - Stickers Design

/**
 * default to blackColor.
 */
@property (nonatomic, strong, nonnull) UIColor *outlineBorderColor;

/**
 * default to 1.0.
 */
@property (nonatomic, assign) CGFloat outlineBorderWidth;

/**
 * default to @[@(4.0f), @(4.0f)].
 */
@property (nonatomic, strong, nullable) NSArray<NSNumber *> *outlineBorderLineDashPattern;


/**
 * default to nil.
 */
@property (nonatomic, strong, nullable) UIImage *deleteImage;

/**
 * default to nil.
 */
@property (nonatomic, strong, nullable) UIImage *resizeImage;



#pragma mark - Stickers Control

- (NSUInteger)insertStickerViewWithImage:(UIImage *)image;


- (void)removeStickerAtIndex:(NSUInteger)index;


- (void)removeAllStickers;


- (void)selectAtIndex:(NSUInteger)index;



@end

NS_ASSUME_NONNULL_END
