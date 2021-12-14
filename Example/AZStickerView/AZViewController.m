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

@end


@implementation AZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.playgroundView.layer.borderWidth = 1.0;
    
    self.stickerManager = [[AZStickerManager alloc] initWithDataSouce:self];
    self.stickerManager.enablePlaygroundViewResetSelection = YES;
    
    
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

- (IBAction)lastRemoveButtonAction:(UIButton *)sender {
    
    NSUInteger index = self.stickerManager.count - 1;
    [self.stickerManager removeStickerAtIndex:index];
    
}

@end
