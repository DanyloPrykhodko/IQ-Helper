//
//  ViewController.m
//  IQ Option Helper
//
//  Created by Danil Prykhodko on 29.12.15.
//  Copyright © 2015 DrPrykhodko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@end

@implementation ViewController
@synthesize proTextFieldProfit, proTextFieldAmount, protextFieldBalance, proLabelProfit, proLabelAmount;

//----------------------------------------------------------------------------------------------------

    //Balance
    double WinBalance = 10.0;
    double Balance = 100.0;

    //Amount
    double StartAmount = 10.0;
    double Amount = 10.0;

    //Profit
    int Profit = 99;
    double profitAmount = 18.8;

    //Support
    int Step = 1;

//----------------------------------------------------------------------------------------------------

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
    [self update];
    [textFieldProfit setFont:[UIFont fontWithName:@"Roboto-Light" size:94]];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonLose:(id)sender {
    NSLog(@"LOSE");
    Step++;
    Balance -= Amount;
    Amount = 100.0 * (((WinBalance-(StartAmount*(Step-1))) + (StartAmount*((Profit) / 100.0))*Step) - (Balance - StartAmount*(Step-1))) / Profit;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    proTextFieldAmount.textColor = [UIColor redColor];
    [self update];
}

- (IBAction)buttonWin:(id)sender {
    NSLog(@"WIN");
    Balance -= Amount;
    Balance += Amount*((100 + Profit)/100.0);
    WinBalance = Balance;
    Amount = StartAmount;
    Step = 1;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    proTextFieldAmount.textColor = [UIColor whiteColor];
    [self updateS];
    [self update];
}

- (IBAction)textFieldBalanceEditingChanged:(id)sender {
    [self update];
}
- (IBAction)textFieldAmountEditingChanged:(id)sender {
    [self update];
    StartAmount = [textFieldAmount.text doubleValue];
}

- (IBAction)textFieldProfitEditingChanged:(id)sender {
    [self update];
}

-(void)update{
    Balance = [textFieldBalance.text doubleValue];
    Amount = [textFieldAmount.text doubleValue];
    Profit = [textFieldProfit.text intValue];
}

-(void)updateS{
    proLabelProfit.text = [NSString stringWithFormat:@"%g", profitAmount];
    proLabelAmount.text = [NSString stringWithFormat:@"$%g", Amount];
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", Amount];
    protextFieldBalance.text = [NSString stringWithFormat:@"%g", Balance];
}

@end
