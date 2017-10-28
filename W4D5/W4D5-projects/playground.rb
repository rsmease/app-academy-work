require 'net/http'
require 'json'
url = "https://api.giphy.com/v1/gifs/random?api_key=WowLIPJbsZymHSrRfupBUX9hdPH0AB13&tag=pokemon&rating=PG-13"
resp = Net::HTTP.get_response(URI.parse(url))
buffer = resp.body
result = JSON.parse(buffer)
result["data"]["image_original_url"]
