//
//  VisitEvent.h
//  JedAI
//
//  Created by Michael Paschenko on 5/12/18.
//  Copyright © 2018 ANAGOG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JedAIEvent.h"
#import "Poi.h"

/**
 * `VisitEvent` event that represents a visit
 */
@interface VisitEvent : JedAIEvent

/** Init method
 
 
 - (id)initWithTimestamp:(long)eventTimestamp location:(CLLocationCoordinate2D)location poi:(Poi*)poi isVisitStarted:(bool)isVisitStarted  withTimeZone:(int) timeZone;
 
 poi:(Poi* _Nullable)poi
 isVisitStarted:(bool)isVisitStarted
 netCountry:(NSString*)netCountry
 simCountry:(NSString*)simCountry;

 
 */


- (id _Nullable )initWithTimestamp:(long)eventTimestamp location:(CLLocationCoordinate2D)location poi:(Poi*_Nonnull)poi isVisitStarted:(bool)isVisitStarted netCountry:(NSString*_Nullable)netCountry simCountry:(NSString*_Nullable)simCountry withTimestampLocal:(long) eventTimestampLocal;
/**
 * @return the visited POI
 */
@property (nonatomic, readonly, strong) Poi* _Nullable poi;

@property (nonatomic, readonly, strong) NSString* _Nullable netCountry;

@property (nonatomic, readonly, strong) NSString* _Nonnull simCountry;

@end
