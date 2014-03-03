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
#import <AssetsLibrary/AssetsLibrary.h>

@interface RTPostDetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UITextField *authorField;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextField *contentField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *postPicView;

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
    self.postPicView.image = self.thisPost.postPic;
    // self.postPicView.layer.cornerRadius = self.postPicView.frame.size.width/2;
    self.postPicView.clipsToBounds = YES;
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

//filters image by clamping it within the RGB range of current post color
- (IBAction)filterPostPic:(id)sender {
    CIImage *picToFilter = [[CIImage alloc] initWithImage:self.thisPost.postPic];
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [self.thisPost.postColor getRed:&red green:&green blue:&blue alpha:&alpha];
    CGRect filterMinRGBA = CGRectMake(red-0.25, green-0.25, blue-0.25, alpha);
    CGRect filterMaxRGBA = CGRectMake(red+0.25, green+0.25, blue+0.25, alpha);
    CIVector *colorVectorMin = [[CIVector alloc] initWithCGRect:filterMinRGBA];
    CIVector *colorVectorMax = [[CIVector alloc] initWithCGRect:filterMaxRGBA];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorClamp" keysAndValues:@"inputImage", picToFilter, @"inputMinComponents", colorVectorMin, @"inputMaxComponents", colorVectorMax, nil];
    CIImage *resultImage = [filter outputImage];
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImageRef = [context createCGImage:resultImage fromRect:resultImage.extent];
    UIImage *filteredPic = [UIImage imageWithCGImage:cgImageRef];
    self.thisPost.postPic = filteredPic;
    self.postPicView.image = self.thisPost.postPic;
    self.postPicView.layer.cornerRadius = self.postPicView.frame.size.width/2;
    self.postPicView.clipsToBounds = YES;
}


- (IBAction)cameraButton:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose Source"
                                                                 delegate:self
                                                        cancelButtonTitle:@"Cancel"
                                                   destructiveButtonTitle:nil
                                                        otherButtonTitles:@"Photo Library", @"Camera", nil];
        [actionSheet showFromBarButtonItem:sender animated:YES];
    } else {
        [self showPickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
}

- (void)showPickerWithSourceType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = sourceType;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Photo Library"]) {
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        if (status != ALAuthorizationStatusAuthorized) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"Please give this app permission to access your photo library in Settings > Privacy > Photos!" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
            [alert show];
        }
        [self showPickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    } else if ([buttonTitle isEqualToString:@"Camera"]) {
        /*
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        //Create camera overlay
        CGRect f = imagePickerController.view.bounds;
        f.size.height -= imagePickerController.navigationBar.bounds.size.height;
        CGFloat barHeight = (f.size.height - f.size.width) / 2;
        UIGraphicsBeginImageContext(f.size);
        [[UIColor colorWithWhite:0 alpha:.5] set];
        UIRectFillUsingBlendMode(CGRectMake(0, 0, f.size.width, barHeight), kCGBlendModeNormal);
        UIRectFillUsingBlendMode(CGRectMake(0, f.size.height - barHeight, f.size.width, barHeight), kCGBlendModeNormal);
        UIImage *overlayImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
            
        UIImageView *overlayIV = [[UIImageView alloc] initWithFrame:f];
        overlayIV.image = overlayImage;
        [imagePickerController.cameraOverlayView addSubview:overlayIV];
        
        imagePickerController.delegate = self;
        [self presentViewController:imagePickerController animated:YES completion:nil];
         */
        [self showPickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
        
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *picToCrop = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *smallSizeImage = UIImageJPEGRepresentation(picToCrop,
                                                           0.5);
        picToCrop = [UIImage imageWithData:smallSizeImage];
        
        CGSize imageSize = [picToCrop size];
        float widthToCrop = 0.0, heightToCrop = 0.0;
        BOOL isPortrait = false;
        if (imageSize.height > imageSize.width) {
            heightToCrop = imageSize.height - imageSize.width;
            isPortrait = true;
        } else /*(imageSize.width > imageSize.height ) */ {
            widthToCrop = imageSize.width - imageSize.height;
        }
        
        NSLog(@"image width: %.2f", widthToCrop);
        NSLog(@"image height: %.2f", heightToCrop);
        
        CGRect squareCrop = CGRectMake(widthToCrop/2, heightToCrop/2, imageSize.width - widthToCrop, imageSize.height - heightToCrop);
        NSLog(@"rect: %@", NSStringFromCGRect(squareCrop));
        
        CGImageRef imageRef = CGImageCreateWithImageInRect(picToCrop.CGImage, squareCrop);
        UIImage *croppedPic = [UIImage imageWithCGImage:imageRef];
        if (isPortrait) {
            croppedPic = [[UIImage alloc] initWithCGImage: croppedPic.CGImage
                                                    scale: 1.0
                                              orientation: UIImageOrientationRight];
        }
        CGImageRelease(imageRef);
        self.thisPost.postPic = croppedPic;
        self.postPicView.image = self.thisPost.postPic;
        // self.postPicView.layer.cornerRadius = self.postPicView.frame.size.width/2;
        self.postPicView.clipsToBounds = YES;
    }];
}


@end
