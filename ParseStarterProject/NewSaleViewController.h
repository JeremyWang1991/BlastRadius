//
//  NewSaleViewController.h
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-10.
//
//

#import <UIKit/UIKit.h>

@interface NewSaleViewController : UIViewController<UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    IBOutlet UITextField *itemName,*itemDescription,*itemCost;
    NSData *imageData;
    IBOutlet UIImageView *imageView;
    
    IBOutlet UIButton *saleBtn;
    IBOutlet UIButton *lookingBtn;
    IBOutlet UIButton *noBtn;
    IBOutlet UIButton *yesBtn;
}
@property (nonatomic, nonatomic) IBOutlet UITextField *itemName;
@property (nonatomic, nonatomic) IBOutlet UITextField *itemDescription;
@property (nonatomic, nonatomic) IBOutlet UITextField *itemCost;
- (IBAction)lookingPressed:(id)sender;
- (IBAction)salePressed:(id)sender;
- (IBAction)noPressed:(id)sender;
- (IBAction)yesPressed:(id)sender;

@property(nonatomic,retain)IBOutlet UIImageView *imageView;
-(IBAction)showCameraAction:(id)sender;
- (IBAction)cancelPressed:(id)sender;

- (IBAction)createSale:(id)sender;

@end
