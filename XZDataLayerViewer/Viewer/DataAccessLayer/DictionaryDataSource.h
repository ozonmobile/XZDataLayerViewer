//
//  DictionaryDataSource.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@import Foundation;
#import "DataSourceProtocol.h"

@interface DictionaryDataSource : NSObject <DataSourceProtocol>
- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
@end