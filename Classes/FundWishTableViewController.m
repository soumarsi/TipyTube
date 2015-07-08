//
//  FundWishTableViewController.m
//  WishizMe
//
//  Created by David Krasicki on 12/15/14.
//  Copyright (c) 2014 AppDupe. All rights reserved.
//

#import "FundWishTableViewController.h"

@interface FundWishTableViewController ()


@end

@implementation FundWishTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    //set back button arrow color
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    //[self addrightButton:self.navigationItem];
    [self addRightButton:self.navigationItem];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigation_bar_logo"]];
    
    [self addLeftButton:self.navigationItem];
    [self getUserCreditBalance];
}

-(void) viewWillAppear:(BOOL)animated{
    [self getUserCreditBalance];
    [self.tableView reloadData];
}

-(void)addLeftButton:(UINavigationItem*)naviItem
{
    UIButton *leftbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftbarbutton setFrame:CGRectMake(0, 0, 60, 42)];
    [leftbarbutton setTitle:@"Back" forState:UIControlStateNormal];
    [leftbarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    leftbarbutton.titleLabel.font = [UIFont fontWithName:HELVETICALTSTD_LIGHT size:15];
    
    [leftbarbutton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    naviItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarbutton];
}

-(void)done:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)addRightButton:(UINavigationItem*)naviItem
{
    UIButton *rightbarbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightbarbutton setFrame:CGRectMake(0, 0, 60, 42)];
    [rightbarbutton setTitle:@"Credits" forState:UIControlStateNormal];
    [rightbarbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightbarbutton.titleLabel.font = [UIFont fontWithName:HELVETICALTSTD_LIGHT size:12];
    
    [rightbarbutton addTarget:self action:@selector(pushBuyCreditsPage:) forControlEvents:UIControlEventTouchUpInside];
    naviItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightbarbutton];
}

-(IBAction)pushBuyCreditsPage:(id)sender
{
    BuyCreditsTableViewController *bc=[[BuyCreditsTableViewController alloc]initWithNibName:@"BuyCreditsTableViewController" bundle:nil];
    [self.navigationController pushViewController:bc animated:NO];
}

- (void)pushBuyCredits {
    BuyCreditsTableViewController *bc=[[BuyCreditsTableViewController alloc]initWithNibName:@"BuyCreditsTableViewController" bundle:nil];
    [self.navigationController pushViewController:bc animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
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
    else if(indexPath.row == 2)
    {
        return 179;
    }
    else if(indexPath.row == 3)
    {
        return 90;
    }
    else if(indexPath.row == 4)
    {
        return 90;
    }
    else if(indexPath.row == 5)
    {
        return 90;
    }
    else{
        return 0;
    }
}

-(void) sendCredits: (NSString*)message creditAmount:(NSString*)credits{
    
    
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    [dictParam setObject:[User currentUser].profile_id forKey:@"user_profile_id"];
    [dictParam setObject:self.userProfileId forKey:@"receiving_user_profile_id"];
    [dictParam setObject:self.fundingCampaignId forKey:@"funding_campaign_id"];
    [dictParam setObject: credits forKey:@"credit_amount"];
    [dictParam setObject: message forKey:@"personal_message"];
    
    [[ProgressIndicator sharedInstance] showPIOnView:self.view withMessage:@"Sending..."];
    
    AFNHelper *afn=[[AFNHelper alloc]init];
    [afn getDataFromPath:@"sendCredits" withParamData:dictParam withBlock:^(id response, NSError *error)
     {
         if (response)
         {
             [[ProgressIndicator sharedInstance] hideProgressIndicator];
             
             if(response[@"success"] == 0){
                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error has occurred. Please try again." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                 [alertView show];
             }
             else{
                 
                 NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
                 [dictParam setObject:[User currentUser].fbid forKey:PARAM_ENT_USER_FBID];
                 [dictParam setObject:@"1" forKey:PARAM_ENT_USER_ACTION];
                 [dictParam setObject:self.userProfileId forKey:PARAM_ENT_INVITEE_FBID];
                 
                 AFNHelper *afn=[[AFNHelper alloc]init];
                 [afn getDataFromPath: METHOD_INVITEACTION withParamData:dictParam withBlock:^(id response, NSError *error) {
                     
                     if (response) {
                         if ([[response objectForKey:@"errFlag"] intValue]==0) {
                             
                             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Credits Sent!" message:[NSString stringWithFormat:@"You have sent %@ credits! The user must respond to your message within 48 hours or your credits will be refunded.", credits] delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                             [alertView show];
                             
                             [self.navigationController popViewControllerAnimated:YES];
                             
                         }else{
                             [[TinderAppDelegate sharedAppDelegate]showToastMessage:[response objectForKey:@"errMsg"]];
                         }
                         //[self settingResponse:response];
                     }
                     else{
                         [[TinderAppDelegate sharedAppDelegate]showToastMessage:@"Failed to send, try again."];
                     }
                 }];
             }
         }
         else{
             [[ProgressIndicator sharedInstance] hideProgressIndicator];
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An error has occurred. Please try again." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             [alertView show];
         }
     }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //NSLog("%i", indexPath.row);
    switch(indexPath.row)
    {
        case 0:
        {
            FundWishIntroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FundWishIntroCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundWishIntroCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                cell.wishTitle.text = self.fundingCampaignTitle;
                
                NSString *imageURL = [NSString stringWithFormat:@"%@%@%@%@",USER_FILES_URL,@"fundingCampaign_icon_", self.fundingCampaignId, @".jpg"];
                
                [cell.wishImage sd_setImageWithURL:[NSURL URLWithString:imageURL]
                                             placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
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
                cell.userSaysTitle.text = [NSString stringWithFormat:@"%@%@",self.user.real_name, @" Says:"];
                
                [cell.userImage sd_setImageWithURL:[NSURL URLWithString:self.user.profile_pic]
                                  placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
                //[cell.userImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.user.profile_pic]]]];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        /*case 2:
        {
            FundWishGuaranteedResponseCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FundWishGuaranteedResponseCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundWishGuaranteedResponseCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                cell.guaranteeLabel.text = [NSString stringWithFormat: @"Wishiz.me offers a 100%% response guarantee. By funding %@'s Wishiz, you are guaranteed a response to your message within 48 hours!", self.user.real_name];
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }*/
        case 2:
        {
            FundCampaignCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FundCampaignCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundCampaignCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
                cell.howManyCreditsIntro.text = [NSString stringWithFormat: @"How many credits do you wish to send to %@ to help fund this wish?", self.user.real_name];
            }            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        case 3:
        {
            FundSend1CreditCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FundSend1CreditCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundSend1CreditCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
            
            }
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        case 4:
        {
            FundSend5CreditCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FundSend5CreditCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundSend5CreditCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        case 5:
        {
            FundSend10CreditCell *cell =[tableView dequeueReusableCellWithIdentifier:@"FundSend10CreditCell"];
            
            if(cell == nil){
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FundSend10CreditCell" owner:self options:nil];
                cell = [nib objectAtIndex:0];
                
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
        default:
        {
            
        }

    }
    
}

-(void) getUserCreditBalance
{
    NSMutableDictionary *dictParam=[[NSMutableDictionary alloc]init];
    User *curUser = [User currentUser];
    [dictParam setObject:curUser.fbid forKey:PARAM_ENT_FBID];
    
    AFNHelper *afn=[[AFNHelper alloc]init];
    [afn getDataFromPath:METHOD_GET_USER_CREDIT_BALANCE withParamData:dictParam withBlock:^(id response, NSError *error)
     {
         if (response)
         {
             NSNumber *credits = response[@"credits"];
             float creditFloat = [credits floatValue];
             //NSString *priceString = [NSString stringWithFormat:@"%f", price];
            
             self.creditfloat = creditFloat;
             
         }
     }];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch(indexPath.row)
    {
        case 0:
        {
            //do nothing
            break;
        }
        case 1:
        {
            //do nothing
            break;
        }
        case 2:
        {
            [self pushBuyCredits];
            break;
        }
        case 3:
        {
            if(self.creditfloat > 0){
                SendCreditsTableTableViewController *bc=[[SendCreditsTableTableViewController alloc]initWithNibName:@"SendCreditsTableTableViewController" bundle:nil];
                
                bc.fundingCampaignDescription = self.fundingCampaignDescription;
                bc.fundingCampaignId = self.fundingCampaignId;
                bc.fundingCampaignTitle = self.fundingCampaignTitle;
                bc.user = self.user;
                bc.sendCreditAmount = @"1";
                bc.delegate = self;
                
                [self.navigationController pushViewController:bc animated:NO];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No Credits" message:@"You do not have any credits. Please buy credits to continue." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            
            break;
        }
        case 4:
        {
            if(self.creditfloat > 4){
                SendCreditsTableTableViewController *bc=[[SendCreditsTableTableViewController alloc]initWithNibName:@"SendCreditsTableTableViewController" bundle:nil];
            
                bc.fundingCampaignDescription = self.fundingCampaignDescription;
                bc.fundingCampaignId = self.fundingCampaignId;
                bc.fundingCampaignTitle = self.fundingCampaignTitle;
                bc.user = self.user;
                bc.sendCreditAmount = @"5";
                bc.delegate = self;
                [self.navigationController pushViewController:bc animated:NO];
                
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Enough Credits" message:@"You do not have enough credits. Please buy more credits to continue." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
        }
        case 5:
        {
            if(self.creditfloat > 9){
                SendCreditsTableTableViewController *bc=[[SendCreditsTableTableViewController alloc]initWithNibName:@"SendCreditsTableTableViewController" bundle:nil];
            
                bc.fundingCampaignDescription = self.fundingCampaignDescription;
                bc.fundingCampaignId = self.fundingCampaignId;
                bc.fundingCampaignTitle = self.fundingCampaignTitle;
                bc.user = self.user;
                bc.sendCreditAmount = @"10";
                bc.delegate = self;
                [self.navigationController pushViewController:bc animated:NO];
            }
            else{
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Not Enough Credits" message:@"You do not have enough credits. Please buy more credits to continue." delegate:Nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
            break;
        }
        default:
        {
            return;
        }
    }
    
    
}


@end
