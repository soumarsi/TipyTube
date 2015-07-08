//
//  SelectWishViewController.m
//  WishizMe
//
//  Created by David Krasicki on 6/2/15.
//  Copyright (c) 2015 AppDupe. All rights reserved.
//

#import "SelectWishViewController.h"

@interface SelectWishViewController ()

@end

@implementation SelectWishViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.bg setImage:[UIImage imageNamed:@"select_wishiz_bg"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
