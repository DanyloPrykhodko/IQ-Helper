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

#pragma mark Glodal Variables

//Balance
double WinBalance = 0;
double Balance = 0;
int firstBalance;
int secondBalance;

//Amount
double StartAmount = 0;
double Amount = 0;
int firstAmount;
int secondAmount;

//Profit
int Profit = 99;
double profitAmount = 0;

//Support
int Step = 1;

#pragma mark ViewDid Load

- (void)viewDidLoad {
    [self setNeedsStatusBarAppearanceUpdate];
    textFieldProfit.delegate = self;
    textFieldBalance.delegate = self;
    textFieldAmount.delegate = self;
    [super viewDidLoad];
    textFieldBalance.keyboardType = UIKeyboardTypeDecimalPad;
    textFieldAmount.keyboardType = UIKeyboardTypeDecimalPad;
    
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = @[[[UIBarButtonItem alloc]initWithTitle:@"\t Cancel \t" style:UIBarButtonItemStylePlain target:self action:@selector(cancelNumberPad)],
                            [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                            [[UIBarButtonItem alloc]initWithTitle:@"\t  Done    \t" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)]];
    [numberToolbar sizeToFit];
    
    textFieldProfit.inputAccessoryView = numberToolbar;
    textFieldAmount.inputAccessoryView = numberToolbar;
    textFieldBalance.inputAccessoryView = numberToolbar;
    [self update];
    [textFieldProfit setFont:[UIFont fontWithName:@"Roboto-Light" size:94]];
}

-(void)cancelNumberPad{
    if ([self.proTextFieldProfit isFirstResponder]) {
        textFieldProfit.text = [NSString stringWithFormat: @"%d",Profit];
        [textFieldProfit resignFirstResponder];
    }else if ([self.proTextFieldAmount isFirstResponder]){
        textFieldAmount.text = [NSString stringWithFormat: @"%g",Amount];
        [textFieldAmount resignFirstResponder];
    }else if ([self.protextFieldBalance isFirstResponder]){
        textFieldBalance.text = [NSString stringWithFormat: @"%g",Balance];
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

#pragma mark LOSE/WIN

- (IBAction)buttonLose:(id)sender {
    NSLog(@"LOSE");
    Step++;
    Balance -= Amount;
    Amount = 100.0 * (((WinBalance-(StartAmount*(Step-1))) + (StartAmount*((Profit) / 100.0))*Step) - (Balance - StartAmount*(Step-1))) / Profit;
    profitAmount = Amount * ((100 + Profit) / 100.0);
    proTextFieldAmount.textColor = [UIColor redColor];
    [self updateS];
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

#pragma mark -/+

- (IBAction)minBalance:(id)sender {
    Balance--;
    NSLog(@"- Balance");
    [self updateS];
}

- (IBAction)pluBalance:(id)sender {
    Balance++;
    NSLog(@"+ Balance");
    [self updateS];
}

- (IBAction)minAmount:(id)sender {
    Amount--;
    NSLog(@"- Amount");
    [self updateS];
}

- (IBAction)pluAmount:(id)sender {
    Amount++;
    NSLog(@"+ Amount");
    [self updateS];
}

#pragma mark TextFields

// TextField Return

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textFieldProfit resignFirstResponder];
    [textFieldBalance resignFirstResponder];
    [textFieldAmount resignFirstResponder];
    return YES;
}

//TextField Amount

- (IBAction)textFieldBalanceEditingChanged:(id)sender {
    protextFieldBalance.placeholder = protextFieldBalance.text;
    [self update];
    WinBalance = Balance;
}

//TextField Amount

- (IBAction)textFieldAmountEditingChanged:(id)sender {
    proTextFieldAmount.placeholder = proTextFieldAmount.text;
    [self update];
    StartAmount = [textFieldAmount.text doubleValue];
    profitAmount = Amount * ((100 + Profit) / 100.0);
    proLabelProfit.text = [NSString stringWithFormat:@"%g", profitAmount];
    proLabelAmount.text = [NSString stringWithFormat:@"$%g", Amount];
}

//TextField Profit

- (IBAction)textFieldProfitEditingChanged:(id)sender {
    proTextFieldProfit.placeholder = proTextFieldProfit.text;
    [self update];
}

//Limitation

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.proTextFieldProfit isFirstResponder]) {
        NSString *returnProfit = [textFieldProfit.text stringByReplacingCharactersInRange:range withString:string];
        return [returnProfit length] <=2;
    }else if ([self.protextFieldBalance isFirstResponder]){
        return YES;
    }else if ([self.proTextFieldAmount isFirstResponder]){
        return YES;
    } else
        return YES;
}

#pragma mark Updates

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
