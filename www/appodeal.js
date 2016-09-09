
	var Appodeal = exports;

	var exec = require('cordova/exec');
	var cordova = require('cordova');

	Appodeal.INTERSTITIAL = 1;
	Appodeal.VIDEO = 2;
	Appodeal.BANNER = 4;
	Appodeal.BANNER_BOTTOM = 8;
	Appodeal.BANNER_TOP    = 16;
	Appodeal.BANNER_CENTER = 32;
	Appodeal.NATIVE   = 64;
	Appodeal.REWARDED_VIDEO = 128;
	Appodeal.MREC = 256;
	Appodeal.NON_SKIPPABLE_VIDEO = 512;


Appodeal.setLogging = function(logging) {
	exec(null, null, "AppodealPlugin", "setLogging", [logging]);
}

Appodeal.isLoaded = function(adType, callback) {
	exec(function(e) {
		if(typeof callback=='function') {
			if(e==1){
				callback(true);
			} else {
				callback(false);
			}
		}
	}, null, "AppodealPlugin", "isLoaded", [adType]);
}

Appodeal.setOnLoadedTriggerBoth = function(adType, setTrigger) {
	exec(null, null, "AppodealPlugin", "setOnLoadedTriggerBoth", [adType, setTrigger]);
}

Appodeal.disableNetworkType = function(network, adType) {
	exec(null, null, "AppodealPlugin", "disableNetworkType", [network, adType]);
}

Appodeal.disableLocationPermissionCheck = function() {
	exec(null, null, "AppodealPlugin", "disableLocationCheck", []);
}

Appodeal.isAutocacheEnabled = function(adType) {
	exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isAutocacheEnabled", [adType]);
}

Appodeal.setAutoCache = function(adType, autoCache) {
	exec(null, null, "AppodealPlugin", "setAutoCache", [adType, autoCache]);
}

Appodeal.initialize = function(appKey, adType) {
	exec(null, null, "AppodealPlugin", "initialize", [appKey, adType]);
}

Appodeal.isInitalized = function() {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isInitalized", []);
}

Appodeal.show = function(adType, callback) {
	exec(function(e) {
		if(typeof callback=='function') {
			if(e==1) {
				callback(true);
			} else {
				callback(false);
			}
		}
	}, null, "AppodealPlugin", "show", [adType]);
}

Appodeal.showWithPlacement = function(adType, callback) {
	exec(function(e) {
		if(typeof callback=='function') {
			if(e==1) {
				callback(true);
			} else {
				callback(false);
			}
		}
	}, null, "AppodealPlugin", "show", [adType]);
}

Appodeal.cache = function(adType) {
	exec(null, null, "AppodealPlugin", "cacheBanner", [adType]);
}

Appodeal.hide = function(adType) {
	exec(null, null, "AppodealPlugin", "hide", [adType]);
}

Appodeal.setDebugEnabled = function(testing) {
	exec(null, null, "AppodealPlugin", "setDebugEnabled", [debugging]);
}

Appodeal.setTesting = function(testing) {
	exec(null, null, "AppodealPlugin", "setTesting", [testing]);
}

Appodeal.resetUUID = function() {
	exec(null, null, "AppodealPlugin", "resetUUID", []);
}

Appodeal.getVersion = function() {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "getVersion", []);
	}

Appodeal.isReadyForShowWithStyle = function(adType) {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isReadyForShowWithStyle", [adType]);
	}

Appodeal.setCustomRule = function(rule) {
	exec(null, null, "AppodealPlugin", "setCustomRule", [rule]);
}

Appodeal.confirm = function(adType) {
	exec(null, null, "AppodealPlugin", "confirm", [adType]);
}

Appodeal.setSmartBanners = function(value) {
	exec(null, null, "AppodealPlugin", "setSmartBanners", [value]);
}

Appodeal.setBannerBackgroundVisible = function(value) {
	exec(null, null, "AppodealPlugin", "setBannerBackgroundVisible", [value]);
}

Appodeal.setBannerAnimationEnabled = function(value) {
	exec(null, null, "AppodealPlugin", "setBannerAnimationEnabled", [value]);
}


Appodeal.enableInterstitialCallbacks = function(listener) {
	exec(null, null, "AppodealPlugin", "enableInterstitialCallbacks", [listener]);
}

Appodeal.enableSkippableVideoCallbacks = function(listener) {
	exec(null, null, "AppodealPlugin", "enableSkippableVideoCallbacks", [listener]);
}

Appodeal.enableNonSkippableVideoCallbacks = function(listener) {
	exec(null, null, "AppodealPlugin", "enableNonSkippableVideoCallbacks", [listener]);
}

Appodeal.enableBannerCallbacks = function(listener) {
	exec(null, null, "AppodealPlugin", "enableBannerCallbacks", [listener]);
}

Appodeal.enableRewardedVideoCallbacks = function(listener) {
	exec(null, null, "AppodealPlugin", "enableRewardedVideoCallbacks", [listener]);
}

	Appodeal.setUserEmail = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserEmail", [Type]);
	}

	Appodeal.setUserAge = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserAge", [Type]);
	}

	Appodeal.setUserGender = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserGender", [Type]);
	}

	Appodeal.setUserOccupation = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserOccupation", [Type]);
	}

	Appodeal.setUserRelationship = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserRelationship", [Type]);
	}

	Appodeal.setUserSmokingAttitude = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserSmokingAttitude", [Type]);
	}

	Appodeal.setUserAlcoholAttitude = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserAlcoholAttitude", [Type]);
	}

	Appodeal.setUserInterests = function(Type) {
		exec(null, null, "AppodealPlugin", "setUserInterests", [Type]);
	}



    Appodeal.attachToView = function() {
        exec(null, null, "AppodealPlugin","attachToView", []);
    }
    Appodeal.detachFromView = function(x,y,AppodealNativeAdType) {
        exec(null, null, "AppodealPlugin","detachFromView", []);
    }
    Appodeal.setNativeAdAttributes_width_height = function(width,height) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_width_height", [width,height]);
    }
    Appodeal.setNativeAdAttributes_roundedIcon = function(bool_) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_roundedIcon", [bool_]);
    }
    Appodeal.setNativeAdAttributes_sponsored = function(bool_) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_sponsored", [bool_]);
    }
    Appodeal.setNativeAdAttributes_titleFont = function(name,size) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_titleFont", [name,size]);
    }
    Appodeal.setNativeAdAttributes_descriptionFont = function(name,size) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_descriptionFont", [name,size]);
    }
    Appodeal.setNativeAdAttributes_subtitleFont = function(name,size) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_subtitleFont", [name,size]);
    }
    Appodeal.setNativeAdAttributes_buttonTitleFont = function(name,size) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_buttonTitleFont", [name,size]);
    }
    Appodeal.setNativeAdAttributes_titleFontColor = function(red,green,blue,alpha) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_titleFontColor", [red,green,blue,alpha]);
    }
    Appodeal.setNativeAdAttributes_descriptionFontColor = function(red,green,blue,alpha) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_descriptionFontColor", [red,green,blue,alpha]);
    }
    Appodeal.setNativeAdAttributes_subtitleColor = function(red,green,blue,alpha) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_subtitleColor", [red,green,blue,alpha]);
    }
    Appodeal.setNativeAdAttributes_buttonColor = function(red,green,blue,alpha) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_buttonColor", [red,green,blue,alpha]);
    }
    Appodeal.setNativeAdAttributes_starRatingColor = function(red,green,blue,alpha) {
        exec(null, null, "AppodealPlugin","setNativeAdAttributes_starRatingColor", [red,green,blue,alpha]);
    }
    Appodeal.loadNativeAd = function(x,y,AppodealNativeAdType) {
	exec(null, null, "AppodealPlugin","loadNativeAd", [x,y,AppodealNativeAdType]);
    }



