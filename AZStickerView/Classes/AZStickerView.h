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
- (instancetype)initWithParentBounds:(CGRect)parentBounds;
- (instancetype)initWithParentBounds:(CGRect)parentBounds stickerImage:(UIImage *)stickerImage;


/**
 * default is nil.
 */
@property (nonatomic, strong, nullable) UIImage *stickerImage;


/**
 default is NO.
 When editMode is activated, the BorderLayer and control function are shown.
 TapGesture changes to YES.
 */
@property (nonatomic, assign) BOOL editMode;


/**
 * View bounds Inset (StickerControlSize / 2).
 */
@property (nonatomic, assign, readonly) CGRect drawBounds;


/**
 Change EditMode Callback Block. (removeFromSuperview)
 */
@property (nonatomic, copy) void (^willChangeEditModeHandler)(BOOL editMode);
@property (nonatomic, copy) void (^didChangeEditModeHandler)(BOOL editMode);


/**
 Remove Callback Block. (removeFromSuperview)
 */
@property (nonatomic, copy) void (^willRemoveHandler)(void);
@property (nonatomic, copy) void (^didRemoveHandler)(void);


@end

NS_ASSUME_NONNULL_END
