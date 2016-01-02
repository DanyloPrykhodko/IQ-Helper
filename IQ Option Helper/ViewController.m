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

@synthesize proTextFieldProfit, proTextFieldAmount, protextFieldBalance, proLabelProfit, proLabelAmount, minBalance, pluBalance, minAmount, pluAmount;
//------------------------------------------------------------------------------
#pragma mark Glodal Variables

//Balance
double WinBalance = 0;
double Balance = 0;

//Amount
int StartAmount = 0;
double Amount = 0;

//Profit
int Profit = 99;
double profitAmount = 0;

//Support
int Step = 1;
//------------------------------------------------------------------------------
#pragma mark ViewDid Load

- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
    textFieldProfit.delegate = self;
    textFieldBalance.delegate = self;
    textFieldAmount.delegate = self;
    [super viewDidLoad];    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"\t Cancel \t" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"\t  Done    \t" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    textFieldProfit.inputAccessoryView = numberToolbar;
    textFieldAmount.inputAccessoryView = numberToolbar;
    textFieldBalance.inputAccessoryView = numberToolbar;
    [textFieldProfit setFont:[UIFont fontWithName:@"Roboto-Light" size:94]];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textFieldProfit resignFirstResponder];
    [textFieldBalance resignFirstResponder];
    [textFieldAmount resignFirstResponder];
    return YES;
}

-(void)cancelNumberPad{
    if ([self.proTextFieldProfit isFirstResponder]) {
        textFieldProfit.text = [NSString stringWithFormat: @"%d",Profit];
        [textFieldProfit resignFirstResponder];
    }else if ([self.proTextFieldAmount isFirstResponder]){
        textFieldAmount.text = [NSString stringWithFormat: @"%g",Amount/100];
        [textFieldAmount resignFirstResponder];
    }else if ([self.protextFieldBalance isFirstResponder]){
        textFieldBalance.text = [NSString stringWithFormat: @"%g",Balance/100];
        [textFieldBalance resignFirstResponder];
    }
}

-(void)doneWithNumberPad{
    if ([self.proTextFieldProfit isFirstResponder]) {
        [textFieldProfit resignFirstResponder];
    }else if ([self.proTextFieldAmount isFirstResponder]){
        [textFieldAmount resignFirstResponder];
    }else if ([self.protextFieldBalance isFirstResponder]){
        [textFieldBalance resignFirstResponder];
    }
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//------------------------------------------------------------------------------
#pragma mark LOSE/WIN

- (IBAction)buttonLose:(id)sender {
    NSLog(@"LOSE");
    Step++;
    Balance -= Amount;
    Amount = 100.0 * (((WinBalance-(StartAmount*(Step-1))) + (StartAmount*((Profit) / 100.0))*Step) - (Balance - StartAmount*(Step-1))) / Profit;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    [self Print];
    proTextFieldProfit.enabled = false;
    protextFieldBalance.enabled = false;
    proTextFieldAmount.enabled = false;
    minBalance.enabled = false;
    pluBalance.enabled = false;
    minAmount.enabled = false;
    pluAmount.enabled = false;
}

- (IBAction)buttonWin:(id)sender {
    NSLog(@"WIN");
    Balance -= Amount;
    Balance += Amount*((100 + Profit)/100.0);
    WinBalance = Balance;
    Amount = StartAmount;
    Step = 1;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    [self Print];
    proTextFieldProfit.enabled = true;
    protextFieldBalance.enabled = true;
    proTextFieldAmount.enabled = true;
    minBalance.enabled = true;
    pluBalance.enabled = true;
    minAmount.enabled = true;
    pluAmount.enabled = true;
}
//------------------------------------------------------------------------------
#pragma mark -/+

- (IBAction)minBalance:(id)sender {
    Balance-=100;
    WinBalance = Balance;
    NSLog(@"- Balance");
    [self Print];
}

- (IBAction)pluBalance:(id)sender {
    Balance+=100;
    WinBalance = Balance;
    NSLog(@"+ Balance");
    [self Print];
}

- (IBAction)minAmount:(id)sender {
    Amount-=100;
    NSLog(@"- Amount");
    StartAmount = Amount;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", round(Amount)/100];
    [self Print];
}

- (IBAction)pluAmount:(id)sender {
    Amount+=100;
    NSLog(@"+ Amount");
    StartAmount = Amount;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", round(Amount)/100];
    [self Print];
}

//------------------------------------------------------------------------------
#pragma mark TextField Balance
- (IBAction)textFieldBalanceEditingDidBegin:(id)sender {
    NSLog(@"textFieldBalanceEditingDidBegin");
    //protextFieldBalance.text = [NSString stringWithFormat:@"%g", Balance];
}

- (IBAction)textFieldBalanceEditingChanged:(id)sender {
    NSLog(@"textFieldBalanceEditingChanged");
}

- (IBAction)textFieldBalanceEditingEnd:(id)sender {
    NSLog(@"textFieldBalanceEditingEnd");
    Balance = [textFieldBalance.text doubleValue];
    WinBalance = Balance;
    [self Print];
    protextFieldBalance.placeholder = protextFieldBalance.text;
}
//------------------------------------------------------------------------------
#pragma mark TextField Amount

- (IBAction)textFieldAmountEditingDidBegin:(id)sender {
    NSLog(@"textFieldAmountEditingDidBegin");
    //proTextFieldAmount.text = [NSString stringWithFormat:@"%g", Amount];
}

- (IBAction)textFieldAmountEditingChanged:(id)sender {
    
    NSLog(@"textFieldAmountEditingChanged");
}

- (IBAction)textFieldAmountEditingEnd:(id)sender {
    NSLog(@"textFieldAmountEditingEnd");
    Amount = [textFieldAmount.text doubleValue];
    StartAmount = Amount;
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", round(Amount)/100];
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    [self Print];
    proTextFieldAmount.placeholder = proTextFieldAmount.text;
}
//------------------------------------------------------------------------------
#pragma mark Textfield Profit

- (IBAction)textFieldProfitEditingChanged:(id)sender {
    proTextFieldProfit.placeholder = proTextFieldProfit.text;
    Profit = [textFieldProfit.text intValue];
}

- (IBAction)textFieldProfitEditingDidEnd:(id)sender {
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    [self Print];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.proTextFieldProfit isFirstResponder]) {
        NSString *returnProfit = [textFieldProfit.text stringByReplacingCharactersInRange:range withString:string];
        return [returnProfit length] <=2;}
    else if ([self.protextFieldBalance isFirstResponder]) return YES;
    else if ([self.proTextFieldAmount isFirstResponder]) return YES;
    else return YES;
}
//------------------------------------------------------------------------------
#pragma mark Print

-(void)Print{
    proLabelProfit.text = [NSString stringWithFormat:@"%g", round(profitAmount)/100];
    proLabelAmount.text = [NSString stringWithFormat:@"$%g", round(Amount)/100];
    protextFieldBalance.text = [NSString stringWithFormat:@"%g", round(Balance)/100];
}

@end
