//
//  ViewController.m
//  IQ Option Helper
//
//  Created by Danil Prykhodko on 29.12.15.
//  Copyright © 2015 DrPrykhodko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textFieldProfit resignFirstResponder];
    [textFieldBalance resignFirstResponder];
    [textFieldAmount resignFirstResponder];
    return YES;
}


    
- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
    textFieldProfit.delegate = self;
    textFieldBalance.delegate = self;
    textFieldAmount.delegate = self;
    [super viewDidLoad];
    [textFieldProfit setFont:[UIFont fontWithName:@"Roboto-Light" size:94]];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
