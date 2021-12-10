//
//  AZStickerManagerDataSouce.h
//  AZStickerView
//
//  Created by minkook yoo on 2021/12/10.
//

NS_ASSUME_NONNULL_BEGIN

@class AZStickerManager;
@protocol AZStickerManagerDataSouce <NSObject>


@required
- (UIView *)playgroundViewInStickerManager:(AZStickerManager *)stickerManager;


@end

NS_ASSUME_NONNULL_END
