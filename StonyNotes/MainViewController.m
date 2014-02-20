//
//  MainViewController.m
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import "MainViewController.h"
#import "Note.h"
#import "AppDelegate.h"
#import "NoteViewController.h"
#import "NSDate+Category.h"

@implementation MainViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Stony Notes";
    
    UIBarButtonItem *newNoteButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStyleBordered target:self action:@selector(newNoteButtonHit:)];
    self.navigationItem.rightBarButtonItem = newNoteButton;
    
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Note"];
    NSSortDescriptor *sortOnDateAdded = [NSSortDescriptor sortDescriptorWithKey:@"timeAdded" ascending:YES];
    [request setSortDescriptors:@[sortOnDateAdded]];
    request.fetchBatchSize = 20;
    
    self.fetchController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:[AppDelegate sharedDelegate].managedObjectContext sectionNameKeyPath:nil cacheName:@"Notes"];
    _fetchController.delegate = self;
    [_fetchController performFetch:nil];
}

-(void)presentViewControllerForNote:(Note*)note {
    NoteViewController *noteTextViewController = [[NoteViewController alloc] initWithNibName:[NoteViewController nibName] bundle:nil];
    noteTextViewController.note = note;
    [self.navigationController pushViewController:noteTextViewController animated:YES];
}

#pragma mark - IBActions

-(void)newNoteButtonHit:(id)sender {
    [self presentViewControllerForNote:nil];
}

#pragma mark - Nib Name

+(NSString*)nibName {
    return IS_IPAD? @"MainViewController-iPad" : @"MainViewController";
}

#pragma mark - Table View

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_fetchController.sections[0] numberOfObjects];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Note *note = [_fetchController objectAtIndexPath:indexPath];
    cell.textLabel.text = note.title;
    NSString *dateString = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    if([note.timeAdded isToday])
        [dateFormatter setDateFormat:@"h:mm a"];
    else
        [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    
    dateString = [dateFormatter stringFromDate:note.timeAdded];
    
    cell.detailTextLabel.text= dateString;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Note *note = [_fetchController objectAtIndexPath:indexPath];
    [self presentViewControllerForNote:note];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Note *note = [_fetchController objectAtIndexPath:indexPath];
        [[AppDelegate sharedDelegate].managedObjectContext deleteObject:note];
        [[AppDelegate sharedDelegate] saveContext];
    }
}

#pragma mark - Fetched Results Controller

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id )sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

@end
