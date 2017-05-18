//
//  SignUpViewController.m
//  Sayarti
//
//  Created by Admin on 5/16/17.
//  Copyright © 2017 Admin. All rights reserved.
//

#import "SignUpViewController.h"

@interface SignUpViewController ()
{
    BOOL checkTerms;
    
}

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    checkTerms = false;
    // a single tap will be used to dismiss keyboard
    /*TagGestureRecognizer Start*/
    tapper = [[UITapGestureRecognizer alloc]
              initWithTarget:self action:@selector(handleSingleTap:)];
    tapper.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper];
    /*TagGestureRecognizer End*/
    
    

    
    // create the array of user type
    NSMutableArray* userTypeArray = [[NSMutableArray alloc] init];
    
    // create the array of countries
    NSMutableArray* countryArray = [[NSMutableArray alloc] init];
    

    
    // add some sample data
    [userTypeArray addObject:NSLocalizedString(@"userA", @"A user A Type")];
    [userTypeArray addObject:NSLocalizedString(@"userB", @"A userB Type")];
    [userTypeArray addObject:NSLocalizedString(@"userC", @"A userC Type")];
    
    [countryArray addObject:NSLocalizedString(@"egypt", @"A country in coutries array")];
    [countryArray addObject:NSLocalizedString(@"saudi", @"A country in coutries array")];
    
    // bind userTypeTextField to userTypeDownPicker
    self.userTypeDownPicker = [[DownPicker alloc] initWithTextField:self.userTypeTextField withData:userTypeArray];
    
    /*bind countryTextField to countryDownPicker and bind value of country change to city
    down picker*/
    self.countryDownPicker=[[DownPicker alloc]initWithTextField:self.countryTextField withData:countryArray];
    [self.countryDownPicker addTarget:self
                            action:@selector(fillCitiesDownPicker:)
                  forControlEvents:UIControlEventValueChanged];
    
    //set place holder for pickers
    [self.userTypeDownPicker setPlaceholder:NSLocalizedString(@"userType", @"A place holder for the user type text field")];
    [self.countryDownPicker setPlaceholder:NSLocalizedString(@"country", @"A place holder for the country down picker")];
    [self.cityDownPicker setPlaceholder:NSLocalizedString(@"city", @"A place holder for the city down picker")];
    

    
    //Create title of View
    self.title=NSLocalizedString(@"signUpTitle", @"A title for the sign up screen");

    [self registerForKeyboardNotifications];
    
    //setting localizers for placeholders of textFields
    self.userNameTextField.placeholder=NSLocalizedString(@"userName", @"A place holder for user Name");
    self.emailTextField.placeholder=NSLocalizedString(@"email", @"A place holder for Email");
    self.mobileTextField.placeholder=NSLocalizedString(@"mobile", @"A place holder for mobile");
    self.cityTextField.placeholder=NSLocalizedString(@"city", @"A place holder for City");
    self.passwordTextField.placeholder=NSLocalizedString(@"password", @"A place holder for Password");
    self.confirmPasswordTextField.placeholder=NSLocalizedString(@"confirmPassword", @"A place holder for confirm password");
    
    self.agreeLabel.text=NSLocalizedString(@"agreeLabel", @"A text in agree Label");
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//checkBox Button Action

- (IBAction)checkBoxButtonAction:(id)sender {
    UIImage *checkImage=[UIImage imageNamed:@"check"];
    if (!checkTerms) {
        [self.checkBoxButton setBackgroundImage:checkImage forState:normal];
        checkTerms=true;
    }else{
        [self.checkBoxButton setBackgroundImage:nil forState:normal];
        checkTerms=false;
 
    }
    
}


- (IBAction)continueAction:(id)sender {
    
    //Alert Parameters Declaration
    NSString *alertMessage;
    UIAlertAction *okAction;

    
    
    //Get Form data
    NSString *userType=self.userTypeDownPicker.text;
    NSString *userName=self.userNameTextField.text;
    NSString *email=self.emailTextField.text;
    NSString *mobile=self.mobileTextField.text;
    NSString *country=self.countryDownPicker.text;
    NSString *city=self.cityDownPicker.text;
    NSString *password=self.passwordTextField.text;
    NSString *confirmPassword=self.confirmPasswordTextField.text;
    
    //validate user inputs
    BOOL userTypeUserInput=![userType isEqualToString:@""];
    BOOL userNameUserInput=![userName isEqualToString:@""];
    BOOL emailUserInput=[self isValidEmail:email];
    BOOL mobileUserInput=[self isValidMobileNumber:mobile];
    BOOL countryUserInput=![country isEqualToString:@""];
    BOOL cityUserInput=![city isEqualToString:@""];
    BOOL passwordUserInput=[self isValidPassword:password against:confirmPassword];
    
    if ( userTypeUserInput && userNameUserInput && emailUserInput && mobileUserInput && countryUserInput && cityUserInput && passwordUserInput && checkTerms) {
        alertMessage =NSLocalizedString(@"signUpSuccess", @"A title for the sign up success method");
        okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"A title for the ok title") style:UIAlertActionStyleDefault handler:nil];
    
    }else{
        alertMessage =NSLocalizedString(@"signUpfailure", @"A title for the sign up failure method");
        okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"ok", @"A title for the ok title") style:UIAlertActionStyleDefault handler:nil];
    }
    UIAlertController *signUpAlert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"signUptitleAlert", @"A title for the signUptitleAlert") message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    
    [signUpAlert addAction:okAction];
    [self presentViewController:signUpAlert animated:YES completion:^{}];

    
}

//method for email validation
- (BOOL)isValidEmail:(NSString*)email{
    //Regular Expression for Email Validation
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    //Predicates
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    BOOL emailValid = [emailTest evaluateWithObject:email];
    if (emailValid) {
        return true;
    }else{
        return false;
    }
}

//method for password confirmation
- (BOOL)isValidPassword:(NSString*)password against:(NSString*)confirmPassword{
    BOOL passwordValid = [password isEqualToString:confirmPassword];
    if (passwordValid) {
        return true;
    }
    return false;
}

//method for mobile validation
-(BOOL)isValidMobileNumber:(NSString*)mobile{
    NSString *numRegex = @"^[0-9]+$";
    //Predicates
    NSPredicate *mobileTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numRegex];
    
    BOOL mobileValid = [mobileTest evaluateWithObject:mobile];
    if (mobileValid) {
        return true;
    }else{
        return false;
    }

    
}
/*Keyboard code*/
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

/*Keyboard code End*/

/*HandleTapGesture Start*/
- (void)handleSingleTap:(UITapGestureRecognizer *) sender
{
    [self.view endEditing:YES];
}
/*HandleTapGesture Start*/


-(void)fillCitiesDownPicker:(id)dp {
    
    NSDictionary *cities =@{NSLocalizedString(@"egypt", @"Egypt"):@[NSLocalizedString(@"cairo", @"A city in Egypt"),NSLocalizedString(@"alex", @"A city in Egypt"),NSLocalizedString(@"dumyat", @"A city in Egypt"),NSLocalizedString(@"mansoura", @"A city in Egypt")],
                                       NSLocalizedString(@"saudi", @"Saudi Arabia"):@[NSLocalizedString(@"geddah", @"A city in Saudi"),NSLocalizedString(@"riaddah", @"A city in Saudi"),NSLocalizedString(@"mekkah", @"A city in Saudi")]
                                       
                                       };
    
    NSString* selectedValue = [self.countryDownPicker text];
    //bind cityTextField to cityDownPicker
    self.cityDownPicker = [[DownPicker alloc] initWithTextField:self.cityTextField withData:cities[selectedValue]];
    [self.cityDownPicker setPlaceholder:NSLocalizedString(@"city", @"A place holder for the city down picker")];
    [self.cityTextField setUserInteractionEnabled:YES];
    // do what you want
}

@end
