//
//  VCard.h
//  vCard
//
//  Created by Nicolas Rizk on 5/26/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCard : NSObject

+ (NSString *)fileName:(NSString *)name;

// OPTION 1
+ (void)createStringvCardWithFullName: (NSString *)name
                          PhoneNumber: (NSString *)phoneNumber
                                Email: (NSString *)email
                  WithCompletionBlock: (void (^)(NSData *vCard))completionBlock;


// OPTION 2
+ (void)createABvCardWithFullName: (NSString *)name
                      PhoneNumber: (NSString *)phoneNumber
                            Email: (NSString *)email
              WithCompletionBlock: (void (^)(NSData *vCard))completionBlock;
@end
