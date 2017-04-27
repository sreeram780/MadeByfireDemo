//
//  ViewController.h
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITableView *userTable;
@property (strong, nonatomic) IBOutlet MKMapView *usersMap;

@end

