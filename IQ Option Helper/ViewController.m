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

@implementation ViewController;

@synthesize proTextFieldProfit, proTextFieldAmount, proTextFieldBalance, proLabelProfit, proLabelAmount, minBalance, pluBalance, minAmount, pluAmount, layoutConstraintAmount, labelLastAmount;

//------------------------------------------------------------------------------
#pragma mark Glodal Variables

//Balance
double winBalance = 0;
double Balance = 0;

//Amount
double startAmount = 0;
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
    
    UITextField *balanceTextField = (UITextField*)textFieldBalance;
    UITextField *amountTextField = (UITextField*)textFieldAmount;
    UITextField *profitTextField = (UITextField*)textFieldProfit;
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@" Done\t\t" style:UIBarButtonItemStyleDone target:self action:@selector(doneButton)];
    UIToolbar *tipToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 414, 233)];
    tipToolbar.barStyle = UIBarStyleBlack;
    tipToolbar.items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], doneButton, nil];
    [tipToolbar sizeToFit];
    
    balanceTextField.inputAccessoryView = tipToolbar;
    amountTextField.inputAccessoryView = tipToolbar;
    profitTextField.inputAccessoryView = tipToolbar;
    
    [textFieldProfit setFont:[UIFont fontWithName:@"Roboto-Light" size:94]];
    [labelLastAmount setFont:[UIFont fontWithName:@"Roboto-Light" size:17]];
}

-(void)doneButton{
    NSLog(@"Done Button");
    [textFieldBalance resignFirstResponder];
    [textFieldAmount resignFirstResponder];
    [textFieldProfit resignFirstResponder];
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
    NSLog(@"Lose Button");
    if (Amount<=Balance&&Amount>=100&&Balance>=100) {
        Step++;
        Balance -= Amount;
        Amount = 100.0 * (((winBalance - (startAmount * (Step - 1))) + (startAmount * ((Profit) / 100.0)) /** Step*/) - (Balance - startAmount * (Step - 1))) / Profit;
        [self ss];
        profitAmount = Amount * ((100 + Profit) / 100.0);
        [self Print];
        proTextFieldProfit.enabled = false;
        proTextFieldBalance.enabled = false;
        proTextFieldAmount.enabled = false;
        minBalance.enabled = false;
        pluBalance.enabled = false;
        minAmount.enabled = false;
        pluAmount.enabled = false;
        if (Balance < 100){
            winBalance = 0;
            Balance = 0;
            startAmount = 0;
            Amount = 0;
            Profit = 99;
            profitAmount = 0;
            Step = 1;
            [self Print];
            UIAlertController* zero = [UIAlertController alertControllerWithTitle:@"Balance is empty" message:@"Balance is more low than the minimum deposit" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* def = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {}];
            proTextFieldProfit.enabled = true;
            proTextFieldBalance.enabled = true;
            proTextFieldAmount.enabled = true;
            minBalance.enabled = true;
            pluBalance.enabled = true;
            minAmount.enabled = true;
            pluAmount.enabled = true;
            layoutConstraintAmount.constant = 183;
            labelLastAmount.alpha = 0;
            [zero addAction:def];
            [self presentViewController:zero animated:YES completion:nil];
            textFieldBalance.text = 0;
            textFieldAmount.text = 0;
            proTextFieldAmount.placeholder = [NSString stringWithFormat:@"%g", Amount];
            proTextFieldBalance.placeholder = [NSString stringWithFormat:@"%g", Balance];
        }
    }
}

- (IBAction)buttonWin:(id)sender {
    NSLog(@"Win Button");
    if (Amount<=Balance&&Amount>=100&&Balance>=100) {
        layoutConstraintAmount.constant = 183;
        labelLastAmount.alpha = 0;
        Balance -= Amount;
        Balance += Amount*((100 + Profit)/100.0);
        winBalance = Balance;
        Amount = startAmount;
        Step = 1;
        profitAmount = Amount * ((100 + Profit) / 100.0);
        [self Print];
        proTextFieldProfit.enabled = true;
        proTextFieldBalance.enabled = true;
        proTextFieldAmount.enabled = true;
        minBalance.enabled = true;
        pluBalance.enabled = true;
        minAmount.enabled = true;
        pluAmount.enabled = true;
    }
}
//------------------------------------------------------------------------------
#pragma mark -/+

- (IBAction)minBalance:(id)sender {
    if (Balance>100) Balance-=100;
    if (Balance<=100) Balance=0;
    winBalance = Balance;
    proTextFieldBalance.placeholder = proTextFieldBalance.text;
    NSLog(@"Balance -1");
    [self Print];
}

- (IBAction)pluBalance:(id)sender {
    Balance+=100;
    winBalance = Balance;
    proTextFieldBalance.placeholder = proTextFieldBalance.text;
    NSLog(@"Balance +1");
    [self Print];
}

- (IBAction)minAmount:(id)sender {
    if (Amount>100) Amount-=100;
    if (Amount<=100) Amount=0;
    startAmount = Amount;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", round(Amount)/100];
    proTextFieldAmount.placeholder = proTextFieldAmount.text;
    NSLog(@"Amount -1");
    [self Print];
}

- (IBAction)pluAmount:(id)sender {
    Amount+=100;
    startAmount = Amount;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", round(Amount)/100];
    proTextFieldAmount.placeholder = proTextFieldAmount.text;
    NSLog(@"Amount +1");
    [self Print];
}

//------------------------------------------------------------------------------
#pragma mark TextField Balance

- (IBAction)textFieldBalanceEditingDidBegin:(id)sender {
    NSLog(@"textFieldBalanceEditingDidBegin");
}

- (IBAction)textFieldBalanceEditingChanged:(id)sender {
    NSLog(@"textFieldBalanceEditingChanged");
}

- (IBAction)textFieldBalanceEditingEnd:(id)sender {
    Balance = [textFieldBalance.text doubleValue]*100;
    winBalance = Balance;
    proTextFieldBalance.placeholder = proTextFieldBalance.text;
    NSLog(@"textFieldBalanceEditingEnd");
    [self Print];
}

//------------------------------------------------------------------------------
#pragma mark TextField Amount

- (IBAction)textFieldAmountEditingDidBegin:(id)sender {
    NSLog(@"textFieldAmountEditingDidBegin");
}

- (IBAction)textFieldAmountEditingChanged:(id)sender {
    NSLog(@"textFieldAmountEditingChanged");
}

- (IBAction)textFieldAmountEditingEnd:(id)sender {
    Amount = [textFieldAmount.text doubleValue]*100;
    startAmount = Amount;
    proTextFieldAmount.text = [NSString stringWithFormat:@"%g", round(Amount)/100];
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    proTextFieldAmount.placeholder = proTextFieldAmount.text;
    NSLog(@"textFieldAmountEditingEnd");
    [self Print];
}

//------------------------------------------------------------------------------
#pragma mark Textfield Profit

- (IBAction)textFieldProfitEditingChanged:(id)sender {
    proTextFieldProfit.placeholder = proTextFieldProfit.text;
    Profit = [textFieldProfit.text intValue];
    NSLog(@"textFieldProfitEditingChanged");
}

- (IBAction)textFieldProfitEditingDidEnd:(id)sender {
    profitAmount = Amount * ((100 + Profit) / 100.0);
    profitAmount = round(profitAmount);
    NSLog(@"textFieldProfitEditingEnd");
    [self Print];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.proTextFieldProfit isFirstResponder]) {
        NSString *returnProfit = [textFieldProfit.text stringByReplacingCharactersInRange:range withString:string];
        return [returnProfit length] <=2;}
    else if ([self.proTextFieldBalance isFirstResponder]) return YES;
    else if ([self.proTextFieldAmount isFirstResponder]) return YES;
    else return YES;
}

//------------------------------------------------------------------------------
#pragma mark Print

-(void)Print{
    NSLog(@"Print");
    proLabelProfit.text = [NSString stringWithFormat:@"$%g", round(profitAmount)/100];
    proLabelAmount.text = [NSString stringWithFormat:@"$%g", round(Amount)/100];
    proTextFieldBalance.text = [NSString stringWithFormat:@"%g", round(Balance)/100];
}

-(void)ss{
    NSLog(@"SS");
    if (Balance<Amount) {
        layoutConstraintAmount.constant = 165;
        labelLastAmount.alpha = 1;
        int outAmount = Amount;
        Amount = Balance;
        double winBack = round((Amount*(100+Profit)/100)/(outAmount*(100+Profit)/100)*100);
        labelLastAmount.text = [NSString stringWithFormat:@"Win back %g%%",winBack];
    }
}

@end
