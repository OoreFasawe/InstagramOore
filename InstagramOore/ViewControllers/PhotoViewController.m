//
//  PhotoViewController.m
//  InstagramOore
//
//  Created by Oore Fasawe on 6/27/22.
//

#import "PhotoViewController.h"
#import "Post.h"

@interface PhotoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *postCaption;
@property (weak, nonatomic) IBOutlet UIImageView *postImage;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
- (IBAction)takePhoto:(id)sender {
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
- (IBAction)uploadFromLibrary:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)makePost:(id)sender {
    
    if(self.postImage.image && ![self.postCaption.text isEqualToString:@""]){
    [Post postUserImage:self.postImage.image withCaption:self.postCaption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error)
        {
            NSLog(@"Error sending to Parse");
        }
        else{
            NSLog(@"Photo saved successfully");
        }
    }];
    [self dismissViewControllerAnimated:true completion:nil];
    }
    else{
        [self showAlert];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    // Get the image captured by the UIImagePickerController
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    UIImage *editedImage = info[UIImagePickerControllerEditedImage];
    
    
    [self.postImage setImage:[self resizeImage:originalImage withSize:CGSizeMake(500, 500)]];
    self.postImage.layer.cornerRadius = 10;
    self.postImage.layer.borderWidth = 0.05;

    
    // Dismiss UIImagePickerController to go back to your original view controller
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

-(void)showAlert{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Missing Field(s)"
                                                                               message:@"Add a caption and image"
                                                                        preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                     }];
    [alert addAction:tryAgain];
    
    [self presentViewController:alert animated:YES completion:^{
        // optional code for what happens after the alert controller has finished presenting
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
