//
//  ViewController.m
//  MadeByFireDemo
//
//  Created by SreenivasulaReddy on 26/04/17.
//  Copyright © 2017 SreenivasulaReddy. All rights reserved.
//

#import "ViewController.h"
#import "UserViewModel.h"
#import "HorizontalCell.h"
#import "AppDelegate.h"

@import GooglePlaces;
@import GoogleMaps;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,MKMapViewDelegate>
{
    NSMutableArray *tableArray;
    
    UIFont *textFont;
    GMSMarker *marker;
}
@property (strong, nonatomic) IBOutlet GMSMapView *userLocationMap;
@end

@implementation ViewController

-(BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textFont=[UIFont fontWithName:@"Helvetica" size:16.0];
    
    //Rotate the table view
    CGPoint oldCenter = _userTable.center;
    _userTable.frame=CGRectMake(0.0, 0.0, _userTable.bounds.size.height, _userTable.bounds.size.width);
    _userTable.transform=CGAffineTransformMakeRotation(-M_PI_2);
    _userTable.center=oldCenter;
    
    _userTable.showsVerticalScrollIndicator = NO;
    
    
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *tableEntity = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:context];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    fetchRequest.returnsObjectsAsFaults = NO;
    [fetchRequest setEntity: tableEntity];
    NSError* error = nil;
    tableArray = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
    
    if (tableArray.count>0)
    {
        [_userTable reloadData];
    }
    else
    {
        [[[UserViewModel alloc]init] getWebData:^(NSMutableArray *resultArr)
         {
             for (UserViewModel *uvm in resultArr)
             {
                 AppDelegate *appDelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
                 
                 NSManagedObjectContext* context = [appDelegate managedObjectContext];
                 
                 NSManagedObject *entityNameObj = [NSEntityDescription insertNewObjectForEntityForName:@"UserEntity" inManagedObjectContext:context];
                 
                 [entityNameObj setValue:uvm.modelbs forKey:@"dbBs"];
                 [entityNameObj setValue:uvm.modelcatchPhrase forKey:@"dbCatchPhrase"];
                 [entityNameObj setValue:uvm.modelcity forKey:@"dbCity"];
                 [entityNameObj setValue:uvm.modelcompanyName forKey:@"dbCompanyName"];
                 [entityNameObj setValue:uvm.modelemail forKey:@"dbEmail"];
                 [entityNameObj setValue:uvm.modeluserid forKey:@"dbId"];
                 [entityNameObj setValue:uvm.modellat forKey:@"dbLat"];
                 [entityNameObj setValue:uvm.modellng forKey:@"dbLng"];
                 [entityNameObj setValue:uvm.modelname forKey:@"dbName"];
                 [entityNameObj setValue:uvm.modelphone forKey:@"dbPhone"];
                 [entityNameObj setValue:uvm.modelstreet forKey:@"dbStreet"];
                 [entityNameObj setValue:uvm.modelsuite forKey:@"dbSuite"];
                 [entityNameObj setValue:uvm.modelusername forKey:@"dbUsername"];
                 [entityNameObj setValue:uvm.modelwebsite forKey:@"dbWebSite"];
                 [entityNameObj setValue:uvm.modelzipcode forKey:@"dbZipCode"];
                 
                 NSError* error;
                 
                 BOOL isSaved = [context save:&error];
                 
                 if(isSaved==NO || error!=nil)
                 {
                     NSLog(@"Data saving Error: %@",error.debugDescription);
                 }
                 else
                 {
                     NSLog(@"Data saved");
                     
                     AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
                     NSManagedObjectContext *context = [appDelegate managedObjectContext];
                     NSEntityDescription *tableEntity = [NSEntityDescription entityForName:@"UserEntity" inManagedObjectContext:context];
                     
                     NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
                     fetchRequest.returnsObjectsAsFaults = NO;
                     [fetchRequest setEntity: tableEntity];
                     NSError* error = nil;
                     tableArray = [[context executeFetchRequest:fetchRequest error:&error] mutableCopy];
                     
                 }
             }
             [_userTable reloadData];
         }];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    _userTable = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return tableArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifier=@"reusableIdentifier";
    HorizontalCell *cell=(HorizontalCell*)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(nil==cell)
    {
        cell=[[HorizontalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.font = textFont;

    }
   
    NSManagedObject *entityNameObj = [tableArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [entityNameObj valueForKey:@"dbName"];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableArray.count>0)
    {
        [_userTable scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
        
        NSManagedObject *entityNameObj = [tableArray objectAtIndex:indexPath.row];

        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:[[entityNameObj valueForKey:@"dbLat"]floatValue] longitude:[[entityNameObj valueForKey:@"dbLng"]floatValue] zoom:24];
        
        // Creates a marker in the center of the map.
       marker.map = nil;
       marker = [[GMSMarker alloc] init];
       marker.position = CLLocationCoordinate2DMake(camera.target.latitude, camera.target.longitude);

        CLLocationCoordinate2D tar = CLLocationCoordinate2DMake([[entityNameObj valueForKey:@"dbLat"]floatValue], [[entityNameObj valueForKey:@"dbLng"]floatValue]);

        marker.title = [entityNameObj valueForKey:@"dbName"];
        marker.snippet = [entityNameObj valueForKey:@"dbWebSite"];
        marker.map = _userLocationMap;
        
        [_userLocationMap setCamera:[GMSCameraPosition cameraWithTarget:tar zoom:6]];
        [_userLocationMap animateToCameraPosition:[GMSCameraPosition cameraWithTarget:tar zoom:6]];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *entityNameObj = [tableArray objectAtIndex:indexPath.row];
   
    NSString *strCellText= [entityNameObj valueForKey:@"dbName"];

    CGSize textSize = [strCellText sizeWithAttributes:@{ NSFontAttributeName : textFont }];
    return 120.0f;
    return 11+textSize.width;
}

@end
