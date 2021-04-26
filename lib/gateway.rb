require 'net/http'
require 'json'

class Gateway
    API_URL = "https://bank.gov.ua/NBUStatService/v1/statdirectory/exchange?json"

    def self.current_rates
        puts "API request"
        JSON.parse(Net::HTTP.get(URI(API_URL)), :symbolize_names => true)
    end

end