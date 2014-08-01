
require "TTableViewController"

print("aaa")
local window = UIApplication:sharedApplication():keyWindow()
local navigation = window:rootViewController()
print("navigation")
tableviewController = TTableViewController:init()
navigation:pushViewController_animated(tableviewController,true)