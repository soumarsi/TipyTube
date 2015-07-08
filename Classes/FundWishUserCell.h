//
//  FundWishUserCell.h
//  WishizMe
//
//  Created by David Krasicki on 12/15/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface FundWishUserCell : UITableViewCell


@property(nonatomic,strong)IBOutlet UILabel *userSaysTitle;
@property(nonatomic,strong)IBOutlet UITextView *userSaysDescription;
@property(nonatomic,strong)IBOutlet UIImageView *userImage;

@end
