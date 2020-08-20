require "import"
import "glob"

name=...
packinfo = pm.getPackageInfo(name, 64)

isFreezed=false
visible=0
isAndroidSystem=false

function onResume()
if pcall(function ()
pack = pm.getApplicationInfo(name, PackageManager.GET_META_DATA)
--路径与名称
app_pt=pm.getApplicationInfo(name, 64).sourceDir
app_nm=pm.getApplicationLabel(pack)
nm.text=app_nm
--应用图标
appicon=pack.loadIcon(pm).getBitmap()
ic.setImageBitmap(appicon)
--应用包名
app_pn=pack.packageName
app_inf=pack.flags
--[[if tonumber(pm.getApplicationEnabledSetting(app_pn))==0 then
freeze_app.setVisibility(0)
unfreeze_app.setVisibility(8)
else
freeze_app.setVisibility(8)
unfreeze_app.setVisibility(0)
end]]
if tostring (app_pn):find"com.android" or tostring (app_pn)=="android" then
visible=8
isAndroidSystem=true
unis.setVisibility(visible)
reins.setVisibility(visible)
--freeze_app.setVisibility(visible)
view_store.setVisibility(visible)
--unfreeze_app.setVisibility(visible)
end
--[[if tonumber(pm.getApplicationEnabledSetting(app_pn))~=0 then
unfreeze_app.setVisibility(0)
end]]
end) then else
print ("应用信息加载失败，该应用可能已被卸载。")
this.finish()
end
end

this.setContentView(loadlayout ({
LinearLayout,
orientation="vertical",
{
    RelativeLayout,
    layout_height="21.75%w",
    layout_width="fill",
    id="topBar",
    elevation="1%w",
    paddingTop=状态栏高度,
    backgroundColor=0xfffafafa,
    {
      ImageView,
      src="back.png",
      layout_alignParentLeft=true;
      layout_height="fill",
      layout_width="13%w",
      onClick=function ()
       this.finish()
      end,
      foreground=波纹(0xcb5B5B5B),
      padding="3.5%w",
      id="back",
    },
    {
      TextView,
      id="title",
      text="管理应用",
      paddingRight="13%w",
      paddingLeft="3%w",
      layout_toRightOf="back",
      gravity="left|center",
      singleLine=true,
      ellipsize="end",
      textSize="18sp",
      layout_height="fill",
      layout_width="fill",
      textColor=0xff444444,
    },
{
LinearLayout,
layout_alignParentRight=true;
orientation="horizontal",
    {
      ImageView,
      src="info.png",
      onClick=function ()
        
     end,
      foreground=波纹(0xcb5B5B5B),
      layout_height="fill",
      layout_width="13%w",
      visibility=8,
      padding="3.5%w",
    },
  },
 },
 {
 ScrollView,
{
LinearLayout,
orientation="vertical",
paddingBottom="3.5%w",
{
RelativeLayout,
layout_height="wrap",
gravity="center",
layout_width="fill",
{
LinearLayout,
orientation="horizontal",
layout_width="fill",
layout_height="20%w",
{
ImageView,
layout_height="fill",
id="ic",
layout_width="20%w",
adjustViewBounds=true,
padding="3.5%w",
},
{
TextView,
textSize="16sp",
textColor=0xff444444,
layout_height="fill",
gravity="center|left",
id="nm",
padding="3.5%w",
textIsSelectable=true,
},
},
},
{
LinearLayout,
id="item_area",
orientation="vertical",
{
RelativeLayout,
layout_height="13%w",
onClick=function()
openApp(app_pn)
end,
visibility=visible,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="打开应用",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
onClick=function()
killApp(app_pn)
end,
visibility=8,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="结束应用",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
id="unis",
onClick=function()
uninstallApp(app_pn)
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="卸载应用",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
id="reins",
onClick=function()
installApp(app_pt)
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="重新安装",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
--[[没有权限
{
RelativeLayout,
layout_height="13%w",
visibility=visible,
id="freeze_app",
onClick=function()
pm.setApplicationEnabledSetting(app_pn, PackageManager.COMPONENT_ENABLED_STATE_DISABLED,PackageManager.DONT_KILL_APP)
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="冻结应用",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
visibility=visible,
onClick=function()
pm.setApplicationEnabledSetting(app_pn, PackageManager.COMPONENT_ENABLED_STATE_ENABLED,PackageManager.DONT_KILL_APP)
end,
id="unfreeze_app",
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="解冻应用",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},]]
{
RelativeLayout,
layout_height="13%w",
onClick=function()
shareApk(app_pt)
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="分享安装包",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
onClick=function()
viewAppInSettings(app_pn)
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="应用详情",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
onClick=function()
if pcall(function ()
os.execute("cp -r "..app_pt.." "..pickup_apkfile)
os.rename (pickup_apkfile.."base.apk",pickup_apkfile..app_nm..".apk")
end) then
print ("安装包已保存在 "..pickup_apkfile)
else
print ("提取失败")
end
--LuaUtil.copyDir(app_pt,"/sdcard/download/")
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="提取安装包",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
onClick=function()
local ic_pic=savePicture(pickup_icon..app_pn..".png",appicon)
if ic_pic then
print ("图标已保存到 "..pickup_icon)
else
print ("提取失败")
end
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="提取图标",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
{
RelativeLayout,
layout_height="13%w",
id="view_store",
onClick=function()
openAppStore(app_pn)
end,
paddingLeft="3.5%w",
foreground=波纹(0xcb5B5B5B),
    {
      TextView,
      text="在应用商店查看",
      gravity="left|center",
      textSize="16sp",
      layout_height="fill",
      textColor=0xff444444,
    },
{
ImageView,
src="arrow.png",
layout_height="fill",
layout_width="13%w",
padding="3.5%w",
layout_alignParentRight=true,
rotation=-90,
},
},
},
},
},
}))
