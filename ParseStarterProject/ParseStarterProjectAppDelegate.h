#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@class ParseStarterProjectViewController;

@interface ParseStarterProjectAppDelegate : NSObject <UIApplicationDelegate,CLLocationManagerDelegate> {
    UINavigationController *navigationController;
    NSTimer*					m_UpdateLocationTimer;
	CLLocationManager*			m_LocationManager;
	CLLocationCoordinate2D		m_UserCurrentCoordinates;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@property (nonatomic, strong) IBOutlet ParseStarterProjectViewController *viewController;
@property (nonatomic, retain) NSTimer*					m_UpdateLocationTimer;
@property (nonatomic, retain) CLLocationManager*		m_LocationManager;
@property (nonatomic, assign) CLLocationCoordinate2D	m_UserCurrentCoordinates;
@property (nonatomic, assign) BOOL						m_UserLocationUpdated;

- (void)startGettingUserLocation;
- (void)startUpdateLocationTimer;
- (void)endUpdateLocationTimer;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;


@end
