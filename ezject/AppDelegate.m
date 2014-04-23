//
//  AppDelegate.m
//  ezject
//

#import "AppDelegate.h"

@interface AppDelegate ()
    @property (weak) IBOutlet NSMenu *statusMenu;
@end

@implementation AppDelegate

    NSStatusItem *statusItem;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    [self setupStatusItem];
    
    // Setup system event notifications
    [self fileNotifications];
}

- (void)setupStatusItem
{
    NSStatusBar *systemStatusBar = [NSStatusBar systemStatusBar];
    statusItem = [systemStatusBar statusItemWithLength:NSVariableStatusItemLength];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"menu_icon"]];
    [statusItem setMenu:self.statusMenu];
    
}

- (void) fileNotifications
{
    NSLog(@"\n I like fileNotifications.");
    //These notifications are filed on NSWorkspace's notification center, not the default
    // notification center. You will not receive sleep/wake notifications if you file
    //with the default notification center.
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveSleepNote:)
                                                               name: NSWorkspaceWillSleepNotification object: nil];
    
    [[[NSWorkspace sharedWorkspace] notificationCenter] addObserver: self
                                                           selector: @selector(receiveWakeNote:)
                                                               name: NSWorkspaceDidWakeNotification object: nil];
}
- (void) receiveSleepNote: (NSNotification*) note
{
    NSLog(@"\n I like sleep.");
}

- (void) receiveWakeNote: (NSNotification*) note
{
    NSLog(@"\n I like awake.");
}
@end


