//
//  FundingCampaignReviewTableViewController.h
//  WishizMe
//
//  Created by David Krasicki on 1/11/15.
//  Copyright (c) 2015 AppDupe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditFundingCampaignViewController.h"

@interface FundingCampaignReviewTableViewController : UITableViewController

@property(nonatomic,strong) NSString *fundingCampaignId;
@property(nonatomic,strong) NSString *fundingCampaignTitle;
@property(nonatomic,strong) NSString *fundingCampaignPrice;
@property(nonatomic,strong) NSString *fundingCampaignDescription;

@end
