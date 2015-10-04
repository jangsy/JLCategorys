//
//  UIView+JLAdditions.h
//  JLCategory
//
//  Created by Jangsy on 2015. 10. 4..
//  Copyright © 2015년 Dalkomm. All rights reserved.
//

#import <UIKit/UIKit.h>

#define UIViewAutoresizingFlexibleSize UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight
#define UIViewAutoresizingFlexibleAllMargin UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin

@interface UIView (Additions)

+ (id)viewWithNibNamed:(NSString*)nibNameOrNil;

@end
