//
//  NewSaleViewController.m
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-10.
//
//

#import "NewSaleViewController.h"
#import <Parse/Parse.h>
#import "ParseStarterProjectAppDelegate.h"

@interface NewSaleViewController ()

@end

@implementation NewSaleViewController
@synthesize itemCost,itemDescription,itemName,imageView;
//@synthesize lookingBtn,saleBtn,paypalBtn,creditBtn,cashBtn;

-(IBAction)showCameraAction:(id)sender
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    //You can use isSourceTypeAvailable to check
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=NO;
    imagePickController.showsCameraControls=YES;
    //This method inherit from UIView,show imagePicker with animation
    [self presentModalViewController:imagePickController animated:YES];
}

- (IBAction)cancelPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Check Save Image Error
- (void)CheckedImage:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    UIAlertView *alert;
    
    if (error) {
        alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                           message:[error description]
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                           message:@"The image has been stored in an album"
                                          delegate:self
                                 cancelButtonTitle:@"OK"
                                 otherButtonTitles:nil];
    }
    
    [alert show];
}

#pragma mark - When Finish Shoot

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Dismiss controller
    [picker dismissModalViewControllerAnimated:YES];
    
    // Resize image
    UIGraphicsBeginImageContext(CGSizeMake(640, 960));
    [image drawInRect: CGRectMake(0, 0, 640, 960)];
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    //Show OriginalImage size
    NSLog(@"OriginalImage width");
    imageView.image=image;
    [self dismissModalViewControllerAnimated:YES];
    
    // Upload image
    imageData = UIImageJPEGRepresentation(image, 0.05f);
}

-(void)uploadImage:(NSData *)imageData
{
    
}

#pragma mark - When Tap Cancel

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

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
    itemName.delegate=self;
    itemDescription.delegate=self;
    itemCost.delegate=self;
    [noBtn setImage:[UIImage imageNamed:@"btn_invis.png"] forState:UIControlStateNormal];
    [noBtn setSelected:NO];
    [lookingBtn setImage:[UIImage imageNamed:@"btn_invis.png"] forState:UIControlStateNormal];
    [lookingBtn setSelected:NO];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"touchesBegan:withEvent:");
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldBeginEditing");
    textField.backgroundColor = [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.0f];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"textFieldDidBeginEditing");
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSLog(@"textFieldShouldEndEditing");
    textField.backgroundColor = [UIColor whiteColor];
    return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"textFieldDidEndEditing");
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
      return YES;
}



- (void)viewDidUnload {
    [self setItemName:nil];
    [self setItemDescription:nil];
    [self setItemCost:nil];
    saleBtn = nil;
    [super viewDidUnload];
}
- (IBAction)createSale:(id)sender {
    PFFile *imageFile = [PFFile fileWithName:@"Image.jpg" data:imageData];
    PFObject *testObject = [PFObject objectWithClassName:@"ItemForSale"];
    NSString *name = itemName.text;
    NSString *description = itemDescription.text;
    NSString *cost = itemCost.text;
    [testObject setObject:imageFile forKey:@"imageFile"];
    [testObject setObject:name forKey:@"Name"];
    [testObject setObject:cost forKey:@"Cost"];
    [testObject setObject:description forKey:@"Description"];
    [testObject setObject:@"~5m away" forKey:@"Distance"];
    
    ParseStarterProjectAppDelegate* appDelegate = (ParseStarterProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	float laty = appDelegate.m_UserCurrentCoordinates.latitude;
    float longy = appDelegate.m_UserCurrentCoordinates.longitude;
    NSNumber *nLat = [NSNumber numberWithFloat:laty];
    NSNumber *nLong = [NSNumber numberWithFloat:longy];
    
    [testObject setObject:nLat forKey:@"latitude"];
    [testObject setObject:nLong forKey:@"longitude"];
    [testObject saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            // There was an error saving the gameScore.
        }
    }];
}
- (IBAction)lookingPressed:(id)sender {
    if ([lookingBtn isSelected]) {
    }else {
        [lookingBtn setImage:[UIImage imageNamed:@"btn_lookingfor.png"] forState:UIControlStateSelected];
        [lookingBtn setSelected:YES];
        [saleBtn setImage:[UIImage imageNamed:@"btn_invis.png"] forState:UIControlStateNormal];
        [saleBtn setSelected:NO];
    }
}

- (IBAction)salePressed:(UIButton *)sender {
    if ([saleBtn isSelected]) {
    }else {
        [saleBtn setImage:[UIImage imageNamed:@"btn_forsale.png"] forState:UIControlStateSelected];
        [saleBtn setSelected:YES];
        [lookingBtn setImage:[UIImage imageNamed:@"btn_invis.png"] forState:UIControlStateNormal];
        [lookingBtn setSelected:NO];
    }
}
- (IBAction)noPressed:(id)sender {
    if ([noBtn isSelected]) {
    }else {
        [noBtn setImage:[UIImage imageNamed:@"btn_no.png"] forState:UIControlStateSelected];
        [noBtn setSelected:YES];
        [yesBtn setImage:[UIImage imageNamed:@"btn_invis.png"] forState:UIControlStateNormal];
        [yesBtn setSelected:NO];
    }

}

- (IBAction)yesPressed:(id)sender {
    if ([yesBtn isSelected]) {
    }else {
        [yesBtn setImage:[UIImage imageNamed:@"btn_yes.png"] forState:UIControlStateSelected];
        [yesBtn setSelected:YES];
        [noBtn setImage:[UIImage imageNamed:@"btn_invis.png"] forState:UIControlStateNormal];
        [noBtn setSelected:NO];
    }
}
@end
