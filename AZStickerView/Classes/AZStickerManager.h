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
    AZStickerSelectionModeMultipl,
    AZStickerSelectionModeNone
};


@class AZStickerManager;
@protocol AZStickerManagerDataSouce <NSObject>


@required

- (UIView *)playgroundViewInStickerManager:(AZStickerManager *)stickerManager;


@end



@interface AZStickerManager : NSObject


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSouce:(id <AZStickerManagerDataSouce>)dataSouce;


/**
 * default is nil.
 */
@property (nonatomic, strong, nullable) UIImage *deleteImage;


/**
 * default is nil.
 */
@property (nonatomic, strong, nullable) UIImage *resizeImage;


/**
 * stickers total count
 */
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 * default : AZStickerSelectionModeSingle
 */
@property (nonatomic, assign) AZStickerSelectionMode selectionMode;

/**
 * default : NO
 * YES is playgroundView selected stickers reset.
 */
@property (nonatomic, assign) BOOL enablePlaygroundViewResetSelection;



#pragma mark - Insert

- (NSUInteger)insertStickerViewWithImage:(UIImage *)image;



#pragma mark - Remove

- (void)removeStickerAtIndex:(NSUInteger)index;

- (void)removeAllStickers;


@end

NS_ASSUME_NONNULL_END
