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
@property (strong, nonatomic) UIImageView *imageViewToSet;

@end

@implementation PhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    [self setImageView:self.postImage];

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }

    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (IBAction)uploadFromLibrary:(id)sender {
    UIImagePickerController *imagePickerVC = [UIImagePickerController new];
    imagePickerVC.delegate = self;
    imagePickerVC.allowsEditing = YES;
    
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self setImageView:self.postImage];
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}

- (IBAction)makePost:(id)sender {
    
    if(self.postImage.image && ![self.postCaption.text isEqualToString:@""]){
    [Post postUserImage:self.postImage.image withCaption:self.postCaption.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
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
    
    [self.imageViewToSet setImage:[self resizeImage:originalImage withSize:CGSizeMake(500, 500)]];
    self.imageViewToSet.layer.cornerRadius = 10;
    self.imageViewToSet.layer.borderWidth = 0.05;

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
    
    UIAlertAction *tryAgain = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:tryAgain];
    
    [self presentViewController:alert animated:YES completion:^{}];
}

-(void)setImageView:(UIImageView *)imageView{
    self.imageViewToSet = imageView;
}

@end
