require "faraday"
require "faraday_middleware"

module Ruboty
  module Kiatsu
    class OpenWeatherMap
      THREE_HOUR_FORECAST_ENDPOINT = "http://api.openweathermap.org/data/2.5/forecast"

      def initialize(city_id: 1848040)
        @city_id = city_id
      end

      def pressure_diff
        now, three_hours  = response.body["list"].slice(0, 2)
        {
          start_time: Time.at(now["dt"]),
          end_time: Time.at(three_hours["dt"]),
          difference: three_hours["main"]["pressure"] - now["main"]["pressure"],
        }
      end

      private

      def response
        connection.get(THREE_HOUR_FORECAST_ENDPOINT, id: @city_id)
      end

      def connection
        Faraday.new do |connection|
          connection.adapter :net_http
          connection.response :json
        end
      end
    end
  end
end
