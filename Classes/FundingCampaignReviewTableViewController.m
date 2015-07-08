//
//  FundingCampaignReviewTableViewController.m
//  WishizMe
//
//  Created by David Krasicki on 1/11/15.
//  Copyright (c) 2015 AppDupe. All rights reserved.
//

#import "FundingCampaignReviewTableViewController.h"

@interface FundingCampaignReviewTableViewController ()

@end

@implementation FundingCampaignReviewTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [APPDELEGATE addBackButton:self.navigationItem];
    [self addRightButton:self.navigationItem];
    
    [self.navigationItem setTitle:@"My Wish"];
    self.navigationController.navigationBarHidden = NO;
}

-(void)addRightButton:(UINavigationItem*)naviItem
{
    UIButton *rightbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbarbutton setFrame:CGRectMake(0, 0, 60, 42)];
    [rightbarbutton setTitle:@"Edit" forState:UIControlStateNormal];
    [rightbarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbarbutton.titleLabel.font = [UIFont fontWithName:HELVETICALTSTD_LIGHT size:12];
    
    [rightbarbutton addTarget:self action:@selector(editCampaign) forControlEvents:UIControlEventTouchUpInside];
    naviItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbarbutton];
}

-(void) editCampaign
{
    EditFundingCampaignViewController *editCampaign = [[EditFundingCampaignViewController alloc] init];
    
    editCampaign.wishTitle.textValue = self.fundingCampaignTitle;
    editCampaign.wishDescription.textValue = self.fundingCampaignDescription;
    editCampaign.wishCost.textValue = self.fundingCampaignPrice;
    editCampaign.wishId = self.fundingCampaignId;
    
    NSString *imageURL = [NSString stringWithFormat:@"%@%@%@%@",USER_FILES_URL,@"fundingCampaign_icon_", self.fundingCampaignId, @".jpg"];
    [editCampaign.wishTopImageView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
    
    [self.navigationController pushViewController:editCampaign animated:NO];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        return 358;
    }
    else if(indexPath.row == 1)
    {
        return 170;
    }
    
    else{
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch(indexPath.row)
    {
        case 0:
        {
            FundWishIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FundWishIntroCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundWishIntroCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                cell.wishTitle.text = self.fundingCampaignTitle;
                
                NSString *imageURL = [NSString stringWithFormat:@"%@%@%@%@",USER_FILES_URL,@"fundingCampaign_real_", self.fundingCampaignId, @".jpg"];
                
                [cell.wishImage sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:nil];
                cell.fundWishTitle.text = @"Your Wish";
                //[cell.wishImage setImage: [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageURL]]]];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        case 1:
        {
            FundWishUserCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FundWishUserCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundWishUserCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                cell.userSaysDescription.text = self.fundingCampaignDescription;
                cell.userSaysTitle.text = [NSString stringWithFormat:@"%@%@",@"You ", @"Say:"];
                
                [cell.userImage sd_setImageWithURL:[NSURL URLWithString:[User currentUser].profile_pic]
                                  placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                //[cell.userImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.profile_pic]]]];
            }
            
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch(indexPath.row)
    {
        case 0:
        {
            //do nothing
        }
        case 3:
        {
            
        }
        default:
        {
            /*FundWishTableViewController *viewCampaign = [[FundWishTableViewController alloc] initWithNibName:@"FundWishTableViewController" bundle:nil];
             
             NSMutableDictionary *fundingCampaign = [self.fundingCampaigns objectAtIndex: indexPath.row - 1];
             
             viewCampaign.fundingCampaignTitle = fundingCampaign[@"title"];
             viewCampaign.fundingCampaignDescription = fundingCampaign[@"description"];
             viewCampaign.fundingCampaignId =fundingCampaign[@"id"];
             viewCampaign.user = self.user;
             
             [self.navigationController pushViewController:viewCampaign animated:NO];*/
        }
    }
    
    
}

@end
