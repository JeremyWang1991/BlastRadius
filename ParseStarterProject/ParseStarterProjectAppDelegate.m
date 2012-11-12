#import <Parse/Parse.h>
#import "ParseStarterProjectAppDelegate.h"
#import "ParseStarterProjectViewController.h"

@implementation ParseStarterProjectAppDelegate
@synthesize navigationController;
@synthesize m_UpdateLocationTimer, m_LocationManager, m_UserCurrentCoordinates, m_UserLocationUpdated;

- (void)startUpdateLocationTimer {
	if (self.m_UpdateLocationTimer) {
		[self.m_UpdateLocationTimer invalidate];
		self.m_UpdateLocationTimer = nil;
	}
	
	self.m_UpdateLocationTimer = [NSTimer scheduledTimerWithTimeInterval:20 target:self selector:@selector(startGettingUserLocation) userInfo:nil repeats:YES];
}

- (void)endUpdateLocationTimer {
	if (self.m_UpdateLocationTimer) {
		[self.m_UpdateLocationTimer invalidate];
		self.m_UpdateLocationTimer = nil;
	}
}

- (void)startGettingUserLocation {
	//Start getting User Current Location
	if (self.m_LocationManager == nil) {
		self.m_LocationManager = [[CLLocationManager alloc] init];
		self.m_LocationManager.delegate = self;
		self.m_LocationManager.desiredAccuracy = kCLLocationAccuracyBest;
	}
	
	[self.m_LocationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	//Get user's current location
    CLLocation* fakeLocation;
    CLLocationCoordinate2D fakeLoc;
    fakeLoc.latitude=43.646279;
    fakeLoc.longitude=-79.397786;
    
	self.m_UserCurrentCoordinates = newLocation.coordinate;
	
	//Stop location manager from getting updated location
	[self.m_LocationManager stopUpdatingLocation];
	
	if (self.m_UserLocationUpdated == NO) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"REFRESH_EVENTS" object:nil];
		
		self.m_UserLocationUpdated = YES;
	}
	
	if (self.m_UpdateLocationTimer == nil) {
	}
}



#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"VGuPJYZw4ZevI3fuU0LnUjn65IUWVzC76Jt7cO7T"
                  clientKey:@"ygslxvn9HTwKWq2HwOqZ8Y5vNDEid6CSpgkyYMUX"];
    [PFUser enableAutomaticUser];
    
    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Override point for customization after application launch.
     
    ParseStarterProjectViewController* vc = [[ParseStarterProjectViewController alloc] initWithNibName:@"ParseStarterProjectViewController" bundle:nil];
        self.navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
	
	self.navigationController.navigationBarHidden = YES;
    
    // Add the navigation controller's view to the window and display.
    _window.rootViewController = navigationController;

    [self.window makeKeyAndVisible];
    [self startGettingUserLocation];
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeAlert|
                                                    UIRemoteNotificationTypeSound];
    return YES;
}

/*
 
///////////////////////////////////////////////////////////
// Uncomment this method if you are using Facebook
///////////////////////////////////////////////////////////
 
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
} 
 
*/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}


@end
