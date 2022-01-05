//
//  AZStickerView.h
//  AZStickerView
//
//  Created by minkook yoo on 2020/06/11.
//  Copyright © 2020 minkook yoo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AZStickerView : UIView


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)coder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithParentBounds:(CGRect)parentBounds
                         deleteImage:(UIImage * _Nullable)deleteImage
                         resizeImage:(UIImage * _Nullable)resizeImage;


/**
 * default to redColor.
 */
@property (nonatomic, strong, nullable) UIColor *borderColor;

/**
 * default to 1.0.
 */
@property (nonatomic, assign) CGFloat borderWidth;

/**
 * default to nil.
 */
@property (nonatomic, strong, nullable) NSArray<NSNumber *> *borderLineDashPattern;

/**
 * default to nil.
 */
@property (nonatomic, strong, nullable) UIImage *stickerImage;

/**
 * default to DefaultDeleteImage Layer.
 */
@property (nonatomic, strong, nullable) UIImage *deleteImage;

/**
 * default to DefaultResizeImage Layer.
 */
@property (nonatomic, strong, nullable) UIImage *resizeImage;


/**
 * default to YES
 */
@property (nonatomic, assign) BOOL enableSelect;


/**
 default to NO.
 When selected is activated, the BorderLayer and control function are shown.
 TapGesture changes to YES.
 */
@property (nonatomic, assign, getter=isSelected) BOOL selected;


/**
 * View bounds Inset (StickerControlSize / 2).
 */
@property (nonatomic, assign, readonly) CGRect drawBounds;


- (void)remove;


/**
 Change Selected Callback Block.
 */
@property (nonatomic, copy) void (^willChangeSelectedHandler)(BOOL isSelected);
@property (nonatomic, copy) void (^didChangeSelectedHandler)(BOOL isSelected);


/**
 Remove Callback Block. (removeFromSuperview)
 */
@property (nonatomic, copy) void (^willRemoveHandler)(void);
@property (nonatomic, copy) void (^didRemoveHandler)(void);


@end

NS_ASSUME_NONNULL_END
