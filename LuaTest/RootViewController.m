//
//  RootViewController.m
//  LuaTest
//
//  Created by zjs on 14-7-4.
//  Copyright (c) 2014年 zjs. All rights reserved.
//

#import "RootViewController.h"
#import "LuaHelper.h"

#import "SubViewController.h"
#import "NSBlockInvocation.h"
@interface RootViewController ()

@end

@implementation RootViewController
{
    NSArray *_model;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self loadLib];

        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(reloadLua)];
        [self.navigationItem setLeftBarButtonItem:item];

        Class clazz = NSClassFromString(@"ModelCenter");
        id modelCenter = [[clazz alloc] init];

        NSBlockInvocation *block = [NSBlockInvocation invocationWithBlock:^(id object) {
            _model = object;
            [self.tableView reloadData];
        }];
        [modelCenter performSelector:@selector(getModelWithCalback:) withObject:block];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://github.com/zhangjiangshan/WaxDemo/raw/master/LuaTest/TTableViewHeader.lua"]];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
            NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString * name = @"TTableViewHeader.lua";
            BOOL flag = [data writeToFile:[self getDocPath:name] atomically:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self refreshHeader];
            });
        });
        
    }
    return self;
}

- (void)refreshHeader
{
    NSString *path = [self getDocPath:@"TTableViewHeader.lua"];
    [LuaHelper runLua:path];
    
    Class clazz = NSClassFromString(@"TTableViewHeader");
    id header = [[clazz alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    self.tableView.tableHeaderView = header;
}

- (NSString *)getDocPath:(NSString *)name
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return [doc stringByAppendingPathComponent:name];
}

- (void)reloadLua
{
    [self loadLib];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    Class clazz = NSClassFromString(@"TTableViewCell");
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[clazz alloc] initWithStyle:UITableViewCellStyleDefault
                            reuseIdentifier:identifier];
    }
    NSDictionary *dict = _model[indexPath.row];
    [cell performSelector:@selector(setString:) withObject:dict[@"name"]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_model count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SubViewController *sub = [[SubViewController alloc] init];
    [self.navigationController pushViewController:sub animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)loadLib
{
    [LuaHelper runLua:@"ModelCenter.lua"];
    [LuaHelper runLua:@"TTableViewCell.lua"];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
