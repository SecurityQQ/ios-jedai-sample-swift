//
//  JedAI.h
//  JedAI
//
//  Created by Hezi Cohen on 3/1/18.
//  Copyright © 2018 ANAGOG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ActivityInVehicleEvent.h"
#import "ActivityEvent.h"
#import "EventConfig.h"
#import "VisitEvent.h"
#import "JedAIEventDelegate.h"
#import "DevTools.h"
#import "JILogLevel.h"
#import "FMResultSet.h"
#import "JedAIParkingPlace.h"

@class EventConfig;
@class AnagogLocation;

/// Project version number for JedAI.
FOUNDATION_EXPORT double JedAIVersionNumber;

/// Project version string for JedAI.
FOUNDATION_EXPORT const unsigned char JedAIVersionString[];

/**
 `JedAI` is the main class of the sdk in charge of start/stop of the entire logic
 */

@interface JedAI : NSObject

/**
 Returns singleton instance
 */
+ (instancetype _Nonnull )sharedInstance;

/**
 Setup sdk, performs reading of the initial config etc
 */
- (void)setup;

#if TARGET_IPHONE_SIMULATOR
/**
 Setup sdk, with simulated scenario
 */
- (void)setupWithSimulatedScenario:(NSDictionary * _Nonnull)scenario;
#endif

/**
 Start sdk
 */

- (void)start;
/**
 Stop sdk
 */
- (void)stop;


/**
 Register callback, which would be fired on visits detection event
 */
- (void)registerEvents:(id <JedAIEventDelegate> _Nonnull) eventDelegate eventConfig:(EventConfig*_Nonnull)config;

/**
  Unregister callback, which would be fired on visits detection event
 */
- (void)unregisterEvents:(id<JedAIEventDelegate> _Nonnull) eventDelegate;

/** get most visited POI list from date provided and limited by value
 @param limit limit number of returned entries
 @param fromDate filter date range fromDate provided till now
 @return sorted array [{numVisits : poi}, ... , {numVisits : poi}]
 */

- (NSArray* _Nullable) getTopPOIsList:(int)limit fromDate:(NSDate* _Nonnull)fromDate;

/** get most visited POI list since 3 month ago and limited by 5 */
- (NSArray* _Nullable)getTopPOIsList;

/** get top poi array by NSPredicate provided
 predicate can be build using following fields, from visits table:
    double accuracy;
    NSDate *enterDate;
    NSDate *exitDate;
    double latitude;
    double longitude;
    double poiConfidence;
    int16_t visitType;
    Poi* poi {
        double centerLat;
        double centerLng;
        int32_t locationID;
        NSString *name;
        NSObject *poly;
        int32_t priority;
        int32_t special;
        NSString *tags;
        NSString *type;
        NSString *value;
    }
 */
- (NSArray* _Nullable)getTopPOIsListByPredicate:(NSPredicate*_Nonnull)predicate;

/** get all POI */
- (NSArray* _Nullable) getPOIsList;
/** get POI by ID*/
- (Poi* _Nullable) getPOIById:(NSNumber*_Nullable)Id;

/** get all visit events */
- (NSArray* _Nullable)getAllVisitEvents;

/** get visits array by NSPredicate provided
 predicate can be build using following fields, from visits table:
    double accuracy;
    NSDate *enterDate;
    NSDate *exitDate;
    double latitude;
    double longitude;
    double poiConfidence;
    int16_t visitType;
    Poi* poi {
        double centerLat;
        double centerLng;
        int32_t locationID;
        NSString *name;
        NSObject *poly;
        int32_t priority;
        int32_t special;
        NSString *tags;
        NSString *type;
        NSString *value;
    }
 */
- (NSArray* _Nullable)getVisitEventsByPredicate:(NSString* _Nonnull)predicate;

/** get location history */
- (NSArray<CLLocation*>* _Nullable) getLocationHistory;

/** get locations array by NSPredicate provided
 predicate can be build using following fields, from locations table:
 double alt;
 double course;
 int16_t floor;
 float horizontalAccuracy;
 double lat;
 double lng;
 int16_t origin;
 double speed;
 NSDate *timestamp;
 double verticalAccuracy;
 */
- (NSArray<CLLocation*>* _Nullable)getLocationHistoryByPredicate:(NSString*_Nullable)sql;


/** refresh POI database based on last visit location or last location */
- (void)refreshPoiDB:(void (^_Nonnull)(BOOL status))completion;
- (CLLocation* _Nullable)getLastLocation;
- (AnagogLocation* _Nullable)getLastAnagogLocation;

/** enable activity recognitions,
  @param enabled activity recognition should be enabled
  @throws exception if activity module is disabled
 */
- (void)setActivityRecognitionEnabled:(BOOL)enabled;

- (FMResultSet* _Nullable)getActivitiesBySqlQuery:(NSString* _Nonnull)sql;

- (NSString* _Nonnull)databaseFilePath;

- (NSArray<JedAIParkingPlace*>* _Nullable) getParkingPlaces;
- (NSArray<JedAIParkingPlace*>* _Nullable) getParkingPlaces:(bool)refreshClusters;

// timeline
- (NSArray* _Nullable)getEventsJSON:(long)startDate endDate:(long)endDate;

- (void)createActivityClusters;

@end
