//
//  MVRewardAdInfo.h
//  MVSDK
//
//  Created by yujinping on 16/4/12.
//

#import <Foundation/Foundation.h>

@interface MVRewardAdInfo : NSObject

/**
 *  The ID of the reward as defind on Self Service
 */
@property (nonatomic, copy  ) NSString  *rewardId;

/**
 *  The reward name as defined on Self Service
 */
@property (nonatomic, copy  ) NSString  *rewardName;

/**
 *  Amount of reward type given to the user
 */
@property (nonatomic, assign) NSInteger rewardAmount;


@end
