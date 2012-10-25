//
//  GlassboxViewController.m
//  Glassbox
//
//  Created by Ken M. Haggerty on 10/23/12.
//  Copyright (c) 2012 Ken M. Haggerty. All rights reserved.
//

#pragma mark - // NOTES (Private) //

#pragma mark - // IMPORTS (Private) //

#import "GlassboxViewController.h"
#import "GlassboxTableViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "Player.h"

#pragma mark - // DEFINITIONS (Private) //

@interface GlassboxViewController () // UIImagePickerControllerDelegate, UINavigationControllerDelegate, GlassboxTableViewDatasource, UITableViewDataSource
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) GlassboxTableViewController *tableViewController;
- (void)setup;
- (void)alertAddPlayer;
- (void)alertInvalidPlayer;
- (void)alertAddPhoto;
//- (void)dismissImagePicker;
@end

@implementation GlassboxViewController

#pragma mark - // SETTERS AND GETTERS //

@synthesize arrayOfPlayers = _arrayOfPlayers;

- (void)setArrayOfPlayers:(NSMutableArray *)arrayOfPlayers
{
    _arrayOfPlayers = arrayOfPlayers;
}

- (NSMutableArray *)arrayOfPlayers
{
    if (!_arrayOfPlayers) _arrayOfPlayers = [[NSMutableArray alloc] init];
    return _arrayOfPlayers;
}

#pragma mark - // INITS AND LOADS //

- (void)setup
{
    NSLog(@"[setup]");
    if (!self.tableViewController)
    {
        self.tableViewController = [[GlassboxTableViewController alloc] initWithStyle:UITableViewStylePlain];
//        self.tableViewController.datasource = self.tableViewController;
        self.tableViewController.tableView = self.tableView;
        self.tableView.dataSource = self.tableViewController;
//        [self addChildViewController:self.tableViewController];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    NSLog(@"[initWithNibNameBundle]");
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
	// Do any additional setup after loading the view.
//    for (int i = 0; i < self.childViewControllers.count; i++)
//    {
//        for (int j = 0; j < [[[self.childViewControllers objectAtIndex:i] childViewControllers] count]; j++)
//        {
//            if ([[[((UINavigationController *)[self.childViewControllers objectAtIndex:i]) childViewControllers] objectAtIndex:j] isKindOfClass:[GlassboxTableViewController class]])
//            {
//                self.tableView = [(GlassboxTableViewController *)[[[self.childViewControllers objectAtIndex:i] childViewControllers] objectAtIndex:j] tableView];
//                [[[[self.childViewControllers objectAtIndex:i] childViewControllers] objectAtIndex:j] setDatasource:self];
//                return;
//            }
//        }
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - // DELEGATED FUNCTIONS (GlassboxTableViewController) //

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
//    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//        if ([mediaTypes containsObject:(NSString *)kUTTypeImage])
//        {
//            UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
//            imagePickerController.delegate = self;
//            imagePickerController.allowsEditing = YES;
//            imagePickerController.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//            imagePickerController.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
//            imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
////            [self presentViewController:imagePickerController animated:YES completion:nil];
//            [self presentModalViewController:imagePickerController animated:YES];
//            return;
//        }
//    }
    NSLog(@"[TEST] alertAddPhoto");
    if (self.tableView) NSLog(@"[TEST] self.tableView");
    if (self.tableView.dataSource) NSLog(@"[TEST] self.tableView.dataSource");
    if (self.tableViewController) NSLog(@"[TEST] self.tableViewController");
//    if (self.tableViewController.datasource) NSLog(@"[TEST] self.tableViewController.datasource");
    [self.tableView reloadData];
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
//    if (!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
//    if (image)
//    {
//        [[self.arrayOfPlayers lastObject] setPhoto:image];
//    }
//    [self dismissImagePicker];
//}
//
//- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [self dismissImagePicker];
//}
//
//- (void)dismissImagePicker
//{
////    [self dismissViewControllerAnimated:YES completion:^{
////        [self.tableView reloadData];
////    }];
//    [self dismissModalViewControllerAnimated:YES];
//}

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
//                    [self.arrayOfPlayers addObject:[[Player alloc] initWithUsername:[[alertView textFieldAtIndex:0] text]]];
                    [self.tableViewController.arrayOfPlayers addObject:[[Player alloc] initWithUsername:[[alertView textFieldAtIndex:0] text]]];
                    [self alertAddPhoto];
                }
                else [self alertInvalidPlayer];
            }
        }
    }
}

@end