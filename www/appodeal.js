
	var Appodeal = exports;

	var exec = require('cordova/exec');
	var cordova = require('cordova');

	Appodeal.INTERSTITIAL = 1;
	Appodeal.VIDEO = 2;
	Appodeal.BANNER = 4;
	Appodeal.BANNER_BOTTOM = 8;
	Appodeal.BANNER_TOP    = 16;
	Appodeal.BANNER_CENTER = 32;
	Appodeal.BANNER_VIEW   = 64;
	Appodeal.ANY = 255;
	Appodeal.ALL = 255;
	Appodeal.REWARDED_VIDEO = 128;

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

	Appodeal.isAutocacheEnabled = function(adType) {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isAutocacheEnabled", [adType]);
	}

	Appodeal.deinitialize = function() {
		exec(null, null, "AppodealPlugin", "deinitialize", []);
	}

	Appodeal.isInitalized = function() {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isInitalized", []);
	}

	Appodeal.initialize = function(appKey) {
		exec(null, null, "AppodealPlugin", "initialize", [appKey]);
	}

	Appodeal.initializeAdType = function(appKey, adType) {
		exec(null, null, "AppodealPlugin", "initializeAdType", [appKey, adType]);
	}

	Appodeal.testingEnabled = function(enabled) {
		exec(null, null, "AppodealPlugin", "testingEnabled", [enabled]);
	}

	Appodeal.enableInterstitialCallbacks = function(listener) {
		exec(null, null, "AppodealPlugin", "enableIntertitialCallbacks", [listener]);
	}

	Appodeal.enableVideoCallbacks = function(listener) {
		exec(null, null, "AppodealPlugin", "enableVideoCallbacks", [listener]);
	}

	Appodeal.enableBannerCallbacks = function(listener) {
		exec(null, null, "AppodealPlugin", "enableBannerCallbacks", [listener]);
	}

	Appodeal.enableRewardedVideoCallbacks = function(listener) {
		exec(null, null, "AppodealPlugin", "enableRewardedVideoCallbacks", [listener]);
	}

	Appodeal.isReadyForShowWithStyle = function(adType) {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isReadyForShowWithStyle", [adType]);
	}

	Appodeal.isReadyWithPriceFloorForShowWithStyle = function(adType) {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "isReadyWithPriceFloorForShowWithStyle", [adType]);
	}

	Appodeal.confirmUsage = function(adType) {
		exec(null, null, "AppodealPlugin", "confirmUsage", [adType]);
	}

	Appodeal.show = function(adType) {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "show", [adType]);
	}

	Appodeal.showAdWithPriceFloor = function(adType) {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "showAdWithPriceFloor", [adType]);
	}

	Appodeal.hide = function() {
		exec(null, null, "AppodealPlugin", "hide", []);
	}

	Appodeal.cacheAd = function(adType) {
		exec(null, null, "AppodealPlugin", "cacheAd", [adType]);
	}

	Appodeal.getVersion = function() {
		exec(function(result){
			  appendStatus(result);
			}, null, "AppodealPlugin", "getVersion", []);
	}

	Appodeal.setAutoCache = function(adType, autoCache) {
		exec(null, null, "AppodealPlugin", "setAutoCache", [adType, autoCache]);
	}

	Appodeal.disableNetwork = function(network) {
		exec(null, null, "AppodealPlugin", "disableNetwork", [network]);
	}

	Appodeal.disableLocationPermissionCheck = function() {
		exec(null, null, "AppodealPlugin", "disableLocationCheck", []);
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

