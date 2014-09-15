
waxClass{"TTableViewHeader", UILabel}

function initWithFrame(self,frame)
    self.super:initWithFrame(frame)
    self:setBackgroundColor(UIColor:blueColor())
    self:setTextColor(UIColor:blackColor())
    self:setText("这是远程下载的")
    return self
end