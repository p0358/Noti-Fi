#import "NFWindow.h"

%hook SpringBoard
- (void)applicationDidFinishLaunching:(id)application {
	%orig;
	NFWindow *window = [NFWindow sharedInstance];
	[window makeKeyAndVisible];

	[[%c(NSDistributedNotificationCenter) defaultCenter] addObserverForName:@"net.p0358.noti-fi" object:nil queue:nil usingBlock:^(NSNotification *notification) {
		NSMutableAttributedString *msg;

		if ([notification.userInfo[@"connected"] boolValue]) {
			msg = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"Connected to Wi-Fi network %@", notification.userInfo[@"networkName"]]];
			[msg addAttribute:NSForegroundColorAttributeName value:[UIColor cyanColor] range:NSMakeRange(strlen("Connected to Wi-Fi network "), ((NSString *)notification.userInfo[@"networkName"]).length)]; 
		} else
			msg = [[NSMutableAttributedString alloc] initWithString:@"Disconnected from Wi-Fi network"];

		[window showToast:msg];
	}];
}
%end

@interface SBWiFiManager
-(id)currentNetworkName;
@end

%hook SBWiFiManager
-(void)_primaryInterfaceChanged:(BOOL)arg1 {
	%orig;

	NSDictionary *userInfo;
	if (arg1) {
		userInfo = @{
			@"connected": @YES,
			@"networkName": [self currentNetworkName],
		};
	} else {
		userInfo = @{
			@"connected": @NO,
		};
	}

	[[%c(NSDistributedNotificationCenter) defaultCenter] postNotificationName:@"net.p0358.noti-fi" object:nil userInfo:userInfo];
}
%end
