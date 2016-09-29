var Appodeal = exports;

var exec = require('cordova/exec');
var cordova = require('cordova');

Appodeal.INTERSTITIAL = 1;
Appodeal.SKIPPABLE_VIDEO = 2;
Appodeal.BANNER = 4;
Appodeal.BANNER_BOTTOM = 8;
Appodeal.BANNER_TOP = 16;
Appodeal.REWARDED_VIDEO = 128;
Appodeal.NON_SKIPPABLE_VIDEO = 256;

Appodeal.initialize = function(appKey, adType) {
    exec(null, null, "AppodealPlugin", "initialize", [appKey, adType]);
};

Appodeal.isInitialized = function(callback) {
    exec(callback, null, "AppodealPlugin", "isInitalized", []);
};

Appodeal.show = function(adType, callback) {
    exec(callback, null, "AppodealPlugin", "show", [adType]);
};

Appodeal.showWithPlacement = function(adType, placement, callback) {
    exec(callback, null, "AppodealPlugin", "showWithPlacement", [adType, placement]);
};

Appodeal.hide = function(adType) {
    exec(null, null, "AppodealPlugin", "hide", [adType]);
};

Appodeal.confirm = function(adType) {
    exec(null, null, "AppodealPlugin", "confirm", [adType]);
};

Appodeal.isLoaded = function(adType, callback) {
    exec(callback, null, "AppodealPlugin", "isLoaded", [adType]);
};

Appodeal.isPrecache = function(adType, callback) {
    exec(callback, null, "AppodealPlugin", "isPrecache", [adType]);
};

Appodeal.setAutoCache = function(adType, autoCache) {
    exec(null, null, "AppodealPlugin", "setAutoCache", [adType, autoCache]);
};

Appodeal.cache = function(adType) {
    exec(null, null, "AppodealPlugin", "cache", [adType]);
};

Appodeal.setOnLoadedTriggerBoth = function(set) {
    exec(null, null, "AppodealPlugin", "setOnLoadedTriggerBoth", [set]);
};

Appodeal.setSmartBanners = function(value) {
    exec(null, null, "AppodealPlugin", "setSmartBanners", [value]);
};

Appodeal.setBannerBackground = function(value) {
    exec(null, null, "AppodealPlugin", "setBannerBackground", [value]);
};

Appodeal.setBannerAnimation = function(value) {
    exec(null, null, "AppodealPlugin", "setBannerAnimation", [value]);
};

Appodeal.set728x90Banners = function(value) {
    exec(null, null, "AppodealPlugin", "set728x90Banners", [value]);
};

Appodeal.setLogging = function(logging) {
    exec(null, null, "AppodealPlugin", "setLogging", [logging]);
};

Appodeal.setTesting = function(testing) {
    exec(null, null, "AppodealPlugin", "setTesting", [testing]);
};

Appodeal.resetUUID = function() {
    exec(null, null, "AppodealPlugin", "resetUUID", []);
};

Appodeal.getVersion = function(callback) {
    exec(callback, null, "AppodealPlugin", "getVersion", []);
};

Appodeal.disableNetwork = function(network, adType) {
    exec(null, null, "AppodealPlugin", "disableNetwork", [network]);
};

Appodeal.disableNetworkType = function(network, adType) {
    exec(null, null, "AppodealPlugin", "disableNetworkType", [network, adType]);
};

Appodeal.disableLocationPermissionCheck = function() {
    exec(null, null, "AppodealPlugin", "disableLocationPermissionCheck", []);
};

Appodeal.disableWriteExternalStoragePermissionCheck = function() {
    exec(null, null, "AppodealPlugin", "disableWriteExternalStoragePermissionCheck", []);
};

Appodeal.enableInterstitialCallbacks = function(listener) {
    exec(null, null, "AppodealPlugin", "enableInterstitialCallbacks", [listener]);
};

Appodeal.enableSkippableVideoCallbacks = function(listener) {
    exec(null, null, "AppodealPlugin", "enableSkippableVideoCallbacks", [listener]);
};

Appodeal.enableNonSkippableVideoCallbacks = function(listener) {
    exec(null, null, "AppodealPlugin", "enableNonSkippableVideoCallbacks", [listener]);
};

Appodeal.enableBannerCallbacks = function(listener) {
    exec(null, null, "AppodealPlugin", "enableBannerCallbacks", [listener]);
};

Appodeal.enableRewardedVideoCallbacks = function(listener) {
    exec(null, null, "AppodealPlugin", "enableRewardedVideoCallbacks", [listener]);
};

Appodeal.setCustomBooleanRule = function(name, rule) {
    exec(null, null, "AppodealPlugin", "setCustomBooleanRule", [name, rule]);
};

Appodeal.setCustomIntegerRule = function(name, rule) {
    exec(null, null, "AppodealPlugin", "setCustomIntegerRule", [name, rule]);
};

Appodeal.setCustomDoubleRule = function(name, rule) {
    exec(null, null, "AppodealPlugin", "setCustomDoubleRule", [name, rule]);
};

Appodeal.setCustomStringRule = function(name, rule) {
    exec(null, null, "AppodealPlugin", "setCustomStringRule", [name, rule]);
};

Appodeal.setUserId = function(id) {
    exec(null, null, "AppodealPlugin", "setUserId", [id]);
};

Appodeal.setEmail = function(email) {
    exec(null, null, "AppodealPlugin", "setEmail", [email]);
};

Appodeal.setBirthday = function(birthday) {
    exec(null, null, "AppodealPlugin", "setBirthday", [birthday]);
};

Appodeal.setAge = function(age) {
    exec(null, null, "AppodealPlugin", "setAge", [age]);
};

Appodeal.setGender = function(gender) {
    exec(null, null, "AppodealPlugin", "setGender", [gender]);
};

Appodeal.setOccupation = function(occupation) {
    exec(null, null, "AppodealPlugin", "setOccupation", [occupation]);
};

Appodeal.setRelation = function(relation) {
    exec(null, null, "AppodealPlugin", "setRelation", [relation]);
};

Appodeal.setSmoking = function(smoking) {
    exec(null, null, "AppodealPlugin", "setSmoking", [smoking]);
};

Appodeal.setAlcohol = function(alcohol) {
    exec(null, null, "AppodealPlugin", "setAlcohol", [alcohol]);
};

Appodeal.setInterests = function(interests) {
    exec(null, null, "AppodealPlugin", "setInterests", [interests]);
};