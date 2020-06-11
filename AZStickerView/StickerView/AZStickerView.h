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


/**
 삭제 콜백 블록. (removeFromSuperview)
 */
@property (nonatomic, copy) void (^willRemoveHandler)(void);
@property (nonatomic, copy) void (^didRemoveHandler)(void);

@end

NS_ASSUME_NONNULL_END
