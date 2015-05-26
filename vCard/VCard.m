//
//  VCard.m
//  vCard
//
//  Created by Nicolas Rizk on 5/26/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "VCard.h"


@import AddressBook;
@implementation VCard

// OPTION 1 - create a string vCard Representation
+ (void)createStringvCardWithFullName: (NSString *)name
                          PhoneNumber: (NSString *)phoneNumber
                                Email: (NSString *)email
                  WithCompletionBlock: (void (^)(NSData *vCard))completionBlock
{
    
    NSMutableArray *vCardArray = [[NSMutableArray alloc] init];
    
    NSArray *nameArray = [VCard contactName:name];
    
    [vCardArray addObject:@"BEGIN:VCARD"];
    [vCardArray addObject:@"VERSION:2.1"];
    
    if (name) {
        [vCardArray addObject:[NSString stringWithFormat:@"N:%@;%@;;;", nameArray[1], nameArray[0]]];
    }
    
    if (phoneNumber) {
        [vCardArray addObject:[NSString stringWithFormat:@"TEL;MAIN:%@", phoneNumber]];
    }
    
    if (email) {
        [vCardArray addObject:[NSString stringWithFormat:@"EMAIL:%@", email]];
    }
    
    [vCardArray addObject:@"END:VCARD"];
    
    NSString *string = [vCardArray componentsJoinedByString:@"\n"];
    
    completionBlock ([string dataUsingEncoding:NSUTF8StringEncoding]);
}



// OPTION 2 - create Address Book vCard Representation
+ (void)createABvCardWithFullName: (NSString *)name
                      PhoneNumber: (NSString *)phoneNumber
                            Email: (NSString *)email
              WithCompletionBlock: (void (^)(NSData *vCard))completionBlock
{
    
    ABRecordRef contact = [VCard createAddressBookContactFromWithName:name PhoneNumber:phoneNumber Email:email];
    
    ABRecordRef people[1];
    people[0] = contact;
    
    CFArrayRef arrayWithContact = CFArrayCreate(NULL, (void *)people, 1, &kCFTypeArrayCallBacks);
    
    completionBlock(CFBridgingRelease(ABPersonCreateVCardRepresentationWithPeople(arrayWithContact)));
    
}


+ (ABRecordRef)createAddressBookContactFromWithName: (NSString *)name
                                        PhoneNumber: (NSString *)phoneNumber
                                              Email: (NSString *)email

{
    NSArray *nameArray = [VCard contactName:name];
    
    
    ABRecordRef contact = ABPersonCreate();
    
    if (name) {
        ABRecordSetValue(contact, kABPersonFirstNameProperty, (__bridge CFStringRef)nameArray[0], nil);
        ABRecordSetValue(contact, kABPersonLastNameProperty, (__bridge CFStringRef)nameArray[1], nil);
    }
    
    if (phoneNumber) {
        ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)phoneNumber, kABPersonPhoneMainLabel, NULL);
        
        ABRecordSetValue(contact, kABPersonPhoneProperty, phoneNumbers, nil);
    }
    
    if (email) {
        CFStringRef emailTitle = CFSTR("Email"); // allows you to specify what type of email (main, work, or just plain Email)
        
        ABMutableMultiValueRef emails = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        ABMultiValueAddValueAndLabel(emails, (__bridge CFStringRef)email, emailTitle, NULL);
        
        ABRecordSetValue(contact, kABPersonEmailProperty, emails, nil);
    }
    
    return contact;
}


// Helpers

+ (NSString *)fileName:(NSString *)name {
    
    return [NSString stringWithFormat:@"%@.vcf", name];
}

+ (NSArray *)contactName:(NSString *)name {
    NSString *firstName;
    NSString *lastName;
    
    if ([name containsString:@" "]) {
        NSArray *nameArray = [name componentsSeparatedByString:@" "];
        
        firstName = nameArray[0];
        lastName = nameArray[1];
    } else {
        firstName = name;
        lastName = @"";
    }
    
    return [NSArray arrayWithObjects:firstName, lastName, nil];
}



@end
