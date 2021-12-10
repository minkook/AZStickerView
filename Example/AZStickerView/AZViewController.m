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

@property (nonatomic, strong) AZStickerManager *stickerViewManager;

@end


@implementation AZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.playgroundView.layer.borderWidth = 1.0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.playgroundView addGestureRecognizer:tapGesture];
    
    self.stickerViewManager = [[AZStickerManager alloc] initWithDataSouce:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - AZStickerManagerDataSouce

- (UIView *)playgroundViewInStickerManager:(AZStickerManager *)stickerManager {
    return self.playgroundView;
}



#pragma mark - Gesture

- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    //
}



#pragma mark - Button Action

- (IBAction)addButtonAction:(UIButton *)sender {
    
    UIImage *image = [UIImage systemImageNamed:@"tortoise"];
    [self.stickerViewManager insertStickerViewWithImage:image];
    
}

@end
