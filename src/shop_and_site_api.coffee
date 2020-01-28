utils = require "./utils"
gmo = require "./gmo_api"

# ShopAndSiteAPI
# -
# GMO moduleでは、API呼び出しにGMOから与えられたショップID、ショップパス、サイトID、サイトパスが必要になるAPIをShopAndSite APIと定義しています。
#
# 初期化の際には、GMOから指定されたショップID、ショップパス、サイトID、サイトパス、APIのホスト名を引数で渡す必要があります。
class ShopAndSiteAPI extends gmo.GMOAPI
  constructor: (options = {}) ->
    @host      = options.host
    @site_id   = options.site_id
    @site_pass = options.site_pass
    @shop_id   = options.shop_id
    @shop_pass = options.shop_pass
    unless @shop_id && @shop_pass && @site_id && @site_pass && @host
      throw new Error("ArgumentError: Initialize must receive a hash with shop_id, shop_pass, site_id, site_pass and either host!")

  # 2.17.2.1.決済後カード登録
  # ---
  # ###tradedCard
  # 指定されたオーダーID の取引に使用したカードを登録します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  tradedCard: (options, cb) ->
    name = "TradedCard.idPass"
    required = [
      "order_id"
      "member_id"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 4.1 自動売上定義を登録する（クレジットカード）
  # ---
  # ###RegisterRecurringCredit
  # 自動売上ID、課金情報（スケジュール、金額）、売上対象情報(カード情報／会員ID／取引)を指定して、自動売上の定義を登録します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  RegisterRecurringCredit: (options, cb) ->
    name = "RegisterRecurringCredit.idPass"
    required = [
      "recurring_id"
      "amount"
      "charge_day"
      "regist_type"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 4.3 自動売上定義を解除する
  # ---
  # ###UnregisterRecurring
  # 自動売上IDを指定して、自動売上の定義を解除します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  UnregisterRecurring: (options, cb) ->
    name = "UnregisterRecurring.idPass"
    required = [
      "recurring_id"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 4.4 自動売上定義を変更する
  # ---
  # ###ChangeRecurring
  # 自動売上IDを指定して、自動売上の定義を変更します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  ChangeRecurring: (options, cb) ->
    name = "ChangeRecurring.idPass"
    required = [
      "recurring_id"
      "amount"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 4.5 自動売上定義を参照する
  # ---
  # ###SearchRecurring
  # 自動売上IDを指定して、自動売上の定義を参照します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  SearchRecurring: (options, cb) ->
    name = "SearchRecurring.idPass"
    required = [
      "recurring_id"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  # 4.6 自動売上結果を参照する
  # ---
  # ###SearchRecurringResult
  # 自動売上IDを指定して、自動売上結果を参照します。
  #
  # ```@param {Object} options```
  #
  # ```@param {Function} cb```
  SearchRecurringResult: (options, cb) ->
    name = "SearchRecurringResult.idPass"
    required = [
      "recurring_id"
    ]
    @assertRequiredOptions required, options
    @apiCall name, options, cb

  apiCall: (name, options, cb) ->
    extra_params =
      "site_id": @site_id
      "site_pass": @site_pass
      "shop_id": @shop_id
      "shop_pass": @shop_pass
    params = utils.extend(options, extra_params)
    @api name, params, cb

module.exports = ShopAndSiteAPI
