require 'telegram/bot'
require 'zache'

require './lib/gateway'

FAVOURITE_EXCHANGE_RATES = %i(USD EUR PLN GBP)

token = ""

def cache
    @cache ||= Zache.new
end

def current_rates_handler
    rates = Gateway.current_rates

    filtered_rates = rates.select do |record|
       FAVOURITE_EXCHANGE_RATES.include?(record[:cc].to_sym)
    end

    # Pretty print
    filtered_rates.map do |record|
        "Exchange rate for #{record[:cc]} => #{record[:rate]}"
end

Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      case message.text
      when '/start'
        bot.api.send_message(chat_id: message.chat.id, text: "Hi, I'm he here to give you most recent exachange currency #{message.from.first_name}")
      when '/rates'
        result = current_rates_handler
        bot.api.send_message(chat_id: message.chat.id, text: result.join("\n")
      when '/stop'
        bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}")
      end
    end
  end
