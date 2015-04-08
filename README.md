# openfl-unityads
UnityAds implementation for OpenFL/Haxe

### With love from:

**[Ipsilon Developments Inc.](http://www.ipsilondev.com)** released under **MIT license**

Like our **[Facebook](http://www.facebook.com/ipsilondev)** page to get news about our releases

Or Follow us on **[Twitter](https://twitter.com/ipsilondev)**

You can also contact us at **info [AT] ipsilondev.com**

How to use
==========

First of all, install the lib:

```bash
haxelib install openfl-unityads
```

Once this is done, you just need to add this to your project.xml
```xml
<haxelib name="openfl-unityads" />
```
Then, you must set up the event listeners, and then initialize. 

```haxe    
    import extension.unityads.UnityAds;

		UnityAds.onVideoStarted = function():Void {
			Lib.trace("onVideoStarted");
		};
		UnityAds.onVideoCompleted = function(key:String,reward:Bool):Void {
			Lib.trace("onVideoCompleted = "+key+" = "+reward);
		};
		UnityAds.onShow = function() {
		Lib.trace("onShow");
		};
		UnityAds.onHide = function() {
			Lib.trace("onHide");
		};
		UnityAds.onFetch = function(res:Bool):Void {
			Lib.trace("fetchResult = " + res);
			if (res) {
			var resShowAd:Bool = UnityAds.showAd("rewardedVideoZone");
			if (resShowAd) {
			Lib.trace("showing ad OK");
			}else {
			Lib.trace("notshowing ad");
			}
			}
		};
		UnityAds.init("YOUR_GAME_ID", true,true);
```

Important Notes
==========

![](https://github.com/ipsilondev/openfl-unityads/blob/master/xcode-example.jpg?raw=true)
1) **Drag and Drop the UnityAds.bundle file inside the Resources folder in xCode !!! If you don't do this, your app will crash at showing the ad !**

2) This are all the available events that you can listen to. Is optional if you want to support all, or just a few. But be sure to catch up **onFetch event**, that say if the connection to UnityAds servers was successful and if is ready to show ads.

3) init() function, need GAMEID as mandatory parameter, and the other 2, are to enable test mode and debug mode. **be sure to disable both when you package your game !**

4) showAd() function requires of a zoneID to be passed, and optional, a rewardKey. you can get both from the UnityAds admin panel. i know that the documentation say's that zoneID is optional, but i discovered that at least in android, if you don't pass it, it never show an ad. 
