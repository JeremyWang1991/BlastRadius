//
//  SellViewController.m
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-10.
//
//

#import "SellViewController.h"
#import <Parse/Parse.h>
#import "NewSaleViewController.h"
#import "SaleCell.h"
#import "SaleDetailVC.h"
#import "ParseStarterProjectAppDelegate.h"
#import "PinAnnotationView.h"


@interface SellViewController ()

@end

@implementation SellViewController
@synthesize m_SalesArray, m_TableView,_mapView;

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    m_SalesArray = [[NSMutableArray alloc] init];
	[self addLocationsToMap];
    NSLog(@"%i",[m_SalesArray count]);
//	self.m_TableView.separatorColor = [UIColor whiteColor];

}


-(void)viewDidAppear:(BOOL)animated
{
    [m_SalesArray removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"ItemForSale"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            //            NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
            //            [event setObject:longy forKey:@"longitude"];
            //            [event setObject:latty forKey:@"latitude"];
            //            [event setObject:[NSString stringWithFormat:@"Interesting Shit"] forKey:@"title"];
            [m_SalesArray addObjectsFromArray:objects];
            NSLog(@"z%iz",[m_SalesArray count]);
            [m_TableView reloadData];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    [m_TableView reloadData];
 
}

#pragma mark -
#pragma mark Table view data source and delegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"%i",[m_SalesArray count]);
	return [m_SalesArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	return 100;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SaleCell *cell = (SaleCell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"SaleCell" owner:nil options:nil];
		for (id currentObject in topLevelObjects) {
			if ([currentObject isKindOfClass:[UITableViewCell class]]) {
				cell = (SaleCell*)currentObject;
				cell.selectionStyle = UITableViewCellSelectionStyleNone;
				break;
			}
		}
    }
    cell.itemTitle.text = [[self.m_SalesArray objectAtIndex:indexPath.row] objectForKey:@"Name"];
    cell.itemDescription.text = [[self.m_SalesArray objectAtIndex:indexPath.row] objectForKey:@"Description"];
    cell.itemDistance.text = [[self.m_SalesArray objectAtIndex:indexPath.row] objectForKey:@"Distance"];
    cell.itemCost.text = [[self.m_SalesArray objectAtIndex:indexPath.row] objectForKey:@"Cost"];
    cell.itemCost.text = [cell.itemCost.text stringByAppendingString:@"$"];
    
    PFFile *theImage = [[self.m_SalesArray objectAtIndex:indexPath.row] objectForKey:@"imageFile"];
    NSData *imageData = [theImage getData];
    UIImage *image = [UIImage imageWithData:imageData];

    cell.itemImagez.image = image;
    cell.backgroundColor = [UIColor clearColor];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
	SaleDetailVC *vc = [[SaleDetailVC alloc] initWithNibName:@"SaleDetailVC" bundle:nil];
	vc._m_salesObject = [self.m_SalesArray objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)hideAccesoryView:(UIImageView*)imgView {
	imgView.hidden = YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)newSale:(id)sender {
    	NewSaleViewController *vc = [[NewSaleViewController alloc] initWithNibName:@"NewSaleViewController" bundle:nil];
    	[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)cancelPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)swap:(id)sender {
    
	if ([sender isSelected] == NO) {	//Show List View
		[self.btnSwap setImage:[UIImage imageNamed:@"btn_map"] forState:UIControlStateNormal];
        [sender setSelected:YES];
		self._mapView.hidden	= YES;
		self.m_TableView.hidden = NO;
	}
	else {	//Show Map View
		
		[self.btnSwap setImage:[UIImage imageNamed:@"btn_list.png"] forState:UIControlStateNormal];
        [sender setSelected:NO];

		self.m_TableView.hidden = YES;
		self._mapView.hidden	= NO;
	}
}

- (IBAction)refresh:(id)sender {
	
	//Remove previous pins
	for (id annotation in self._mapView.annotations)
    {
    	if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [self._mapView removeAnnotation:annotation];
        }
    }
    [m_SalesArray removeAllObjects];
    PFQuery *query = [PFQuery queryWithClassName:@"ItemForSale"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            
            //            NSMutableDictionary *event = [[NSMutableDictionary alloc] init];
            //            [event setObject:longy forKey:@"longitude"];
            //            [event setObject:latty forKey:@"latitude"];
            //            [event setObject:[NSString stringWithFormat:@"Interesting Shit"] forKey:@"title"];
            [m_SalesArray addObjectsFromArray:objects];
            NSLog(@"z%iz",[m_SalesArray count]);
            [m_TableView reloadData];
            [self addLocationsToMap];

        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

}

- (void)addLocationsToMap {
	
	//Remove previous pins
	for (id annotation in self._mapView.annotations)
    {
    	if (![annotation isKindOfClass:[MKUserLocation class]]) {
            [self._mapView removeAnnotation:annotation];
        }
    }
	
	self._mapView.showsUserLocation = YES;
	
	//Load map view with events
	[self._mapView setRegion:[self setMapRegionToUserLocation] animated:YES];
	[self createEvents];
}

-(void)createEvents
{
    if (self.m_SalesArray != nil) {
        NSLog(@"X");
		NSInteger pinTag = 0;
		for (PFObject *eventDict in self.m_SalesArray) {
			PinAnnotationView *annotation = [[PinAnnotationView alloc] init];
			annotation.title = [eventDict objectForKey:@"title"];
			annotation.subtitle = @"";

            PFFile *theImage = [eventDict objectForKey:@"imageFile"];
            NSData *imageData = [theImage getData];
            UIImage *image = [UIImage imageWithData:imageData];
            
            annotation.theImage = image;
			
			CLLocationCoordinate2D pinCoordinate;
			pinCoordinate.latitude = [[eventDict objectForKey:@"latitude"] floatValue];
			pinCoordinate.longitude = [[eventDict objectForKey:@"longitude"] floatValue];
            
			annotation.coordinate = pinCoordinate;
			
			annotation.tag = pinTag;
			[self._mapView addAnnotation:annotation];

			pinTag++;
		}
	}
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
		return nil;
	}

    static NSString *identifier = @"MyLocation";
    if ([annotation isKindOfClass:[PinAnnotationView class]]) {
        NSLog(@"OBJECTMET");

        MKAnnotationView *annotationView = (MKPinAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        } else {
            annotationView.annotation = annotation;
        }
        annotationView.enabled = YES;
        annotationView.canShowCallout = NO;

        
        NSString *imagePath = [[NSString alloc] initWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:@"img_blastbox" ofType:@"png"]];
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
        annotationView.image = image;
        UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        btn.titleLabel.text = @"WTF";
        
        NSString *imagePath2 = [[NSString alloc] initWithFormat:@"%@", [[NSBundle mainBundle] pathForResource:@"btn_blast" ofType:@"png"]];
        UIImage *image2 = [[UIImage alloc] initWithContentsOfFile:imagePath2];
        
        PFObject *eventDict = [self.m_SalesArray objectAtIndex:((PinAnnotationView*)annotation).tag];

        PFFile *theImage = [eventDict objectForKey:@"imageFile"];
        NSData *imageData = [theImage getData];
        UIImage *imagez = [UIImage imageWithData:imageData];
        
        UIImageView *shadowView = [[UIImageView alloc] initWithFrame:CGRectMake(4,4, 50, 50)];
        shadowView.image = imagez;
        [annotationView addSubview:shadowView];
        btn.imageView.image=image2;
        btn.tag = ((PinAnnotationView*)annotation).tag;
        [btn addTarget:self action:@selector(loadEventDetails:) forControlEvents:UIControlEventTouchUpInside];
        [annotationView addSubview:btn];
        return annotationView;
    } else {
        static NSString* AnnotationIdentifier = @"Annotation";
        MKAnnotationView *customPinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];

        customPinView.canShowCallout = YES;
        return customPinView;
    }
    
    return nil;
}


- (MKCoordinateRegion)setMapRegionToUserLocation {
	MKCoordinateRegion zoomIn = self._mapView.region;
	zoomIn.span.latitudeDelta = 0.005;
	zoomIn.span.longitudeDelta = 0.005;
	ParseStarterProjectAppDelegate* appDelegate = (ParseStarterProjectAppDelegate*)[[UIApplication sharedApplication] delegate];
	zoomIn.center = appDelegate.m_UserCurrentCoordinates;
	return zoomIn;
}
- (void)loadEventDetails:(UIButton*)sender {
	SaleDetailVC *vc = [[SaleDetailVC alloc] initWithNibName:@"SaleDetailVC" bundle:nil];
	vc._m_salesObject = [self.m_SalesArray objectAtIndex:sender.tag];
	[self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidUnload {
    [self set_mapView:nil];
    [self setBtnSwap:nil];
    [super viewDidUnload];
}
@end
