/* jshint jasmine: true */

exports.defineAutoTests = function() {
	describe('Appodeal plugin tests', function () {
		beforeAll(function(done) {
			Appodeal.setLogging(true);
			done();
		});
		it('isLoaded test', function(done) {
			Appodeal.isLoaded(Appodeal.BANNER, function(result){
				expect(typeof(result)).toBe("boolean");
				done();
			});
		});
		it('isPrecache test', function(done) {
			Appodeal.isPrecache(Appodeal.BANNER, function(result){
				expect(typeof(result)).toBe("boolean");
				done();
			});
		});
		it('show test', function(done) {
			Appodeal.show(Appodeal.BANNER, function(result){
				expect(typeof(result)).toBe("boolean");
				done();
			});
		});
		it('show with placement test', function(done) {
			Appodeal.showWithPlacement(Appodeal.INTERSTITIAL, "menu", function(result){
				expect(typeof(result)).toBe("boolean");
				done();
			});
		});
	});
};

exports.defineManualTests = function(contentEl, createActionButton) {};