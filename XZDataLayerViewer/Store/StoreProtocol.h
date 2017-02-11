//
//  StoreProtocol.h
//  XZDataLayerViewer
//
//  Created by Andrey Ostanin on 10.02.17.
//  Copyright © 2017 XZone Software. All rights reserved.
//

@protocol StoreProtocol
@property(nonatomic,assign)NSUInteger historyLimit;
- (instancetype)initWithHistoryLimit:(NSUInteger)historyLimit;
- (void)addObject:(id)object;
- (id)objectWithId:(id)identifier;
- (NSUInteger)objectsCount;
- (NSArray*)objects;
@end
