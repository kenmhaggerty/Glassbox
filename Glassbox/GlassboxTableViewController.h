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

@protocol GlassboxTableViewDelegate <NSObject>
@property (nonatomic, weak) NSMutableArray *arrayOfPlayers;
- (void)addPlayer;
@end

#pragma mark - // DEFINITIONS (Public) //

@interface GlassboxTableViewController : UITableViewController
@property (nonatomic, strong) id <GlassboxTableViewDelegate> datasource;
- (IBAction)addPlayer;
@end