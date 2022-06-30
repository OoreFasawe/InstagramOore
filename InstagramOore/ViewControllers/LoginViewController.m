//
//  LoginViewController.m
//  InstagramOore
//
//  Created by Oore Fasawe on 6/27/22.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)registerUser:(id)sender {
    if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]){
        [self showAlert];
    }
    else{
    PFUser *newUser = [PFUser user];
    
    newUser.username = self.usernameField.text;
    newUser.password = self.passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            
        }
    }];
}
}
- (IBAction)loginUser:(id)sender {
    NSString *username = self.usernameField.text;
    NSString *password = self.passwordField.text;
    
if([self.usernameField.text isEqual:@""] || [self.passwordField.text isEqual:@""]){
    [self showAlert];
    
}
else{
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * user, NSError *  error) {
        if (error != nil) {
        } else {
            [self performSegueWithIdentifier:@"loginSegue" sender:nil];
            
        }
    }];
}
}
-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)" message:@"Enter a username and password" preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    
    [self presentViewController:alert animated:YES completion:^{}];
}

@end
