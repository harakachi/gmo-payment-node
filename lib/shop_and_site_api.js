// Generated by CoffeeScript 1.12.7
(function() {
  var ShopAndSiteAPI, gmo, utils,
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  utils = require("./utils");

  gmo = require("./gmo_api");

  ShopAndSiteAPI = (function(superClass) {
    extend(ShopAndSiteAPI, superClass);

    function ShopAndSiteAPI(options) {
      if (options == null) {
        options = {};
      }
      this.host = options.host;
      this.site_id = options.site_id;
      this.site_pass = options.site_pass;
      this.shop_id = options.shop_id;
      this.shop_pass = options.shop_pass;
      if (!(this.shop_id && this.shop_pass && this.site_id && this.site_pass && this.host)) {
        throw new Error("ArgumentError: Initialize must receive a hash with shop_id, shop_pass, site_id, site_pass and either host!");
      }
    }

    ShopAndSiteAPI.prototype.tradedCard = function(options, cb) {
      var name, required;
      name = "TradedCard.idPass";
      required = ["order_id", "member_id"];
      this.assertRequiredOptions(required, options);
      return this.apiCall(name, options, cb);
    };

    ShopAndSiteAPI.prototype.RegisterRecurringCredit = function(options, cb) {
      var name, required;
      name = "RegisterRecurringCredit.idPass";
      required = ["recurring_id", "amount", "charge_day", "regist_type"];
      this.assertRequiredOptions(required, options);
      return this.apiCall(name, options, cb);
    };

    ShopAndSiteAPI.prototype.UnregisterRecurring = function(options, cb) {
      var name, required;
      name = "UnregisterRecurring.idPass";
      required = ["recurring_id"];
      this.assertRequiredOptions(required, options);
      return this.apiCall(name, options, cb);
    };

    ShopAndSiteAPI.prototype.ChangeRecurring = function(options, cb) {
      var name, required;
      name = "ChangeRecurring.idPass";
      required = ["recurring_id", "amount"];
      this.assertRequiredOptions(required, options);
      return this.apiCall(name, options, cb);
    };

    ShopAndSiteAPI.prototype.SearchRecurring = function(options, cb) {
      var name, required;
      name = "SearchRecurring.idPass";
      required = ["recurring_id"];
      this.assertRequiredOptions(required, options);
      return this.apiCall(name, options, cb);
    };

    ShopAndSiteAPI.prototype.SearchRecurringResult = function(options, cb) {
      var name, required;
      name = "SearchRecurringResult.idPass";
      required = ["recurring_id"];
      this.assertRequiredOptions(required, options);
      return this.apiCall(name, options, cb);
    };

    ShopAndSiteAPI.prototype.apiCall = function(name, options, cb) {
      var extra_params, params;
      extra_params = {
        "site_id": this.site_id,
        "site_pass": this.site_pass,
        "shop_id": this.shop_id,
        "shop_pass": this.shop_pass
      };
      params = utils.extend(options, extra_params);
      return this.api(name, params, cb);
    };

    return ShopAndSiteAPI;

  })(gmo.GMOAPI);

  module.exports = ShopAndSiteAPI;

}).call(this);
