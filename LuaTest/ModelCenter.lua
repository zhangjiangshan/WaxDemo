
waxClass{"ModelCenter", NSObject}

function init(self)
    self.super:init(self)
    return self
end



function getModelWithCalback(self,block)
    wax.http.request{"http://api.mobile.meituan.com/group/v1/poi/select/cate/-1?client=iphone&areaId=1471&ci=1&cityId=1&coupon=all&limit=20&mypos=40.007226%2C116.487860&offset=0&sort=distance&userid=60862012&utm_campaign=AgroupBgroupD100&utm_content=4F03EA0D5A951EBDEC573C01ACBD62B60328221889976AA20A46E30FED5EC1AE&utm_medium=iphone&utm_source=AppStore&utm_term=4.6.1&uuid=4F03EA0D5A951EBDEC573C01ACBD62B60328221889976AA20A46E30FED5EC1AE&movieBundleVersion=80",format = "json",callback = function(json, response)
    print("finished:%d",block)
    if response:statusCode() == 200 then
      local trends = json["data"]
      block:invoke(trends)
    end
    end}

end