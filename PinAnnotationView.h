//
//  PinAnnotationView.h
//  JabberMap
//
//  Created by Jasdeep on 19/05/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface PinAnnotationView :MKAnnotationView <MKAnnotation>{
	CLLocationCoordinate2D coordinate;
	NSString *title;
	NSString *subtitle;
    UIImage *theImage;
	int tag;
}

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) UIImage *theImage;
@property (nonatomic, assign) int tag;

@end
