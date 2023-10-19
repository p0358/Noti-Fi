#import <UIKit/UIKit.h>

@interface NFWindow : UIWindow
+ (instancetype)sharedInstance;
- (id)init;
-(void)showToast:(NSAttributedString *)text;
@end
