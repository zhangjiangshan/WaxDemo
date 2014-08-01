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

//        NSString * url = @"http://api.mobile.meituan.com/group/v1/poi/select/cate/-1?client=iphone&areaId=1471&ci=1&cityId=1&coupon=all&limit=20&mypos=40.007226%2C116.487860&offset=0&sort=distance&userid=60862012&utm_campaign=AgroupBgroupD100&utm_content=4F03EA0D5A951EBDEC573C01ACBD62B60328221889976AA20A46E30FED5EC1AE&utm_medium=iphone&utm_source=AppStore&utm_term=4.6.1&uuid=4F03EA0D5A951EBDEC573C01ACBD62B60328221889976AA20A46E30FED5EC1AE&movieBundleVersion=80";

        Class clazz = NSClassFromString(@"ModelCenter");
        id modelCenter = [[clazz alloc] init];

        NSBlockInvocation *block = [NSBlockInvocation invocationWithBlock:^(id object) {
            _model = object;
            [self.tableView reloadData];
        }];

        [modelCenter performSelector:@selector(getModelWithCalback:) withObject:block];
    }
    return self;
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

    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES)[0];
    NSString *path = [docPath stringByAppendingPathComponent:@"TTableViewCell.lua"];
    [LuaHelper runLua:path];
    
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
