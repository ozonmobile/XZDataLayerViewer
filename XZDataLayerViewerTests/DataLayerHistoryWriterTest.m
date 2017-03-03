//
//  XZDataLayerViewer - DataLayerHistoryWriterTest.m
//  Copyright 2017 XZone Software. All rights reserved.
//
//  Created by: Andrey Ostanin
//

// Class under test
#import "DataLayerHistoryWriter.h"

// Collaborators
#import <UIKit/UIKit.h>
#import "StoreProtocol.h"
#import "DataLayerObserver.h"
#import "EventHistoryElement.h"

@interface DataLayerHistoryWriterTest : XCTestCase
@property(nonatomic,strong)DataLayerHistoryWriter *dataLayerHistoryWriter;
@property(nonatomic,strong)id<StoreProtocol> storeMock;
@property(nonatomic,strong)NSNotificationCenter *notificationCenterMock;
@end

@implementation DataLayerHistoryWriterTest

- (void)setUp {
	[super setUp]; // must be the first line in method
	self.storeMock = OCMProtocolMock(@protocol(StoreProtocol));
	self.notificationCenterMock = OCMClassMock([NSNotificationCenter class]);
	self.dataLayerHistoryWriter = [[DataLayerHistoryWriter alloc] initWithStore:self.storeMock notificationCenter:self.notificationCenterMock];
}

- (void)tearDown {
	self.dataLayerHistoryWriter = nil;
	self.storeMock = nil;
	[super tearDown]; // must be the last line in method
}

#pragma mark - Helper methods


#pragma mark - Tests
- (void)testInitShouldSaveInjectedObjectsInProperties{
	// when
	// everything setUp
	
	// then
	expect(self.dataLayerHistoryWriter.store == self.storeMock).to.beTruthy();
	expect(self.dataLayerHistoryWriter.notificationCenter == self.notificationCenterMock).to.beTruthy();
}

- (void)testInitShouldSubscribeForDataLayerChangeEvent{
	// when
	// everything setUp
	
	// then
	OCMVerify([self.notificationCenterMock addObserverForName:DataLayerHasChangedNotification object:nil queue:OCMOCK_ANY usingBlock:[OCMArg isNotNil]]);
}

- (void)testWriterShouldUnsibscribeSelfFromDataLayerChangeEventWhenDestroyed{
	// given
	__weak DataLayerHistoryWriter *weakDataLayerHistoryWriter = nil;
	id observerId = [[NSObject alloc] init];
	OCMStub([self.notificationCenterMock addObserverForName:OCMOCK_ANY object:OCMOCK_ANY queue:OCMOCK_ANY usingBlock:OCMOCK_ANY]).andReturn(observerId);
	
	// when
	@autoreleasepool {
		DataLayerHistoryWriter *strongDataLayerHistoryWriter = [[DataLayerHistoryWriter alloc] initWithStore:self.storeMock notificationCenter:self.notificationCenterMock];
		weakDataLayerHistoryWriter = strongDataLayerHistoryWriter;
	}
	
	//then
	expect(weakDataLayerHistoryWriter).to.beNil();
	OCMVerify([self.notificationCenterMock removeObserver:observerId]);
}

- (void)testWriterShouldIgnoreNilDataLayerObject{
	// given
	NSDictionary *dataLayerModel = nil;
	
	// when
	[self.dataLayerHistoryWriter writeDataLayerCopyToStore:dataLayerModel];
	
	//then
	OCMVerify([self.storeMock addObject:[OCMArg checkWithBlock:^BOOL(EventHistoryElement *element) {
		expect(element).to.beAnInstanceOf([EventHistoryElement class]);
		expect(element.dataLayerModel).to.beIdenticalTo(dataLayerModel);
		return YES;
	}]]);
}

- (void)testWriterShouldNotCallStoreAddObjectIfEventHistoryWasntCreatedWithDataLayer{
	// given
	NSDictionary *dataLayerModel = @{};
	EventHistoryElement *eventHistoryMock = OCMClassMock([EventHistoryElement class]);
	OCMStub(ClassMethod([(id)eventHistoryMock alloc])).andReturn(nil);
	OCMReject([self.storeMock addObject:OCMOCK_ANY]);
	
	// when
	[self.dataLayerHistoryWriter writeDataLayerCopyToStore:dataLayerModel];
	
	//then
	OCMVerifyAll((id)self.storeMock);
}

@end
