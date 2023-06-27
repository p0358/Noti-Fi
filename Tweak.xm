#import "NFWindow.h"

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
	%orig;
	NFWindow *window = [NFWindow sharedInstance];
	[window makeKeyAndVisible];

	[[%c(NSDistributedNotificationCenter) defaultCenter] addObserverForName:@"com.rpgfarm.notifi" object:nil queue:nil usingBlock:^(NSNotification *notification) {
		[window showToast:notification.userInfo[@"msg"]];
	}];
}
%end

@interface SBWiFiManager
-(id)currentNetworkName;
@end

%hook SBWiFiManager
-(void)_primaryInterfaceChanged:(BOOL)arg1 {
	%orig;
	NSString *msg = @"";

	if(arg1) msg = [NSString stringWithFormat:@"Connected to WiFi Network %@.", [self currentNetworkName]];
	else msg = @"Disconnected from WiFi Network.";

	[[%c(NSDistributedNotificationCenter) defaultCenter] postNotificationName:@"com.rpgfarm.notifi" object:nil userInfo:@{
		@"msg": msg
	}];
}
%end
