//
//  ProfilePhotoViewController.m
//  InstagramOore
//
//  Created by Oore Fasawe on 6/30/22.
//

#import "ProfilePhotoViewController.h"
#import "Post.h"
@import Parse;

@interface ProfilePhotoViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *profilePhoto;

@end

@implementation ProfilePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)takePhotoForProfile:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        NSLog(@"Camera 🚫 available so we will use photo library instead");
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (IBAction)uploadFromLibraryForProfile:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)didChooseImageForProfile:(id)sender {
    if(self.profilePhoto.image){
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    
    [self.profilePhoto setImage:[self resizeImage:originalImage withSize:CGSizeMake(500, 500)]];
    self.profilePhoto.layer.cornerRadius = 10;
    self.profilePhoto.layer.borderWidth = 0.05;
    
    PFUser *user = [PFUser currentUser];
    user[@"profilePhoto"] = [Post getPFFileFromImage:self.profilePhoto.image];
    [user saveInBackground];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
