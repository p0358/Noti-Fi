#import <UIKit/UIKit.h>

@interface NFWindow : UIWindow
+ (instancetype)sharedInstance;
- (id)init;
-(void)showToast:(NSString *)text;
@end
