//
//  JIParkingPlace.h
//  JedAI
//
//  Created by Michael Paschenko on 9/24/18.
//  Copyright © 2018 ANAGOG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JedAIParkingInfo : NSObject
@property (nonatomic, readonly) long arrival;
@property (nonatomic, readonly) long departure;
@property (nonatomic, readonly) long dwellTime;
- (instancetype)initWithArrival:(long)arrival departure:(long)departure dwellTime:(long)dwellTime;
@end

@interface JedAIParkingPlace : NSObject
@property (nonatomic, readonly) long placeId;
@property (nonatomic, readonly) double latitude;
@property (nonatomic, readonly) double longitude;
@property (nonatomic, readonly) NSArray<JedAIParkingInfo*>* parkingInfo;
@property (nonatomic, readonly) long lastVisited;

- (instancetype)initWithId:(long)placeId latitude:(double)latitude longitude:(double)longitude parkingInfo:(NSArray<JedAIParkingInfo*>*)parkingInfo lastVisited:(long)lastVisited;

@end

NS_ASSUME_NONNULL_END
