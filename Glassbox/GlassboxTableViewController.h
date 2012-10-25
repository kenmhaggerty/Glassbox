//
//  GlassboxTableViewController.h
//  Glassbox
//
//  Created by Ken M. Haggerty on 10/22/12.
//  Copyright (c) 2012 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>

#pragma mark - // PROTOCOLS //

//@protocol GlassboxTableViewDatasource <NSObject>
//@property (nonatomic, weak) NSMutableArray *arrayOfPlayers;
//@end

#pragma mark - // DEFINITIONS (Public) //

@interface GlassboxTableViewController : UITableViewController
@property (nonatomic, strong) NSMutableArray *arrayOfPlayers;
- (IBAction)addPlayer:(UIBarButtonItem *)sender;
//@property (nonatomic, strong) id <GlassboxTableViewDatasource> datasource;
@end