//
//  EzjectAppContlorer.m
//  ezject
//
//  Created by tfunato on 2014/04/23.
//  Copyright (c) 2014年 tfunato. All rights reserved.
//

#import "EzjectAppContlorer.h"

@implementation EzjectAppContlorer

- (void)awakeFromNib
{
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    
    [self.statusItem setImage:[NSImage imageNamed:@"menu_icon"]];
    [self.statusItem setMenu:self.statusMenu];
}
@end
