//
//  Note.h
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * noteText;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * timeAdded;
@property (nonatomic, retain) NSString *guid;

+(Note*)makeNewNote;

@end
