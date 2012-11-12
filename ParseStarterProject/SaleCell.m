//
//  SaleCell.m
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-10.
//
//

#import "SaleCell.h"

@implementation SaleCell
@synthesize imageView,itemDescription,itemCost,itemDistance,itemImagez,itemTitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
