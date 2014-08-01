//
//  RootViewController.h
//  LuaTest
//
//  Created by zjs on 14-7-4.
//  Copyright (c) 2014年 zjs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end
