require "sinatra"
require "sinatra/reloader"

require "http"
require "json"

get("/") do
  symbols_url = "https://api.exchangerate.host/symbols"
  raw_symbols_data = HTTP.get(symbols_url)
  parsed_symbols_data = JSON.parse(raw_symbols_data)
  full_symbols_hash = parsed_symbols_data.fetch("symbols")
  @symbols_array = full_symbols_hash.keys
  erb(:first_page)
end

get("/:currency_f") do
  symbols_url = "https://api.exchangerate.host/symbols"
  raw_symbols_data = HTTP.get(symbols_url)
  parsed_symbols_data = JSON.parse(raw_symbols_data)
  full_symbols_hash = parsed_symbols_data.fetch("symbols")
  @symbols_array = full_symbols_hash.keys
  @currency_from = params.fetch("currency_f")
  erb(:second_page)
end

get("/:currency_f/:currency_t") do
  @currency_from = params.fetch("currency_f")
  @currency_to = params.fetch("currency_t")
  conversionrate_url = "https://api.exchangerate.host/convert?from=#{@currency_from}&to=#{@currency_to}"
  raw_conversionrate_data = HTTP.get(conversionrate_url)
  parsed_conversionrate_data = JSON.parse(raw_conversionrate_data)
  conversionrate = parsed_conversionrate_data.fetch("result")
  @conversionrate_string = conversionrate.to_s
  erb(:conversion)
end
