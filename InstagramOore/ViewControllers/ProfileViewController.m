//
//  ProfileViewController.m
//  InstagramOore
//
//  Created by Oore Fasawe on 6/28/22.
//

#import "ProfileViewController.h"
#import "ProfilePhotoViewController.h"
#import <Parse/Parse.h>
#import "collectionViewCell.h"
#import "Post.h"


@interface ProfileViewController()
@property (strong, nonatomic) IBOutlet PFImageView *profilePhoto;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *myPosts;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self fetchProfileposts];
    
    self.profilePhoto.file = [PFUser currentUser][@"profilePhoto"];
    [self.profilePhoto loadInBackground];
    
}

-(void)fetchProfileposts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query whereKey:@"author" equalTo:[PFUser currentUser]];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    query.limit = 20;

    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.myPosts = posts;
//            [self.refreshControl endRefreshing];
            [self.collectionView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)didChooseProfileImage:(nonnull UIImageView *)imageView {
    self.profilePhoto.image = imageView.image;
    self.profilePhoto.layer.cornerRadius = self.profilePhoto.frame.size.width/2;
    self.profilePhoto.layer.borderWidth= 0.05;
    self.profilePhoto.clipsToBounds = true;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    collectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    
    Post *post = self.myPosts[indexPath.row];
    cell.postPhoto.file = post[@"image"];
    [cell.postPhoto loadInBackground];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.myPosts.count;
}

@end
