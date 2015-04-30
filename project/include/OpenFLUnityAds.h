#ifndef OPENFLUNITYADS_H
#define OPENFLUNITYADS_H


namespace openflunityads {
	
	
	void InitUnityAds(value cb, const char *gameId, bool testmode, bool debugmode);
	bool show (const char * rawZoneId, const char * rawRewardItemKey);
	void onFetch(bool result);
	void onVideoCompleted(const char * keyId, bool rewarded);
	void onVideoStarted();
	void onVideoHide();
	void onVideoShow();
	void setOnFetchCB(value f);
	void setOnVideoCompletedCB(value f);
	void setOnVideoStartedCB(value f);
	void setOnVideoHideCB(value f);
	void setOnVideoShowCB(value f);
	bool canShowAds();
	
}


#endif
