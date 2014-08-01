
waxClass{"TTableViewHeader", UIView}

function initWithFrame(self,frame)
    self.super : initWithFrame(style, frame)
    self.label = UILabel:initWithFrame(CGRect(0,0,200,20))
    self.label:setBackgroundColor(UIColor:whiteColor())
    self.label:setTextColor(UIColor:blackColor())
    self.label():setText("这是远程下载的")
    self:addSubview(self.label)
    return self
end