//
//  MVNativeScrollView.h
//  MVSDK
//
//  Created by Jomy on 16/1/28.
//

#import <UIKit/UIKit.h>
#import "MVFrame.h"

__deprecated_msg("Delegate is deprecated.")

/*!
 @protocol MVNativeScrollViewDelegate
 
 @abstract Messages from MVNativeScrollView offering ads data to get custom views.
 */

@protocol MVNativeScrollViewDelegate <NSObject>

/*!
 @method
 
 @abstract When the MVNativeScrollView need load the custom frame view this message will be sent. Every view you created need to be added on the superview.
 @param superView Every view you created need to be added on the superview.Or they will not be displayed.
 @param nativeFrame You arrange your custom views by reading the ads in the MVFrame object.
 @param index It indicate the index of the superview in the MVNativeScrollView.

 */
- (void)customFrameViewWithSuperView:(nonnull UIView *)superView nativeFrame:(nonnull MVFrame *)nativeFrame atIndex:(NSUInteger)index;

@end

__deprecated_msg("Class is deprecated.")


@interface MVNativeScrollView : UIView

/*!
 @property
 
 @abstract The delegate
 
 @discussion All delegate method will be called in main thread.
 */
@property (nonatomic, weak, nullable) id <MVNativeScrollViewDelegate> delegate;

/*!
 @method
 
 @abstract Returns an initialized MVNativeScrollView.
 @param frame Frame of the MVNativeScrollView.
 @param unitId The unitId you use to get the frames.
 
 */
- (nonnull MVNativeScrollView *)initWithFrame:(CGRect)frame unitId:(nonnull NSString *)unitId;

/*!
 @method
 
 @abstract Use this method to pass the frames data to your MVNativeScrollView. If you don't pass any data, the scrollview will display nothing.
 @param nativeFrames A array contains native frames (MVFrame).
 
 */
- (void)setDataList:(nonnull NSArray *)nativeFrames;


@end
