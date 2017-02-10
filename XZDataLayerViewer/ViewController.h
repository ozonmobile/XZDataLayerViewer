//
//  ViewController.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 06.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DataSourceProtocol;

@interface ViewController : UITableViewController
- (instancetype)initWithDataSource:(id<DataSourceProtocol>)dataSource;

@end

