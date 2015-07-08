//
//  ProfileVC.h
//  Tinder
//
//  Created by Elluminati - macbook on 12/06/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProfileViewTableCell.h"
#import "FundingCampaignCell.h"
#import "BuyCreditsTableViewController.h"
#import "UIImageView+WebCache.h"
#import "EditFundingCampaignViewController.h"


@interface ProfileVC : UIViewController<UIScrollViewDelegate,PPRevealSideViewControllerDelegate>{
    NSMutableDictionary *arrImages;
    int currentPage;
}
@property(nonatomic,strong)User *user;
@property(nonatomic,strong)NSString *user_profile_id;

@property(nonatomic,weak)IBOutlet UIScrollView *scrImage;
@property(nonatomic,weak)IBOutlet UIPageControl *pcImage;
@property(nonatomic,weak)IBOutlet UITableView *profileTableView;
@property(nonatomic,strong)IBOutlet NSArray* fundingCampaigns;

-(void) getUserFundingCampaigns:(NSString *) profile_id;

@end