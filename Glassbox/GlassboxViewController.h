//
//  GlassboxViewController.h
//  Glassbox
//
//  Created by Ken M. Haggerty on 10/23/12.
//  Copyright (c) 2012 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Public) //

#pragma mark - // IMPORTS (Public) //

#import <UIKit/UIKit.h>

#pragma mark - // PROTOCOLS //

#pragma mark - // DEFINITIONS (Public) //

@interface GlassboxViewController : UIViewController
@property (nonatomic, strong) NSMutableArray *arrayOfPlayers;
- (IBAction)addPlayer:(UIBarButtonItem *)sender;
@end
