//
//  ActivityInVehicleEvent.h
//  JedAI
//
//  Created by Michael Paschenko on 8/1/18.
//  Copyright © 2018 ANAGOG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ActivityEvent.h"

typedef NS_ENUM(NSUInteger, IN_VEHICLE_CONFIDENCE) {
    DRIVING_LOW_CONFIDENCE = 1,
    DRIVING_HIGH_CONFIDENCE = 2
};

typedef NS_ENUM(NSUInteger, VehicleType) {
    TR_UNDEFINED = 1,
    TR_CAR = 1 << 1,
    TR_BUS = 1 << 2,
    TR_TRAIN = 1 << 3,
    TR_BOAT = 1 << 4,
    TR_AIRPLAIN = 1 << 5
};

/**
 * Inherits from {@link ActivityEvent}, and represents the activity events.
 */

@interface ActivityInVehicleEvent : ActivityEvent
- (instancetype)initWithTimestamp:(long)eventTimestamp
                         location:(CLLocationCoordinate2D)location
                          isStart:(bool)isStart
                         activity:(int)activity
                   withConfidence:(int)confidence
               vehicleType:(VehicleType)vehicleType
                     withTimestampLocal:(long) eventTimestampLocal;
/**
 *
 * @return the type of vehicle used.
 * Possible values are {@link #CAR}, {@link #BUS}, {@link #TRAIN}, {@link #CAR}, {@link #WATER}, {@link #AIR}
 */
@property (nonatomic, readonly) VehicleType vehicleType;

@end
