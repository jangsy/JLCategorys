//
//  UIDevice+IdentifierAddition.m
//  JLCategory
//
//  Created by Jangsy7883 on 11. 9. 5..
//  Copyright © 2012년 Dalkomm Apps. All rights reserved.
//

#import "UIDevice+JLAdditions.h"

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#include <ifaddrs.h>
#include <arpa/inet.h>

@implementation UIDevice (Additions)

#pragma mark - getters

- (unsigned long long)systemTotalSize
{
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:paths.lastObject error: &error];
    
	if (error) {
		NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", error.domain, (long)error.code);
	}else{
		if (dictionary) {
			NSNumber *sizeInBytes = dictionary[NSFileSystemSize];
			return sizeInBytes.unsignedLongLongValue;
		}
	}
	return 0;
}

- (unsigned long long)systemFreeSize
{
    NSError *error = nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSDictionary *dictionary = [[NSFileManager defaultManager] attributesOfFileSystemForPath:paths.lastObject error: &error];
    
	if (error) {
		NSLog(@"Error Obtaining System Memory Info: Domain = %@, Code = %ld", error.domain, (long)error.code);
	}else{
		if (dictionary) {
			NSNumber *sizeInBytes = dictionary[NSFileSystemFreeSize];
			return sizeInBytes.unsignedLongLongValue;
		}
	}
	return 0;
}

#pragma mark - ip Address

- (NSString *)ipAddressForInterface:(NSString *)interface
{
    BOOL success;
    struct ifaddrs * addrs;
    const struct ifaddrs * cursor;
    success = getifaddrs(&addrs) == 0;
    if (success) {
        cursor = addrs;
        while (cursor != NULL) {
            if (cursor->ifa_addr->sa_family == AF_INET && (cursor->ifa_flags & IFF_LOOPBACK) == 0)
            {
                NSString *name = @(cursor->ifa_name);
                if ([name isEqualToString:interface])  // Wi-Fi adapter
                    return @(inet_ntoa(((struct sockaddr_in *)cursor->ifa_addr)->sin_addr));
            }
            cursor = cursor->ifa_next;
        }
        freeifaddrs(addrs);
    }
    return nil;
}

- (NSString *)ipAddressForWiFi
{
    return [self ipAddressForInterface:@"en0"];
}

- (NSString *)ipAddressForCellular
{
    return [self ipAddressForInterface:@"pdp_ip0"];
}

@end
