#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>
#import "SellViewController.h"
#import "ParseStarterProjectAppDelegate.h"

@implementation ParseStarterProjectViewController


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {

//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    [testObject setObject:@"barzoobx" forKey:@"foo"];
//    [testObject save];
//    PFObject *testObject = [PFObject objectWithClassName:@"ItemForSale"];
//    [testObject setObject:@"iPhone 5" forKey:@"Name"];
//    [testObject setObject:@"500" forKey:@"Cost"];
//    [testObject setObject:@"I am selling my iPhone 4S as I have upgraded to the iPhone 5. It is in perfect working condition and comes with a blue/green iSkin Solo case included. The earphones still have the original wrapping as they have never been used. The charger is in perfect condition as well." forKey:@"Description"];
//    [testObject setObject:@"50M" forKey:@"Distance"];
//    [testObject saveInBackground];
//    NSLog(@"XXX");
    [super viewDidLoad];

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)sellPressed:(id)sender {
    SellViewController* vc = [[SellViewController alloc] initWithNibName:@"SellViewController" bundle:nil];
   	[self.navigationController pushViewController:vc animated:YES];
}
@end
