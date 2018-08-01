//
//  SDViewController.m
//  SDWebImageFLPlugin
//
//  Created by DreamPiggy on 05/07/2018.
//  Copyright (c) 2018 DreamPiggy. All rights reserved.
//

#import "SDViewController.h"
#import <SDWebImageFLPlugin/SDWebImageFLPlugin.h>

@interface SDViewController ()

@end

@implementation SDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[SDImageCodersManager sharedManager] addCoder:[SDWebImageFLCoder sharedCoder]];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    FLAnimatedImageView *animatedImageView = [[FLAnimatedImageView alloc] initWithFrame:self.view.frame];
    animatedImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:animatedImageView];
    [animatedImageView sd_setImageWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/liyong03/YLGIFImage/master/YLGIFImageDemo/YLGIFImageDemo/joy.gif"]];
}

@end
