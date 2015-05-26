//
//  Messenger.h
//  vCard
//
//  Created by Nicolas Rizk on 5/26/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MessageUI;

@interface Messenger : NSObject

// OPTION 1
+ (void)sendUsingOption1: (MFMailComposeViewController *)controller
                FromName: (NSString *)name
             PhoneNumber: (NSString *)phoneNumber
                   Email: (NSString *)email
     WithCompletionBlock: (void (^)())completionBlock;

//OPTION 2
+ (void)sendUsingOption2: (MFMailComposeViewController *)controller
                FromName: (NSString *)name
             PhoneNumber: (NSString *)phoneNumber
                   Email: (NSString *)email
     WithCompletionBlock: (void (^)())completionBlock;

@end
