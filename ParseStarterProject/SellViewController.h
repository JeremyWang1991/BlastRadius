//
//  SellViewController.h
//  ParseStarterProject
//
//  Created by Tse-Chi Wang on 12-11-10.
//
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SellViewController : UIViewController<MKMapViewDelegate>
{
    UITableView*				m_TableView;
    NSMutableArray*				m_SalesArray;
    MKMapView*	_mapView;
}

@property (nonatomic, retain) IBOutlet UITableView*		m_TableView;
@property (nonatomic, retain) NSMutableArray*			m_SalesArray;
@property (retain, nonatomic) IBOutlet UIButton *btnSwap;
@property (retain, nonatomic) IBOutlet MKMapView *_mapView;

- (IBAction)newSale:(id)sender;
- (IBAction)cancelPressed:(id)sender;
- (IBAction)swap:(id)sender;
- (IBAction)refresh:(id)sender;


@end
