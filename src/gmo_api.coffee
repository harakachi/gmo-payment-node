https = require "https"
querystring = require "querystring"
iconv = require "iconv-lite"
Const = require "./const"

iconv.skipDecodeWarning = true;

class GMOAPI
  constructor: (options = {}) ->
    @host = options.host

  api: (path, options_param, cb) ->
    params = @replaceParams(options_param)
    path = "/payment/#{path}"
    post_data = querystring.stringify(params)
    options =
      host: @host
      path: path
      method: "POST"
      port: 443
      headers:
        "Content-Type": "application/x-www-form-urlencoded"
        "Content-Length": post_data.length
    req = https.request(options, (res) ->
      res.setEncoding "utf8"
      res.on "data", (chunk) ->
        console.log "BODY: " + chunk
    )
    req.on "error", (e) ->
      console.log "problem with request: " + e.message
      cb e, null
    req.on "response", (res) ->
      response = ""
      res.setEncoding "utf8"
      res.on "data", (chunk) ->
        response += chunk
      res.on "end", ->
        err = null
        try
          response = iconv.decode(response, "sjis").toString()
        catch error
          console.log "ConvertError: #{error} #{response}"
        response = querystring.parse(response)
        response.httpStatusCode = res.statusCode
        if response["ErrCode"] || response["ErrInfo"]
          err = new Error("An error occured")
          err.response = response
          err.httpStatusCode = res.statusCode
          response = null
        unless err
          if res.statusCode < 200 or res.statusCode >= 300
            err = new Error("Response Status : " + res.statusCode)
            err.response = response
            err.httpStatusCode = res.statusCode
            response = null
        cb err, response
    req.write post_data
    req.end()

  assertRequiredOptions: (required, options) ->
    missing = []
    required.forEach (val) ->
      missing.push val  unless val of options
    if missing.length > 0
      throw new Error("ArgumentError: Required #{missing.join(', ')} were not provided.")

  replaceParams: (params) ->
    new_params = {}
    for key of params
      try
        new_params[Const[key]] = iconv.encode("#{params[key]}", "sjis").toString()
      catch error
        new_params[Const[key]] = "#{params[key]}"
    return new_params

module.exports.GMOAPI = GMOAPI
