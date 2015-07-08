//
//  SelectWishViewController.h
//  WishizMe
//
//  Created by David Krasicki on 6/2/15.
//  Copyright (c) 2015 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseVC.h"

@interface SelectWishViewController : UIViewController

@property(nonatomic,weak)IBOutlet UIButton *createCampaignButton;

@property(nonatomic,weak)IBOutlet UILabel *label1;
@property(nonatomic,weak)IBOutlet UILabel *label2;
@property(nonatomic,weak)IBOutlet UILabel *label3;

@property(nonatomic,weak)IBOutlet UIImageView *wishizlogo;
@property(nonatomic,weak)IBOutlet UIImageView *bg;

@end
