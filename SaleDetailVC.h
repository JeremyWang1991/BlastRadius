//
//  SaleDetailVC.h
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-11.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SaleDetailVC : UIViewController
{
    PFObject*		_m_salesObject;
    UILabel*itemName,*itemDescription,*itemCost,*itemDistance;
    UIImageView *itemImage;

}

@property (nonatomic, retain) PFObject* _m_salesObject;
@property (retain, nonatomic) IBOutlet UILabel *itemName;
@property (retain, nonatomic) IBOutlet UILabel *itemDescription;
@property (retain, nonatomic) IBOutlet UILabel *itemDistance;
@property (retain, nonatomic) IBOutlet UILabel *itemCost;
@property (retain, nonatomic) IBOutlet UIImageView *itemImage;
- (IBAction)backPressed:(id)sender;


@end
