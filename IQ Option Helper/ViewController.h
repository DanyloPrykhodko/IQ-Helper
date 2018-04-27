//
//  ViewController.h
//  IQ Option Helper
//
//  Created by Danil Prykhodko on 29.12.15.
//  Copyright © 2015 DrPrykhodko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>{
    IBOutlet UITextField * textFieldProfit;
    IBOutlet UITextField * textFieldBalance;
    IBOutlet UITextField * textFieldAmount;
}


    @property (weak, nonatomic) IBOutlet UITextField * proTextFieldProfit;
    @property (weak, nonatomic) IBOutlet UITextField * proTextFieldBalance;
    @property (weak, nonatomic) IBOutlet UITextField * proTextFieldAmount;

    @property (weak, nonatomic) IBOutlet UILabel *proLabelProfit;
    @property (weak, nonatomic) IBOutlet UILabel *proLabelAmount;

    @property (weak, nonatomic) IBOutlet UIButton *minBalance;
    @property (weak, nonatomic) IBOutlet UIButton *pluBalance;
    @property (weak, nonatomic) IBOutlet UIButton *minAmount;
    @property (weak, nonatomic) IBOutlet UIButton *pluAmount;

    @property (weak, nonatomic) IBOutlet NSLayoutConstraint *layoutConstraintAmount;
    @property (weak, nonatomic) IBOutlet UILabel *labelLastAmount;


- (IBAction)textFieldProfitEditingChanged:(id)sender;
- (IBAction)textFieldProfitEditingDidEnd:(id)sender;

- (IBAction)textFieldBalanceEditingDidBegin:(id)sender;
- (IBAction)textFieldBalanceEditingChanged:(id)sender;
- (IBAction)textFieldBalanceEditingEnd:(id)sender;

- (IBAction)textFieldAmountEditingDidBegin:(id)sender;
- (IBAction)textFieldAmountEditingChanged:(id)sender;
- (IBAction)textFieldAmountEditingEnd:(id)sender;

- (IBAction)buttonLose:(id)sender;
- (IBAction)buttonWin:(id)sender;
- (IBAction)minBalance:(id)sender;
- (IBAction)pluBalance:(id)sender;
- (IBAction)minAmount:(id)sender;
- (IBAction)pluAmount:(id)sender;

@end

