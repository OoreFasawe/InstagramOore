//
//  PhotoViewController.h
//  InstagramOore
//
//  Created by Oore Fasawe on 6/27/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PhotoViewControllerDelegate <NSObject>

-(void)didChooseProfileImage:(UIImageView *) imageView;

@end
@interface PhotoViewController : UIViewController < UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (nonatomic, weak) id<PhotoViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
