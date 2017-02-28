//
//  Header.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@import Foundation;

@class ViewModel;

@protocol DataSourceProtocol
- (NSInteger)count;
- (ViewModel*)viewModelForIndexPath:(NSIndexPath*)indexPath;
- (id)rawDataForIndexPath:(NSIndexPath*)indexPath;
@end