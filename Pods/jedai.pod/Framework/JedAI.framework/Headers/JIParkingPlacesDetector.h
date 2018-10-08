//
//  JIParkingPlacesDetector.h
//  JedAI
//
//  Created by Michael Paschenko on 9/21/18.
//  Copyright © 2018 ANAGOG ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JedAIParkingPlace.h"

NS_ASSUME_NONNULL_BEGIN

@interface JIParkingPlacesDetector : NSObject

- (BOOL)createActivityClusters;
- (NSArray<JedAIParkingPlace*>*)createParkingPlaces;

@end

NS_ASSUME_NONNULL_END
