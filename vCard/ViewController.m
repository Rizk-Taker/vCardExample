//
//  ViewController.m
//  vCard
//
//  Created by Nicolas Rizk on 5/26/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "ViewController.h"
#import "Messenger.h"
@import MessageUI;

@interface ViewController () <MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *numberTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (strong, nonatomic) MFMailComposeViewController *mailViewController;

- (IBAction)option1Tapped:(id)sender;
- (IBAction)option2Tapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mailViewController = [[MFMailComposeViewController alloc] init];
    [self.mailViewController setMailComposeDelegate:self];

}

- (IBAction)option1Tapped:(id)sender {

    [Messenger sendUsingOption1:self.mailViewController
                       FromName:self.nameTF.text
                    PhoneNumber:self.numberTF.text
                          Email:self.emailTF.text
            WithCompletionBlock:^{
                
        [self presentViewController:self.mailViewController animated:YES completion:nil];
    }];
}

- (IBAction)option2Tapped:(id)sender {

    [Messenger sendUsingOption2:self.mailViewController
                       FromName:self.nameTF.text
                    PhoneNumber:self.numberTF.text
                          Email:self.emailTF.text
            WithCompletionBlock:^{
                
        [self presentViewController:self.mailViewController animated:YES completion:nil];
    }];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {

    [self dismissViewControllerAnimated:YES completion:nil];
    
}
@end
