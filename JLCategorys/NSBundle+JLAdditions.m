//
//  NSBundle+JLAdditions.m
//  JLCategory
//
//  Created by Jangsy on 2015. 10. 4..
//  Copyright © 2015년 Dalkomm. All rights reserved.
//

#import "NSBundle+JLAdditions.h"

@implementation NSBundle (Additions)

- (NSString*)appVersion
{
    return self.infoDictionary[@"CFBundleShortVersionString"];
}

- (NSString*)buildVersion
{
    return self.infoDictionary[(NSString*)kCFBundleVersionKey];

}

@end
