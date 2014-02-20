//
//  Note.m
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "Note.h"
#import "GUID.h"
#import "AppDelegate.h"

@implementation Note

@dynamic noteText;
@dynamic title;
@dynamic timeAdded;
@dynamic guid;

+(Note*)makeNewNote {
    Note *newNote = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:[AppDelegate sharedDelegate].managedObjectContext];
    newNote.title = @"Untitled Note";
    newNote.timeAdded = [NSDate date];
    newNote.noteText = @"TESTING TEXT";
    newNote.guid = MAKE_GUID();
    
    [[AppDelegate sharedDelegate] saveContext];
    
    return newNote;
}

@end
