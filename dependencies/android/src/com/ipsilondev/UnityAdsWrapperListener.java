package com.ipsilondev;


import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;
import com.unity3d.ads.android.UnityAds;
import com.unity3d.ads.android.IUnityAdsListener;
import com.ipsilondev.UnityAdsWrapper;
public class UnityAdsWrapperListener implements IUnityAdsListener{
	public void main(String[] args) {
		// TODO Auto-generated method stub
	}
	
	//after initied, this method is called if campaigns could be fetched
	public void onFetchCompleted(){
		UnityAdsWrapper.cb.call1("unityAdsOnFetch",true);
	}
	//after initied, this method is called if no campaigns could be fetched	
	public void onFetchFailed(){
		UnityAdsWrapper.cb.call1("unityAdsOnFetch",false);		
	} 

	public void onVideoCompleted(String keyId,boolean rewarded){
		UnityAdsWrapper.cb.call2("unityAdsOnVideoCompleted",keyId,rewarded);
	}
	
	public void onVideoStarted(){
		UnityAdsWrapper.cb.call0("unityAdsOnVideoStarted");
	}
	
	public void onHide() {
		UnityAdsWrapper.cb.call0("unityAdsOnHide");		
	}
	
	public void onShow() {
		UnityAdsWrapper.cb.call0("unityAdsOnShow");				
	}
	
}
