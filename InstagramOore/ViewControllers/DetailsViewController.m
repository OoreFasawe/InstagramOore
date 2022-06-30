//
//  DetailsViewController.m
//  Pods
//
//  Created by Oore Fasawe on 6/28/22.
//

#import "DetailsViewController.h"
@import Parse;
#import "DateTools.h"


@interface DetailsViewController ()
@property (strong, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *captionLabel;
@property (strong, nonatomic) IBOutlet UILabel *timeStamp;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDetailsView];
}

-(void)loadDetailsView{
    self.postImage.layer.cornerRadius = 10;
    self.postImage.layer.borderWidth = 0.05;
    self.postImage.file = self.post[@"image"];
    [self.postImage loadInBackground];
    self.usernameLabel.text = self.post[@"author"][@"username"];
    self.captionLabel.text = self.post[@"caption"];
    NSDate *time = self.post.createdAt;
    self.timeStamp.text = [time timeAgoSinceNow];
}
@end

