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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
}


#pragma mark - Button Action

- (IBAction)addButtonAction:(UIButton *)sender {
    
    AZStickerView *stickerView = [[AZStickerView alloc] initWithFrame:self.playgroundView.bounds];
    
    [self.playgroundView addSubview:stickerView];
    
}


@end
