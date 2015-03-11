package extension.unityads;


#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end

class UnityAds {
	///callbacks haxe
	public static var onFetch:Bool->Void = null;
	public static var onVideoCompleted:String->Bool->Void = null;
	public static var onVideoStarted:Void->Void = null;
	public static var onHide:Void->Void = null;
	public static var onShow:Void->Void = null;
	
	public static var instance:UnityAds = null;
	public static function init(gameId:String, test:Bool=false, debug:Bool=false):Void {
		libInit(getInstance(), gameId, test, debug);
	}
	public static function showAd(zone:String, rewardItemKey:String = ""):Bool {
		return libShowAd(zone, rewardItemKey);
	}
	public static function getInstance():UnityAds {
		if (instance == null) { instance = new UnityAds(); }
		return instance;
	}
	
	////java binings
	private static var libInit:UnityAds->String->Bool->Bool->Void =
	#if android
	JNI.createStaticMethod("com.ipsilondev.UnityAdsWrapper","init","(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;ZZ)V");
	#elseif ios
	function(o:UnityAds, s:String, b1:Bool, b2:Bool):Void {
		onFetchiOSCallBack(getInstance().unityAdsOnFetch);
		onVideoCompletediOSCallBack(getInstance().unityAdsOnVideoCompleted);
		onVideoStartediOSCallBack(getInstance().unityAdsOnVideoStarted);
		onVideoHideiOSCallBack(getInstance().unityAdsOnHide);
		onVideoShowiOSCallBack(getInstance().unityAdsOnShow);
		iosInit(o,s,b1,b2);
		
	};
	#else
	function(o:UnityAds, s:String, b1:Bool, b2:Bool):Void {
	
	};
	#end
	
	private static var libShowAd:String->String->Bool =
	#if android
	JNI.createStaticMethod("com.ipsilondev.UnityAdsWrapper","showAd","(Ljava/lang/String;Ljava/lang/String;)Z");
	#elseif ios
	Lib.load("openflunityads","openflunityads_showAd",2);
	#else
	function(s:String="", s2:String=""):Bool {
		return true;
	};
	#end
	
	#if ios
	//init function only for ios
	private static var iosInit = Lib.load("openflunityads","openflunityads_init",4);
	#end
		
	//register event handlers for ios
	#if ios
	private static var onFetchiOSCallBack = Lib.load("openflunityads","openflunityads_setOnFetchCB",1);
	private static var onVideoCompletediOSCallBack = Lib.load("openflunityads","openflunityads_setOnVideoCompletedCB",1);
	private static var onVideoStartediOSCallBack = Lib.load("openflunityads","openflunityads_setOnVideoStartedCB",1);
	private static var onVideoHideiOSCallBack = Lib.load("openflunityads","openflunityads_setOnVideoHideCB",1);
	private static var onVideoShowiOSCallBack = Lib.load("openflunityads","openflunityads_setOnVideoShowCB",1);
	#end
	
	//event handlers
	public function new() {
		
	}
	
	public function unityAdsOnFetch(result:Bool):Void {
		if (onFetch != null) {
			onFetch(result);
		}
	}
	
	public function unityAdsOnVideoCompleted(keyId:String, rewarded:Bool):Void {
		if (onVideoCompleted != null) {
			onVideoCompleted(keyId, rewarded);
		}
		
	}
	
	public function unityAdsOnVideoStarted():Void {
		if (onVideoStarted != null) {
			onVideoStarted();
		}		
	}
	public function unityAdsOnHide():Void {
		if (onHide != null) {
			onHide();
		}
	}
	
	public function unityAdsOnShow():Void {
		if (onShow != null) {
			onShow();
		}
	}
	
	
	
}
