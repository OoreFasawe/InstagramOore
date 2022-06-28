//
//  InstaCell.h
//  Pods
//
//  Created by Oore Fasawe on 6/27/22.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface InstaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet PFImageView *postImage;
@property (strong, nonatomic) IBOutlet UILabel *captionUsername;
@property (strong, nonatomic) IBOutlet UILabel *captionTextLabel;
@end

NS_ASSUME_NONNULL_END
