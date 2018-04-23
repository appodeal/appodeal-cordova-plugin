//
//  MTRGContentStreamCardAdView.h
//  myTargetSDK 4.6.22
//
//  Created by Andrey Seredkin on 20.10.16.
//  Copyright © 2016 Mail.ru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGPromoCardViewProtocol.h>
#import <MyTargetSDK/MTRGMediaAdView.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTRGContentStreamCardAdView : UICollectionViewCell <MTRGPromoCardViewProtocol>

@property(nonatomic, readonly) UILabel *titleLabel;
@property(nonatomic, readonly) UILabel *descriptionLabel;
@property(nonatomic, readonly) UILabel *ctaButtonLabel;
@property(nonatomic, readonly) MTRGMediaAdView *mediaAdView;

- (CGFloat)heightWithCardWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
