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
        
        self.enablePlaygroundViewResetSelection = YES;
        
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

- (void)setEnablePlaygroundViewResetSelection:(BOOL)enablePlaygroundViewResetSelection {
    
    if (!_playgroundViewTapGesture) {
        _playgroundViewTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(playgroundViewTapGesture:)];
        [self.playgroundView addGestureRecognizer:_playgroundViewTapGesture];
    }
    
    _enablePlaygroundViewResetSelection = enablePlaygroundViewResetSelection;
    _playgroundViewTapGesture.enabled = enablePlaygroundViewResetSelection;
    
}

- (void)setSelectionMode:(AZStickerSelectionMode)selectionMode {
    
    if (_selectionMode == selectionMode) {
        return;
    }
    
    switch (selectionMode) {
            
        case AZStickerSelectionModeSingle: {
            [self enableSelectAllStickers:YES];
        }
            break;
            
        case AZStickerSelectionModeMultiple: {
            [self enableSelectAllStickers:YES];
            [self resetSelectAllStickers];
        }
            break;
            
        case AZStickerSelectionModeNone: {
            [self resetSelectAllStickers];
            [self enableSelectAllStickers:NO];
        }
            break;
    }
    
    _selectionMode = selectionMode;
    
}



#pragma mark - Gesture

- (void)playgroundViewTapGesture:(UITapGestureRecognizer *)recognizer {
    [self resetSelectAllStickers];
}



#pragma mark - Create Sticker

- (AZStickerView *)createSticker:(UIImage *)image {
    
    AZStickerView *sticker = [[AZStickerView alloc] initWithParentBounds:self.parentBounds
                                                                 deleteImage:self.deleteImage
                                                                 resizeImage:self.resizeImage];
    sticker.stickerImage = image;
    sticker.enableSelect = self.selectionMode == AZStickerSelectionModeNone ? NO : YES;
    
    __weak typeof(self) weakSelf = self;
    __weak typeof(sticker) weakSticker = sticker;
    sticker.willChangeSelectedHandler = ^(BOOL isSelected) {
        
        switch (weakSelf.selectionMode) {
            case AZStickerSelectionModeSingle: {
                if (isSelected) {
                    [weakSelf resetSelectAllStickers];
                }
            }
                break;
                
            case AZStickerSelectionModeMultiple:
                break;
                
            case AZStickerSelectionModeNone:
                break;
        }
        
    };
    
    sticker.didChangeSelectedHandler = ^(BOOL isSelected) {
        
        switch (weakSelf.selectionMode) {
            case AZStickerSelectionModeSingle: {
                weakSelf.currentSelectedIndex = isSelected ? [weakSelf.stickers indexOfObject:weakSticker] : NSNotFound;
            }
                break;
                
            case AZStickerSelectionModeMultiple: {
                if (isSelected) {
                    weakSelf.lastSelectedIndex = [weakSelf.stickers indexOfObject:weakSticker];
                }
                else {
                    BOOL isFindSelected = NO;
                    for (AZStickerView *s in weakSelf.stickers) {
                        if (s.isSelected) {
                            isFindSelected = YES;
                            break;
                        }
                    }
                    if (!isFindSelected) {
                        weakSelf.lastSelectedIndex = NSNotFound;
                    }
                }
            }
                break;
                
            case AZStickerSelectionModeNone:
                break;
        }
        
    };
    
    return sticker;
    
}


#pragma mark - Stickers Control
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

- (void)enableSelectAllStickers:(BOOL)enable {
    for (AZStickerView *sticker in self.stickers) {
        sticker.enableSelect = enable;
    }
}



@end
