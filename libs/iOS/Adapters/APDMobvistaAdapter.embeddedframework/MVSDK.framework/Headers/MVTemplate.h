//
//  MVTemplate.h
//  MVSDK
//
//  Created by Jomy on 16/2/3.
//

#import <Foundation/Foundation.h>
#import "MVCampaign.h"

/*!
 @class MVTemplate
 
 @abstract This class defines what type of ads and how many ads you want to retrive in one template.
 */
@interface MVTemplate : NSObject

/*!
 @property
 
 @abstract It is an enumeration value. The default value is MVAD_TEMPLATE_ONLY_ICON. It defines what type of ads you want to retrive in one template.
 */
@property (nonatomic, assign) MVAdTemplateType templateType;

/*!
 @property
 
 @abstract It defines how many ads you want to retrive in one template.
 */
@property (nonatomic, assign) NSUInteger adsNum;

/**
 *
 @method
 
 @abstract The method defines which kinds of template you want to retrive.
 
 @param templateType It is an enumeration value. The default value is MVAD_TEMPLATE_ONLY_ICON. It defines what type of ads you want to retrive in one template.
 @param adsNum It defines how many ads you want to retrive in one template.
 */
+ (MVTemplate *)templateWithType:(MVAdTemplateType)templateType adsNum:(NSUInteger)adsNum;

@end