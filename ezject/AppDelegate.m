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

    NSTask *task  = [[NSTask alloc] init];
    NSPipe *pipe  = [[NSPipe alloc] init];
    [task setLaunchPath: @"/usr/sbin/diskutil"];
    [task setArguments: [NSArray arrayWithObjects: @"unmountDisk", @"disk1", nil]];
    [task setStandardOutput: pipe];
    [task launch];
    
    NSData* data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSLog(@"%@", result);

}

- (void) receiveWakeNote: (NSNotification*) note
{

    NSTask *task  = [[NSTask alloc] init];
    NSPipe *pipe  = [[NSPipe alloc] init];
    [task setLaunchPath: @"/usr/sbin/diskutil"];
    [task setArguments: [NSArray arrayWithObjects: @"mountDisk", @"disk1", nil]];
    [task setStandardOutput: pipe];
    [task launch];
    [task waitUntilExit];
    
    NSData* data = [[[task standardOutput] fileHandleForReading] readDataToEndOfFile];
    NSString *result = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSLog(@"%@", result);

    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.title = @"Awake!";
    notification.informativeText = result;
    [notification setDeliveryDate:[NSDate dateWithTimeInterval:5 sinceDate:[NSDate date]]];
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:notification];

}
@end


