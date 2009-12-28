//
//  AppController.m
//  Nio - notify.io client
//
//  Created by Abimanyu on 11/24/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "AppController.h"
#import "Client.h"
#import "Growl-WithInstaller/GrowlApplicationBridge.h"

@implementation AppController

- (void) awakeFromNib{
	statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
	
	NSBundle *bundle = [NSBundle mainBundle];
	
	statusImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"grin" ofType:@"png"]];
	statusHighlightImage = [[NSImage alloc] initWithContentsOfFile:[bundle pathForResource:@"grin" ofType:@"png"]];
	
	[statusItem setImage:statusImage];
	[statusItem setAlternateImage:statusHighlightImage];
	
	[statusItem setMenu:statusMenu];
	
	[statusItem setToolTip:@"notify.io"];
	
	[statusItem setHighlightMode:YES];
	
	NSBundle *myBundle = [NSBundle bundleForClass:[AppController class]];
	NSString *growlPath = [[myBundle privateFrameworksPath] stringByAppendingPathComponent:@"Growl-WithInstaller.framework"];
	NSBundle *growlBundle = [NSBundle bundleWithPath:growlPath];
	
	Client *client = [Client alloc];
	
	if (growlBundle && [growlBundle load]) {
		NSLog(@"This might work");
		[GrowlApplicationBridge setGrowlDelegate:self]; 
		[GrowlApplicationBridge	notifyWithTitle:@"Nio started"
									description:@"Receiving notifications from notify.io"
									notificationName:@"Nio"
									   iconData:nil
									   priority:1
									   isSticky:NO
								   clickContext:nil];
		[GrowlApplicationBridge setGrowlDelegate:client]; 
	}
	else{
		NSLog(@"Could not load Growl.framework");
	}
	
	
	[client initRemoteHost];
}

- (void) dealloc{
	[statusImage release];
	[statusHighlightImage release];
	[super dealloc];
}

- (IBAction)helloWorld:(id)sender{
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.notify.io/dashboard/history"]];
}

- (IBAction)openHistory:(id)sender{
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.notify.io/dashboard/history"]];
}

- (IBAction)openNotificationSources:(id)sender{
	[[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:@"http://www.notify.io/dashboard/sources"]];
}

@end
