
waxClass{"TTableViewCell", UITableViewCell}

function initWithStyle_reuseIdentifier(self,style,reuseIdentifier)
    self.super : initWithStyle_reuseIdentifier(style, reuseIdentifier)
    self:textLabel():setText("abc")
    return self
end

function setString(self,text)
    self:textLabel():setText(text)
end