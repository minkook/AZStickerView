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

@property (nonatomic, strong) UITapGestureRecognizer *playgroundViewTapGesture;

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
        
        _selectionMode = AZStickerSelectionModeSingle;
        
    }
    
    return self;
    
}



#pragma mark - Property (Readonly)

- (UIView *)playgroundView {
    return self.dataSouce ? [self.dataSouce playgroundViewInStickerManager:self] : nil;
}

- (CGRect)parentBounds {
    return self.dataSouce ? self.playgroundView.bounds : CGRectZero;
}



#pragma mark - Property (Public)

- (NSUInteger)count {
    return self.stickers.count;
}

- (void)setDeleteImage:(UIImage *)deleteImage {
    
    if (_deleteImage == deleteImage) {
        return;
    }
    
    for (AZStickerView *sticker in self.stickers) {
        sticker.deleteImage = deleteImage;
    }
    
    _deleteImage = deleteImage;
    
}

- (void)setResizeImage:(UIImage *)resizeImage {
    
    if (_resizeImage == resizeImage) {
        return;
    }
    
    for (AZStickerView *sticker in self.stickers) {
        sticker.resizeImage = resizeImage;
    }
    
    _resizeImage = resizeImage;
    
}

- (void)setSelectionMode:(AZStickerSelectionMode)selectionMode {
    
    if (_selectionMode == selectionMode) {
        return;
    }
    
    switch (selectionMode) {
            
        case AZStickerSelectionModeSingle:
        case AZStickerSelectionModeMultipl: {
            [self enableSelectStickers:YES];
        }
            break;
            
        case AZStickerSelectionModeNone: {
            [self enableSelectStickers:NO];
        }
            break;
    }
    
    _selectionMode = selectionMode;
    
}

- (void)setEnablePlaygroundViewResetSelection:(BOOL)enablePlaygroundViewResetSelection {
    
    if (!_playgroundViewTapGesture) {
        _playgroundViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playgroundViewTapGesture:)];
        [self.playgroundView addGestureRecognizer:_playgroundViewTapGesture];
    }
    
}



#pragma mark - Create Sticker

- (AZStickerView *)createSticker:(UIImage *)image {
    
    AZStickerView *stickerView = [[AZStickerView alloc] initWithParentBounds:self.parentBounds
                                                                 deleteImage:self.deleteImage
                                                                 resizeImage:self.resizeImage];
    stickerView.stickerImage = image;
    stickerView.enableSelect = self.selectionMode == AZStickerSelectionModeNone ? NO : YES;
    
    __weak typeof(self) weakSelf = self;
    stickerView.willChangeSelectedHandler = ^(BOOL isSelected) {
        
        if (isSelected) {
            [weakSelf resetSelectAllStickers];
        }
        else {
            
        }
        
    };
    
    stickerView.didChangeSelectedHandler = ^(BOOL isSelected) {
        //
    };
    
    return stickerView;
    
}



#pragma mark - Insert

- (NSUInteger)insertStickerViewWithImage:(UIImage *)image {
    
    if (!self.dataSouce) {
        return NSNotFound;
    }
    
    AZStickerView *stickerView = [self createSticker:image];
    
    [self.playgroundView addSubview:stickerView];
    [self.stickers addObject:stickerView];
    
    return self.stickers.count - 1;
}



#pragma mark - Remove

- (void)removeStickerAtIndex:(NSUInteger)index {
    
    if (self.stickers.count <= index) {
        return;
    }
    
    AZStickerView *sticker = self.stickers[index];
    [sticker remove];
    [self.stickers removeObjectAtIndex:index];
    
}

- (void)removeAllStickers {
    
    for (AZStickerView *sticker in self.stickers) {
        [sticker remove];
    }
    
    [self.stickers removeAllObjects];
    
}



#pragma mark - Select

- (void)selectAtIndex:(NSUInteger)index {
    AZStickerView *sticker = self.stickers[index];
    if (!sticker) {
        return;
    }
    
    sticker.selected = YES;
}

- (void)resetSelectAllStickers {
    for (AZStickerView *sticker in self.stickers) {
        sticker.selected = NO;
    }
}

- (void)enableSelectStickers:(BOOL)enable {
    
    for (AZStickerView *sticker in self.stickers) {
        sticker.selected = NO;
        sticker.enableSelect = enable;
    }
    
}



#pragma mark - Gesture

- (void)playgroundViewTapGesture:(UITapGestureRecognizer *)recognizer {
    [self resetSelectAllStickers];
}


@end
