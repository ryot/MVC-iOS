//
//  RTPostsTableViewController.m
//  MVC
//
//  Created by Ryo Tulman on 2/11/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTPostsTableViewController.h"
#import "RTPost.h"
#import "RTStartingPosts.h"
#import "RTPostTableViewCell.h"
#import "RTPostDetailViewController.h"

@interface RTPostsTableViewController ()

@property (nonatomic, strong) NSArray *posts;

@end

@implementation RTPostsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *filePath = [[self documentsDirectory] stringByAppendingPathComponent:@"saveFile"];
    
    /* Code Fellows Walkthrough involved copying generated plist or txt save file back into project
     
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:@"saveFile" ofType:@"txt"];
        [[NSFileManager defaultManager] copyItemAtPath:bundlePath toPath:filePath error:nil];
    }
    self.posts = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    */
    
    self.posts = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    if (!self.posts) {
        RTStartingPosts *startingPosts = [[RTStartingPosts alloc] init];
        self.posts = [startingPosts.generatedPosts copy];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.posts.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (RTPostTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    RTPostTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    RTPost *thisPost = [self.posts objectAtIndex:indexPath.row];
    [cell updateCell:thisPost];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showDetailSegue"]) {
        RTPostDetailViewController *detail = segue.destinationViewController;
        NSInteger selectedRow = [self.tableView indexPathForSelectedRow].row;
        detail.thisPost = [self.posts objectAtIndex:selectedRow];
    } else if ([segue.identifier isEqualToString:@"newPostSegue"]) {
        RTPost *newPost = [[RTPost alloc] init];
        RTPostDetailViewController *newPostEditor = segue.destinationViewController;
        newPostEditor.thisPost = newPost;
        NSMutableArray *mutablePosts = [NSMutableArray arrayWithArray:self.posts];
        [mutablePosts insertObject:newPost atIndex:0];
        self.posts = mutablePosts;
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self savePosts];
}

- (void)savePosts {
    NSString *filePath = [[self documentsDirectory] stringByAppendingPathComponent:@"saveFile"];
    [NSKeyedArchiver archiveRootObject:self.posts toFile:filePath];
}

- (IBAction)resetPosts:(id)sender {
    RTStartingPosts *startingPosts = [[RTStartingPosts alloc] init];
    self.posts = [startingPosts.generatedPosts copy];
    [self.tableView reloadData];
}

/*
-(void)tableView:(UITableView *)tableView willDisplayCell:(RTPostTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    RTPostTableViewCell *cellToOperateOn = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell setBackgroundColor:cell.myPost.postColor];
}
*/

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

- (NSString *)documentsDirectory {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *results = [fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *documentsURL = [results lastObject];
    return documentsURL.path;
}

@end
