//
//  SaleDetailVC.m
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-11.
//
//

#import "SaleDetailVC.h"

@interface SaleDetailVC ()

@end

@implementation SaleDetailVC
@synthesize _m_salesObject,itemCost,itemDescription,itemDistance,itemImage,itemName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.itemName.text	= [self._m_salesObject objectForKey:@"Name"];
     self.itemDescription.text	= [self._m_salesObject objectForKey:@"Description"];
     self.itemDistance.text	= [self._m_salesObject objectForKey:@"Distance"];
     self.itemCost.text	= [self._m_salesObject objectForKey:@"Cost"];
    
    PFFile *theImage = [self._m_salesObject objectForKey:@"imageFile"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];
    
    self.itemImage.image = image;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setItemName:nil];
    [self setItemDescription:nil];
    [self setItemDistance:nil];
    [self setItemCost:nil];
    [self setItemImage:nil];
    [super viewDidUnload];
}
- (IBAction)backPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end
