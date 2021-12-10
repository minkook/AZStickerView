//
//  AZStickerManager.m
//  AZStickerView
//
//  Created by minkook yoo on 2021/12/10.
//

#import "AZStickerManager.h"


@interface AZStickerManager ()

@property (nonatomic, weak) id <AZStickerManagerDataSouce> dataSouce;

@property (nonatomic, strong) NSMutableArray <AZStickerView *>*stickers;

@property (nonatomic, weak, readonly) UIView *playgroundView;
@property (nonatomic, assign, readonly) CGRect parentBounds;

@end


@implementation AZStickerManager


#pragma mark - init

- (instancetype)initWithDataSouce:(id <AZStickerManagerDataSouce>)dataSouce {
    
    self = [super init];
    
    if (self) {
        _dataSouce = dataSouce;
        
        _stickers = [NSMutableArray new];
        
    }
    
    return self;
    
}



#pragma mark - Property

- (UIView *)playgroundView {
    return self.dataSouce ? [self.dataSouce playgroundViewInStickerManager:self] : nil;
}

- (CGRect)parentBounds {
    return self.dataSouce ? self.playgroundView.bounds : CGRectZero;
}



#pragma mark - Create

- (NSUInteger)insertStickerViewWithImage:(UIImage *)image {
    
    if (!self.dataSouce) {
        return NSNotFound;
    }
    
    AZStickerView *stickerView = [[AZStickerView alloc] initWithParentBounds:self.parentBounds];
    stickerView.stickerImage = image;
    
    [self.playgroundView addSubview:stickerView];
    [self.stickers addObject:stickerView];
    
    return self.stickers.count - 1;
}



#pragma mark - Remove

- (void)removeAllSticker {
    
    for (AZStickerView *sticker in self.stickers) {
        [sticker remove];
    }
    
    [self.stickers removeAllObjects];
    
}

@end
