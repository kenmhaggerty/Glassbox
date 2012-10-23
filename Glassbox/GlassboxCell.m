//
//  GlassboxCell.m
//  Glassbox
//
//  Created by Ken M. Haggerty on 10/23/12.
//  Copyright (c) 2012 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "GlassboxCell.h"

@implementation GlassboxCell

#pragma mark - // SETTERS AND GETTERS //

@synthesize name = _name;
@synthesize action = _action;
@synthesize time = _time;
@synthesize photo = _photo;

#pragma mark - // INITS AND LOADS //

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark - // PRIVATE FUNCTIONS //

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
