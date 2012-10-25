//
//  GlassboxTableViewController.m
//  Glassbox
//
//  Created by Ken M. Haggerty on 10/22/12.
//  Copyright (c) 2012 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "GlassboxTableViewController.h"
#import "GlassboxCell.h"
#import "Player.h"
#import <MobileCoreServices/MobileCoreServices.h>

#pragma mark - // DEFINITIONS (Private) //

#define SIDEBAR_WIDTH_PERCENT 0.75

@interface GlassboxTableViewController () <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
//@property (nonatomic, weak) IBOutlet UITableView *tableView;
- (void)setup;
@end

@implementation GlassboxTableViewController

#pragma mark - // SETTERS AND GETTERS //

@synthesize arrayOfPlayers = _arrayOfPlayers;
//@synthesize tableView = _tableView;
//@synthesize datasource = _datasource;

- (void)setArrayOfPlayers:(NSMutableArray *)arrayOfPlayers
{
    _arrayOfPlayers = arrayOfPlayers;
}

- (NSMutableArray *)arrayOfPlayers
{
    if (!_arrayOfPlayers) _arrayOfPlayers = [[NSMutableArray alloc] init];
//    [_arrayOfPlayers addObject:[[Player alloc] initWithUsername:@"Ken H.:"]];
    return _arrayOfPlayers;
}

#pragma mark - // INITS AND LOADS //

- (void)setup
{
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    NSLog(@"[initWithStyle]");
    self = [super initWithStyle:style];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"[viewDidLoad]");
    [super viewDidLoad];
    [self setup];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width*SIDEBAR_WIDTH_PERCENT, self.view.frame.size.height)];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - // PUBLIC FUNCTIONS //

- (IBAction)addPlayer:(UIBarButtonItem *)sender
{
    [self alertAddPlayer];
}

#pragma mark - // PRIVATE FUNCTIONS //

- (void)alertAddPlayer
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Add New Player" message:@"Please type player name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
}

- (void)alertInvalidPlayer
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Name" message:@"Please type another name:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    alert.tag = 1;
    [alert show];
}

- (void)alertAddPhoto
{
    NSLog(@"[TEST] alertAddPhoto");
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if ([mediaTypes containsObject:(NSString *)kUTTypeImage])
        {
            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
            imagePickerController.delegate = self;
            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePickerController.allowsEditing = YES;
//            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//            imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
            imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
//            [self presentViewController:imagePickerController animated:YES completion:nil];
            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            [self presentModalViewController:imagePickerController animated:YES];
            return;
        }
    }
    NSLog(@"[TEST] No camera available");
    [self.tableView reloadData];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (image)
    {
        [[self.arrayOfPlayers lastObject] setPhoto:[[UIImageView alloc] initWithImage:image]];
    }
    [self dismissImagePicker];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissImagePicker];
}

- (void)dismissImagePicker
{
//    [self dismissViewControllerAnimated:YES completion:^{
//        [self.tableView reloadData];
//    }];
    [self dismissModalViewControllerAnimated:YES];
    [self.tableView reloadData];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) NSLog(@"Cancel tapped");
    else
    {
        if (alertView.tag == 1)
        {
            if (buttonIndex == 1)
            {
                if ([[[alertView textFieldAtIndex:0] text] length] != 0)
                {
                    [self.arrayOfPlayers addObject:[[Player alloc] initWithUsername:[[alertView textFieldAtIndex:0] text]]];
                    [self alertAddPhoto];
                }
                else [self alertInvalidPlayer];
            }
        }
    }
}

#pragma mark - // PRIVATE FUNCTIONS (Miscellaneous) //

// TableView data source //

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//#warning Potentially incomplete method implementation.
//    // Return the number of sections.
//    return 0;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.datasource.arrayOfPlayers.count;
    return self.arrayOfPlayers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"New Cell";
//    GlassboxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    GlassboxCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
//        cell = [[GlassboxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"New Cell"];
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"New Cell"];
    }
    
//    cell.name.text = [[self.arrayOfPlayers objectAtIndex:indexPath.row] username];
//    cell.action.text = @"LOADED SUCCESSFULLY";
//    cell.time.text = @"Just now";
//    cell.photo = [[self.arrayOfPlayers objectAtIndex:indexPath.row] photo];
    
    cell.textLabel.text = [[self.arrayOfPlayers objectAtIndex:indexPath.row] username];
    cell.detailTextLabel.text = @"UITableViewCell test";
    
//    [((UILabel *)[cell viewWithTag:1]) setText:[[self.arrayOfPlayers objectAtIndex:indexPath.row] username]];
//    [((UILabel *)[cell viewWithTag:2]) setText:@"has been added."];
//    [((UILabel *)[cell viewWithTag:3]) setText:@"Just now"];
//    [((UIImageView *)[cell viewWithTag:4]) setImage:[[[self.arrayOfPlayers objectAtIndex:indexPath.row] photo] image]];
    
    [cell.contentView setFrame:CGRectMake(cell.contentView.frame.origin.x, cell.contentView.frame.origin.y, cell.contentView.frame.size.width, 120)];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

// TableView delegate //

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
