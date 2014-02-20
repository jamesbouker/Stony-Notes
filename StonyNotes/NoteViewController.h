//
//  NoteViewController.h
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface NoteViewController : UIViewController <NibNameProtocol> {
    
}

@property (nonatomic, strong) IBOutlet UITextView *textView;
@property (nonatomic, strong) Note *note;

@end
