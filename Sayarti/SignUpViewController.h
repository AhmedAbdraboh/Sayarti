//
//  SignUpViewController.h
//  Sayarti
//
//  Created by Admin on 5/16/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownPicker.h"

@interface SignUpViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *activeField;
    UIGestureRecognizer *tapper;
}

//picker for user type
@property (strong, nonatomic) DownPicker *userTypeDownPicker;


//user type text field
@property (weak, nonatomic) IBOutlet UITextField *userTypeTextField;

//Scroll View Property
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

//user Name Text Field
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;


//Email Text Field
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;


//Mobile Text Field
@property (weak, nonatomic) IBOutlet UITextField *mobileTextField;


//Country Text Field
@property (weak, nonatomic) IBOutlet UITextField *countryTextField;
//down picker property for country
@property (strong, nonatomic) DownPicker *countryDownPicker;

//City Text Field
@property (weak, nonatomic) IBOutlet UITextField *cityTextField;
//down picker property for country
@property (strong, nonatomic) DownPicker *cityDownPicker;


//Password Text Field
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


//Confirm Password Text Field
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

//checkbox Button
@property (weak, nonatomic) IBOutlet UIButton *checkBoxButton;

//continue button
@property (weak, nonatomic) IBOutlet UIButton *continueButton;

//agree label
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;

@end
