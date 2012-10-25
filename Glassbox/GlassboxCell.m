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

#pragma mark - // DEFINITIONS (Private) //

@interface GlassboxCell ()
- (void)setup;
@end

@implementation GlassboxCell

#pragma mark - // SETTERS AND GETTERS //

@synthesize name = _name;
@synthesize action = _action;
@synthesize time = _time;
@synthesize photo = _photo;

#pragma mark - // INITS AND LOADS //

- (void)setup
{
    if (!self.name) self.name = (UILabel *)[self viewWithTag:1];
    if (!self.action) self.action = (UILabel *)[self viewWithTag:2];
    if (!self.time) self.time = (UILabel *)[self viewWithTag:3];
    if (!self.photo) self.photo = (UIImageView *)[self viewWithTag:4];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - // PRIVATE FUNCTIONS //

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setup];
    self.name.text = nil;
    self.action.text = nil;
    self.time.text = nil;
    self.photo.image = nil;
}

@end
