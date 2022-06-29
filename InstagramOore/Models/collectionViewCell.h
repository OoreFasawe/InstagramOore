//
//  collectionViewCell.h
//  InstagramOore
//
//  Created by Oore Fasawe on 6/29/22.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface collectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet PFImageView *postPhoto;

@end

NS_ASSUME_NONNULL_END
