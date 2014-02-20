//
//  NSString+Category.m
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

-(NSString*)firstSentence {
    NSString *noWhiteSpace = [self removeExtraWhiteSpace];
    NSArray *lines = [noWhiteSpace componentsSeparatedByString:@"\n"];
    if(lines && lines.count>0)
        return lines[0];
    else
        return self;
}

-(NSString*)removeExtraWhiteSpace {
    return [[[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self != ''"]] componentsJoinedByString:@" "];
}

-(NSString*)removeAllExtraWhiteSpace {
    return [[[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self != ''"]] componentsJoinedByString:@" "];
}

@end
