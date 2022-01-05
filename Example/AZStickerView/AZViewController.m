//
//  AZViewController.m
//  AZStickerView
//
//  Created by minkook on 12/10/2021.
//  Copyright (c) 2021 minkook. All rights reserved.
//

#import "AZViewController.h"
#import <AZStickerManager.h>


@interface AZViewController () < AZStickerManagerDataSouce >

@property (nonatomic, strong) IBOutlet UIView *playgroundView;

@property (nonatomic, strong) AZStickerManager *stickerManager;

@property (nonatomic, assign) NSUInteger lineDashPatternTypeIndex;

@end


@implementation AZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.playgroundView.layer.borderWidth = 1.0;
    self.lineDashPatternTypeIndex = 0;
    
    self.stickerManager = [[AZStickerManager alloc] initWithDataSouce:self];
    
    /* Config */
//    self.stickerManager.selectionMode = AZStickerSelectionModeNone;
//    self.stickerManager.deleteImage = [UIImage systemImageNamed:@"multiply.circle.fill"];
//    self.stickerManager.resizeImage = [UIImage systemImageNamed:@"arrow.up.left.and.arrow.down.right"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - AZStickerManagerDataSouce

- (UIView *)playgroundViewInStickerManager:(AZStickerManager *)stickerManager {
    return self.playgroundView;
}



#pragma mark - Button Action

- (IBAction)insertButtonAction:(UIButton *)sender {
    
    UIImage *image = [UIImage systemImageNamed:@"tortoise"];
    NSUInteger index = [self.stickerManager insertStickerViewWithImage:image];
    [self.stickerManager selectAtIndex:index];
    
}

- (IBAction)test2ButtonAction:(UIButton *)sender {
    
//    [self removeLastSticker];
    
//    [self toggleControlImage];
    
//    [self toggleEnablePlaygroundViewResetSelection];
    
//    [self toggleSelectionMode];
    
//    [self toggleOutlineBorderColor];
    
//    [self toggleOutlineBorderWidth];
    
    [self toggleOutlineBorderLineDashPattern];
    
}



#pragma mark - Test

- (void)removeLastSticker {
    
    NSUInteger index = self.stickerManager.count - 1;
    [self.stickerManager removeStickerAtIndex:index];
    
}

- (void)toggleControlImage {
    
    // change delete image
    if (self.stickerManager.deleteImage) {
        self.stickerManager.deleteImage = nil;
    }
    else {
        self.stickerManager.deleteImage = [UIImage systemImageNamed:@"multiply.circle.fill"];
    }
    
    // change resize image
    if (self.stickerManager.resizeImage) {
        self.stickerManager.resizeImage = nil;
    }
    else {
        self.stickerManager.resizeImage = [UIImage systemImageNamed:@"arrow.up.left.and.arrow.down.right"];
    }
    
}

- (void)toggleEnablePlaygroundViewResetSelection {
    self.stickerManager.enablePlaygroundViewResetSelection = !self.stickerManager.isEnablePlaygroundViewResetSelection;
}

- (void)toggleSelectionMode {
    
    AZStickerSelectionMode mode;
    
    switch (self.stickerManager.selectionMode) {
        case AZStickerSelectionModeNone: mode = AZStickerSelectionModeSingle; break;
        case AZStickerSelectionModeSingle: mode = AZStickerSelectionModeMultiple; break;
        case AZStickerSelectionModeMultiple: mode = AZStickerSelectionModeNone; break;
    }
    
    self.stickerManager.selectionMode = mode;
    
}

- (void)toggleOutlineBorderColor {
    
    UIColor *color = self.stickerManager.outlineBorderColor;
    
    if (color == UIColor.blackColor) {
        color = UIColor.redColor;
    }
    else if (color == UIColor.redColor) {
        color = UIColor.greenColor;
    }
    else if (color == UIColor.greenColor) {
        color = UIColor.blueColor;
    }
    else if (color == UIColor.blueColor) {
        color = UIColor.purpleColor;
    }
    else if (color == UIColor.purpleColor) {
        color = UIColor.clearColor;
    }
    else if (color == UIColor.clearColor) {
        color = UIColor.blackColor;
    }
    
    self.stickerManager.outlineBorderColor = color;
    
}

- (void)toggleOutlineBorderWidth {
    
    CGFloat width = self.stickerManager.outlineBorderWidth;
    
    if (width < 5) {
        width += 1;
    }
    else {
        width = 0;
    }
    
    self.stickerManager.outlineBorderWidth = width;
    
}

- (void)toggleOutlineBorderLineDashPattern {
    
    self.lineDashPatternTypeIndex += 1;
    
    if (self.lineDashPatternTypeIndex == 5) {
        self.lineDashPatternTypeIndex = 0;
    }
    
    NSArray<NSNumber *> *lineDash;
    switch (self.lineDashPatternTypeIndex) {
        case 0: lineDash = @[@(4.0f), @(4.0f)]; break;
        case 1: lineDash = @[@(1.0f), @(1.0f)]; break;
        case 2: lineDash = @[@(1.0f), @(4.0f)]; break;
        case 3: lineDash = @[@(4.0f), @(1.0f)]; break;
        case 4: lineDash = nil; break;
    }
    
    self.stickerManager.outlineBorderLineDashPattern = lineDash;
    
}


@end
