//
//  SaleCell.h
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-10.
//
//

#import <UIKit/UIKit.h>

@interface SaleCell : UITableViewCell
{
    UILabel* itemTitle,*itemDescription,*itemCost,*itemDistance;
    UIImageView *itemImagez;
}
@property (retain, nonatomic) IBOutlet UIImageView *itemImagez;
@property (retain, nonatomic) IBOutlet UILabel *itemTitle;
@property (retain, nonatomic) IBOutlet UILabel *itemDescription;
@property (retain, nonatomic) IBOutlet UILabel *itemCost;
@property (retain, nonatomic) IBOutlet UILabel *itemDistance;

@end
