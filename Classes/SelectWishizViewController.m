//
//  SelectWishizViewController.m
//  WishizMe
//
//  Created by David Krasicki on 6/2/15.
//  Copyright (c) 2015 AppDupe. All rights reserved.
//

#import "SelectWishizViewController.h"
#import "FundingCampaignsTableViewController.h"

@interface SelectWishizViewController ()

@end

@implementation SelectWishizViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)selectWishButtom:(id)sender
{
    
    FundingCampaignsTableViewController *c = [[FundingCampaignsTableViewController alloc] initWithNibName:@"FundingCampaignsTableViewController" bundle:nil];
    
    UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
    [self.revealSideViewController popViewControllerWithNewCenterController:n
                                                                   animated:YES];
}

@end
