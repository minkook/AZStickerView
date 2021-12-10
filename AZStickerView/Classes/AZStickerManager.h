//
//  AZStickerManager.h
//  AZStickerView
//
//  Created by minkook yoo on 2021/12/10.
//

#import "AZStickerView.h"
#import "AZStickerManagerDataSouce.h"

NS_ASSUME_NONNULL_BEGIN

@interface AZStickerManager : NSObject


- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDataSouce:(id <AZStickerManagerDataSouce>)dataSouce;


- (NSUInteger)insertStickerViewWithImage:(UIImage *)image;


- (void)removeAllSticker;


@end

NS_ASSUME_NONNULL_END
