//
//  ViewController.m
//  AZStickerView
//
//  Created by minkook yoo on 2020/06/11.
//  Copyright © 2020 minkook yoo. All rights reserved.
//

#import "ViewController.h"
#import "AZStickerView.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIView *playgroundView;

@property (nonatomic, strong) AZStickerView *stickerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


#pragma mark - Button Action

- (IBAction)addButtonAction:(UIButton *)sender {
    
    AZStickerView *stickerView = [[AZStickerView alloc] initWithParentBounds:self.playgroundView.bounds];
    stickerView.stickerImage = [UIImage systemImageNamed:@"tortoise"];
    
    [self.playgroundView addSubview:stickerView];
    
    self.stickerView = stickerView;
    
}

- (IBAction)lastStickerChangeImageButtonAction:(UIButton *)sender {
    
    if (self.stickerView) {
        UIImage *image = [UIImage systemImageNamed:@"tortoise.fill"];
        self.stickerView.stickerImage = image;
    }
    
}


@end
