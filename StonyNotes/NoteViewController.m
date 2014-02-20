//
//  NoteViewController.m
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "NoteViewController.h"
#import "AppDelegate.h"
#import "NSString+Category.h"

@implementation NoteViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    //self.title = _note.title;
    self.textView.text = _note.noteText;
    
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:@selector(doneButtonHit:)];
    self.navigationItem.rightBarButtonItem = doneButton;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if(_note == nil)
        [_textView becomeFirstResponder];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(_note) {
        _note.noteText = _textView.text;
    }
    else if([_textView.text removeAllExtraWhiteSpace].length>0) {
        self.note = [Note makeNewNote];
    }
    
    _note.noteText = _textView.text;
    _note.title = [_note.noteText firstSentence];
    [[AppDelegate sharedDelegate] saveContext];
}

#pragma mark - Actions

-(void)doneButtonHit:(id)sender {
    [_textView resignFirstResponder];
}

#pragma mark - Nib Name

+(NSString*)nibName {
    return IS_IPAD? @"NoteViewController-iPad" : @"NoteViewController";
}

@end
