//
//  MTRGPromoCardCollectionView.h
//  myTargetSDK 4.6.22
//
//  Created by Andrey Seredkin on 02.11.16.
//  Copyright © 2016 Mail.ru Group. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MyTargetSDK/MTRGNativePromoCard.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MTRGPromoCardCollectionViewDelegate <NSObject>

- (void)onCardClick:(MTRGNativePromoCard *)card;
- (void)onCardChange:(MTRGNativePromoCard *)card;

@end

@interface MTRGPromoCardCollectionView : UICollectionView <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak, nullable) id <MTRGPromoCardCollectionViewDelegate> cardCollectionViewDelegate;
@property (nonatomic, readonly, nullable) MTRGNativePromoCard *currentPromoCard;

- (void)setCards:(NSArray<MTRGNativePromoCard *> *)cards;

@end

NS_ASSUME_NONNULL_END
