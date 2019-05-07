//  Created by Andrey Ostanin on 09.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZHistoryDataSource.h"
#import "XZEventHistoryElement.h"
#import "XZViewModel.h"
#import "XZStoreProtocol.h"

@interface XZHistoryDataSource ()
@property(nonatomic,strong)id<XZStoreProtocol> store;
@end

@implementation XZHistoryDataSource
- (instancetype)initWithStore:(id<XZStoreProtocol>)store{
	if ((self = [super init])) {
		_store = store;
	}
	return self;
}

- (NSInteger)count{
	return [self.store objectsCount];
}

- (XZViewModel*)viewModelForIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.row >= [self.store objectsCount]) {
        return nil;
    }
    NSUInteger reversedIndex = [self reversedIndexForIndexPath:indexPath];
    XZEventHistoryElement *eventHistoryElement = [self.store objectWithId:@(reversedIndex)];
    NSString *eventTimestamp = [NSDateFormatter localizedStringFromDate:eventHistoryElement.timestamp dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterLongStyle];
    XZViewModel *viewModel = [[XZViewModel alloc] initWithKey:eventTimestamp  value:nil shouldShowDisclosureIndicator:YES];
    return viewModel;
}

- (id)rawDataForIndexPath:(NSIndexPath*)indexPath{
    if (indexPath.row >= [self.store objectsCount]) {
        return nil;
    }
    
    NSUInteger reversedIndex = [self reversedIndexForIndexPath:indexPath];
    XZEventHistoryElement *eventHistoryElement = [self.store objectWithId:@(reversedIndex)];
    
    id data = eventHistoryElement.data;
    return data;
}

- (NSUInteger)reversedIndexForIndexPath:(NSIndexPath *)indexPath {
    return [self.store objectsCount] - (indexPath.row + 1);
}

@end
