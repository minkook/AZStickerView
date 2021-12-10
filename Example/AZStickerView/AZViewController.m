//
//  AZViewController.m
//  AZStickerView
//
//  Created by mkyoo on 12/10/2021.
//  Copyright (c) 2021 mkyoo. All rights reserved.
//

#import "AZViewController.h"
#import <AZStickerView.h>

@interface AZViewController ()

@property (nonatomic, strong) IBOutlet UIView *playgroundView;

@property (nonatomic, strong) NSMutableArray<AZStickerView *> *stickerViews;

@end

@implementation AZViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
    self.stickerViews = [NSMutableArray new];
    
    self.playgroundView.layer.borderWidth = 1.0;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.playgroundView addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Gesture

- (void)tapGesture:(UITapGestureRecognizer *)recognizer {
    for (AZStickerView *stickerView in self.stickerViews) {
        stickerView.editMode = NO;
    }
}



#pragma mark - Button Action

- (IBAction)addButtonAction:(UIButton *)sender {
    
    AZStickerView *stickerView = [[AZStickerView alloc] initWithParentBounds:self.playgroundView.bounds];
    stickerView.stickerImage = [UIImage systemImageNamed:@"tortoise"];
    
    [self.playgroundView addSubview:stickerView];
    [self.stickerViews addObject:stickerView];
    
}

@end
