//
//  PostViewController.m
//  InstagramOore
//
//  Created by Oore Fasawe on 6/27/22.
//

#import "PostViewController.h"
#import "SceneDelegate.h"
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "PhotoViewController.h"
#import "InstaCell.h"
#import "Post.h"
#import "DetailsViewController.h"
@interface PostViewController ()
@property (nonatomic, strong) NSArray *postArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) UIRefreshControl *refreshControl;


@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self fetchPosts];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (IBAction)takePhoto:(id)sender {
    [self performSegueWithIdentifier:@"photoSegue" sender:nil];
}


- (IBAction)didTapLogout:(id)sender {
    
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if (error)
        {}
        else{
            SceneDelegate *sceneDelegate = (SceneDelegate *)self.view.window.windowScene.delegate;

            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            sceneDelegate.window.rootViewController = loginViewController;
        }
    }];
}

-(void)fetchPosts{
    PFQuery *query = [PFQuery queryWithClassName:@"Post"];
    [query orderByDescending:@"createdAt"];
    [query includeKey:@"author"];
    [query includeKey:@"createdAt"];
    query.limit = 20;

    [query findObjectsInBackgroundWithBlock:^(NSArray *posts, NSError *error) {
        if (posts != nil) {
            self.postArray = posts;
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        } else {
            NSLog(@"%@", error.localizedDescription);
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"DetailsViewController"]){
        UITableViewCell *instaCell = sender;
        NSIndexPath *myIndexPath = [self.tableView indexPathForCell:instaCell];
        // Pass the selected object to the new view controller.
        Post *igPost = self.postArray[myIndexPath.row];
        DetailsViewController *detailsController = [segue destinationViewController];
        detailsController.post = igPost;
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InstaCell *instaCell = [self.tableView dequeueReusableCellWithIdentifier:@"InstaCell"];
    
    Post *post = self.postArray[indexPath.row];
    
    instaCell.usernameLabel.text = post[@"author"][@"username"];
    instaCell.captionUsername.text = post[@"author"][@"username"];
    instaCell.captionTextLabel.text = post[@"caption"];
    instaCell.postImage.layer.cornerRadius = 10;
    instaCell.postImage.layer.borderWidth = 0.05;
    instaCell.postImage.file = post[@"image"];
    [instaCell.postImage loadInBackground];

    return instaCell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postArray.count;
}

@end
