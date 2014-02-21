//
//  RTViewController.m
//  MVC
//
//  Created by Ryo Tulman on 2/13/14.
//  Copyright (c) 2014 Ryo Tulman. All rights reserved.
//

#import "RTPostDetailViewController.h"
#import "RTPostsTableViewController.h"
#import "RTPost.h"
#import "UIColor+ColorConjurer.h"

@interface RTPostDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *contentField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation RTPostDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.view.backgroundColor = self.thisPost.postColor;
    
}
- (IBAction)submitPost:(id)sender {
    /*NSDictionary *postDict = [[NSDictionary alloc] initWithObjectsAndKeys:self.authorField.text,@"user",self.titleField.text,@"title",self.contentField.text,self.contentField.text,@"content", nil];
    RTPost *postToSubmit = [[RTPost alloc] initWithDictionary:postDict];*/
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.authorField.text = self.thisPost.user;
    self.titleField.text = self.thisPost.title;
    self.contentField.text = self.thisPost.content;
    self.dateLabel.text = [self.thisPost.date description];
    self.view.backgroundColor = self.thisPost.postColor;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.thisPost.content = self.contentField.text;
    self.thisPost.user = self.authorField.text;
    self.thisPost.title = self.titleField.text;
}
- (IBAction)lightenPostColor:(id)sender {
    self.thisPost.postColor = [UIColor lightenGivenColor:self.thisPost.postColor];
    self.view.backgroundColor = self.thisPost.postColor;
}


@end
