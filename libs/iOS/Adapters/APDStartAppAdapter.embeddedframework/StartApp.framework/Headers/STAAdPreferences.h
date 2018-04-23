//
//  StartAppAd.h
//  StartAppAdSDK
//
//  Copyright (c) 2013 StartApp. All rights reserved.
//  SDK version 3.5.1

@interface STAUserLocation : NSObject
@property  double latitude;
@property  double longitude;
@end

// STAAdPreferences holds params specific to an ad
@interface STAAdPreferences : NSObject
@property (nonatomic,retain) STAUserLocation *userLocation;
@property (nonatomic,assign) double minCPM;

+ (instancetype)prefrencesWithLatitude:(double)latitude andLongitude:(double)longitude;
+ (instancetype)preferencesWithMinCPM:(double)minCPM;
@end
