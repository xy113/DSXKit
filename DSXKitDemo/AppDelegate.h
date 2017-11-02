//
//  AppDelegate.h
//  DSXKitDemo
//
//  Created by songdewei on 2017/11/1.
//  Copyright © 2017年 liaidi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "DSXKit.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

