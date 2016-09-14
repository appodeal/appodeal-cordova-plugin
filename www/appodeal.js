
               var Appodeal = exports;
               
               var exec = require('cordova/exec');
               var cordova = require('cordova');
               
               Appodeal.INTERSTITIAL        = 1;
               Appodeal.SKIPPABLE_VIDEO     = 2;
               Appodeal.BANNER              = 4;
               Appodeal.NATIVE              = 8;
               Appodeal.REWARDED_VIDEO      = 16;
               Appodeal.MREC                = 32;
               Appodeal.NON_SKIPPABLE_VIDEO = 64;
               
               Appodeal.SHOW_INTERSTITIAL        = 1;
               Appodeal.SHOW_SKIPPABLE_VIDEO     = 2;
               Appodeal.SHOW_VIDEO_INTERSTITIAL  = 3;
               Appodeal.SHOW_BANNER_TOP          = 4;
               Appodeal.SHOW_BANNER_BOTTOM       = 5;
               Appodeal.SHOW_REWARDED_VIDEO      = 6;
               Appodeal.SHOW_NON_SKIPPABLE_VIDEO = 7;
               
               Appodeal.disableNetworkType = function(network, adType) {
               exec(null, null, "AppodealPlugin", "disableNetworkType", [network, adType]);
               }
               
               Appodeal.disableLocationPermissionCheck = function() {
               exec(null, null, "AppodealPlugin", "disableLocationPermissionCheck", []);
               }
               
               Appodeal.setAutoCache = function(adType, autoCache) {
               exec(null, null, "AppodealPlugin", "setAutoCache", [adType, autoCache]);
               }
               
               Appodeal.isPrecache = function(adType, callback) {
               exec(function(result){
                    appendStatus(result);
                    }, null, "AppodealPlugin", "isPrecache", [adType]);
               }
               
               Appodeal.initialize = function(appKey, adType) {
               exec(null, null, "AppodealPlugin", "initialize", [appKey, adType]);
               }
               
               Appodeal.isInitalized = function() {
               exec(function(result){
                    appendStatus(result);
                    }, null, "AppodealPlugin", "isInitalized", []);
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
               
               Appodeal.show = function(adType, callback) {
               exec(function(result){
                    appendStatus(result);
                    }, null, "AppodealPlugin", "show", [adType]);
               }
               
               Appodeal.showWithPlacement = function(adType, placement, callback) {
               exec(function(result){
                    appendStatus(result);
                    }, null, "AppodealPlugin", "showWithPlacement", [adType, placement]);
               }
               
               Appodeal.cache = function(adType) {
               exec(null, null, "AppodealPlugin", "cache", [adType]);
               }
               
               Appodeal.hide = function(adType) {
               exec(null, null, "AppodealPlugin", "hide", [adType]);
               }
               
               Appodeal.setLogging = function(logging) {
               exec(null, null, "AppodealPlugin", "setLogging", [logging]);
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
               
               Appodeal.isLoaded = function(adType, callback) {
               exec(function(result){
                    appendStatus(result);
                    }, null, "AppodealPlugin", "isLoaded", [adType]);
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
               
               Appodeal.setUserId = function(id) {
               exec(null, null, "AppodealPlugin", "setUserId", [id]);
               }
               
               Appodeal.setEmail = function(email) {
               exec(null, null, "AppodealPlugin", "setEmail", [email]);
               }
               
               Appodeal.setBirthday = function(birthday) {
               exec(null, null, "AppodealPlugin", "setBirthday", [birthday]);
               }
               
               Appodeal.setAge = function(age) {
               exec(null, null, "AppodealPlugin", "setAge", [age]);
               }
               
               Appodeal.setGender = function(gender) {
               exec(null, null, "AppodealPlugin", "setGender", [gender]);
               }
               
               Appodeal.setOccupation = function(occupation) {
               exec(null, null, "AppodealPlugin", "setOccupation", [occupation]);
               }
               
               Appodeal.setRelation = function(relation) {
               exec(null, null, "AppodealPlugin", "setRelation", [relation]);
               }
               
               Appodeal.setSmoking = function(smoking) {
               exec(null, null, "AppodealPlugin", "setSmoking", [smoking]);
               }
               
               Appodeal.setAlcohol = function(alcohol) {
               exec(null, null, "AppodealPlugin", "setAlcohol", [alcohol]);
               }
               
               Appodeal.setInterests = function(interests) {
               exec(null, null, "AppodealPlugin", "setInterests", [interests]);
               }

