//
//  CLLocation+NSDictionary.m
//
//  Created by Brandon Emrich on 11/27/11.
//  Copyright (c) 2011 Zueos, Inc. All rights reserved.
//

#import "CLLocation+NSDictionary.h"

@implementation CLLocation (NSDictionary)

- (id)initWithDictionary:(NSDictionary*)dictRep {
    CLLocationCoordinate2D coordinate = {.latitude=0, .longitude=0};
    
    CLLocationAccuracy hAccuracy = -1.0;
    if ([dictRep objectForKey:@"latitude"] && [dictRep objectForKey:@"longitude"]) {
        hAccuracy = 0.0;
        
        CLLocationDegrees lat = [[dictRep objectForKey:@"latitude"] doubleValue];
        CLLocationDegrees lon = [[dictRep objectForKey:@"longitude"] doubleValue];
        coordinate = CLLocationCoordinate2DMake(lat, lon);
        
        if ([dictRep objectForKey:@"horizontalAccuracy"]) {
            hAccuracy = [[dictRep objectForKey:@"horizontalAccuracy"] doubleValue];
        }
    }
    
    CLLocationDistance altitude = 0.0;
    CLLocationAccuracy vAccuracy = -1.0;
    
    if ([dictRep objectForKey:@"altitude"]) {
        
        altitude = [[dictRep objectForKey:@"altitude"] doubleValue];
        
        if ([dictRep objectForKey:@"verticalAccuracy"]) {
            vAccuracy = [[dictRep objectForKey:@"verticalAccuracy"] doubleValue];
        }
        
    }
    
    NSDate* timestamp = nil;
    
    if ([dictRep objectForKey:@"timestamp"]) {
        
        NSTimeInterval epochTimestamp = [[dictRep objectForKey:@"timestamp"] doubleValue];
        timestamp = [NSDate dateWithTimeIntervalSinceReferenceDate:epochTimestamp];
        
    } else {
        
        timestamp = [NSDate date];
    }
    
    // What about course and speed?
    
    return [self initWithCoordinate:coordinate altitude:altitude horizontalAccuracy:hAccuracy verticalAccuracy:vAccuracy timestamp:timestamp];
}

//- (id)initWithJSON:(NSString*)json {
//    NSDictionary *dict = [json objectFromJSONString];
//    return [self initWithDictionary:dict];
//}

- (NSDictionary*)dictionaryRepresentation {
    NSMutableDictionary* dictRep = [NSMutableDictionary dictionary];
    NSDateFormatter *df_utc = [[NSDateFormatter alloc] init];
    [df_utc setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [df_utc setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];


    [dictRep setObject:[NSNumber numberWithDouble:self.coordinate.latitude] forKey:@"latitude"];
    [dictRep setObject:[NSNumber numberWithDouble:self.coordinate.longitude] forKey:@"longitude"];
    
    [dictRep setObject: [df_utc stringFromDate:self.timestamp] forKey:@"timestamp"];
    [dictRep setObject:[NSNumber numberWithDouble:self.altitude] forKey:@"altitude"];
    
    [dictRep setObject:[NSNumber numberWithDouble:self.course] forKey:@"course"];
    [dictRep setObject:[NSNumber numberWithDouble:self.speed] forKey:@"speed"];
    
    [dictRep setObject:[NSNumber numberWithDouble:self.horizontalAccuracy] forKey:@"horizontalAccuracy"];
    [dictRep setObject:[NSNumber numberWithDouble:self.verticalAccuracy] forKey:@"verticalAccuracy"];
    
    return dictRep;
}

//- (NSString*) JSONString {
//    NSDictionary *dict = [self dictionaryRepresentation];
//    return [dict JSONString];
//}

@end


