//
//  Messenger.m
//  vCard
//
//  Created by Nicolas Rizk on 5/26/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "Messenger.h"
#import "VCard.h"

@implementation Messenger

+ (void)sendUsingOption1: (MFMailComposeViewController *)controller
                FromName: (NSString *)name
             PhoneNumber: (NSString *)phoneNumber
                   Email: (NSString *)email
     WithCompletionBlock: (void (^)())completionBlock
{
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSString *vCardFileName = [NSString stringWithFormat:@"%@", name];
        
        [VCard createStringvCardWithFullName:name PhoneNumber:phoneNumber Email:email WithCompletionBlock:^(NSData *vCard) {
            
            [controller addAttachmentData:vCard mimeType:@"text/vcard" fileName:[VCard fileName:vCardFileName]];
        }];
        
        completionBlock();
        
    }
}

+ (void)sendUsingOption2: (MFMailComposeViewController *)controller
                FromName: (NSString *)name
             PhoneNumber: (NSString *)phoneNumber
                   Email: (NSString *)email
     WithCompletionBlock: (void (^)())completionBlock
{
    
    if ([MFMailComposeViewController canSendMail]) {
        
        NSString *vCardFileName = [NSString stringWithFormat:@"%@", name];
        
        [VCard createABvCardWithFullName:name PhoneNumber:phoneNumber Email:email WithCompletionBlock:^(NSData *vCard) {
            
            [controller addAttachmentData:vCard mimeType:@"text/vcard" fileName:[VCard fileName:vCardFileName]];
        }];
        
        completionBlock();
        
    }
}

@end
