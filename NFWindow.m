#import "NFWindow.h"
#import "UIView+Toast.h"

@implementation NFWindow

- (instancetype)init {
  self = [super initWithFrame:[[UIScreen mainScreen] bounds]];
  if (self != nil){
  	[self setHidden:NO];
    [self setWindowLevel:UIWindowLevelAlert];
  	[self setBackgroundColor:[UIColor clearColor]];
  	[self setUserInteractionEnabled:NO];
  	[CSToastManager setQueueEnabled:YES];
  }
  return self;
}

-(void)makeKeyAndVisible {
    [super makeKeyAndVisible];
    return;
}

-(void)showToast:(NSAttributedString *)text {
  [self makeToast:text];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  return nil;
}

+ (instancetype)sharedInstance {
  static dispatch_once_t p = 0;
  __strong static id _sharedSelf = nil;
  dispatch_once(&p, ^{
    _sharedSelf = [[self alloc] init];
  });
  return _sharedSelf;
}

@end
