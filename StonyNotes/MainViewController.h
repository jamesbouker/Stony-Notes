//
//  MainViewController.h
//  StonyNotes
//
//  Created by Jimmy on 1/26/14.
//  Copyright (c) 2014 JimmyBouker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <NibNameProtocol, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate> {
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSFetchedResultsController *fetchController;

@end
