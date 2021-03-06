//  Created by Andrey Ostanin on 08.02.17.
//  Copyright © 2017 Andrey Ostanin. All rights reserved.

#import "XZCommon.h"

/**
 *  View model is beeing generated by data source and used by interface to display saved data
 */
@interface XZViewModel : NSObject
/**
 *  Data that should be displayed as key
 */
@property(nonatomic,strong,readonly)NSString *key;

/**
 *  Data that should be displayed as value
 */
@property(nonatomic,strong,readonly)NSString *value;

/**
 *  Should disclosure indicator should be displayed
 */
@property(nonatomic,assign,readonly)BOOL shouldShowDisclosureIndicator;

/**
 *  Designated initiallizer
 *
 *  @param key                           key
 *  @param value                         value
 *  @param shouldShowDisclosureIndicator should show disclosure indicator
 *
 *  @return initialized instance
 */
- (instancetype)initWithKey:(NSString*)key value:(NSString*)value shouldShowDisclosureIndicator:(BOOL)shouldShowDisclosureIndicator NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)new NS_UNAVAILABLE;
@end
