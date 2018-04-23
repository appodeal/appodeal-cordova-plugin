//
//  MVFrame.h
//  MVSDK
//
//  Created by Jomy on 16/1/28.
//

#import <Foundation/Foundation.h>
#import "MVCampaign.h"

__deprecated_msg("Class is deprecated.")

@interface MVFrame : NSObject

/*!
 @property
 
 @abstract The dataTemplate of the frame
 */
@property (nonatomic, assign) MVAdTemplateType templateType;

/*!
 @property
 
 @abstract The ad source of the frame
 */
@property (nonatomic, assign) MVAdSourceType sourceType;

/*!
 @property
 
 @abstract The timestap of the frame
 */
@property (nonatomic, assign) double      timestamp;

/*!
 @property
 
 @abstract The id of the frame
 */
@property (nonatomic, strong) NSString      *frameId;

/*!
 @property
 
 @abstract The native ads contained in this frame. Array of MVCampaign objects.
 */
@property (nonatomic, strong) NSArray *nativeAds;

@end
