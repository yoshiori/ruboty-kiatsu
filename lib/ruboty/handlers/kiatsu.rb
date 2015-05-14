require "ruboty/kiatsu/open_weather_map"

module Ruboty
  module Handlers
    class Kiatsu < Base
      on /kiatsu/, name: "check_pressure", description: "check pressure"

      env :OPEN_WHEATHER_CITY_ID, "The city id in open wheather map. default: 1848040(minato ku) ", optional: true

      def check_pressure(message)
        message.reply("#{pressure_diff[:start_time]} 〜 #{pressure_diff[:end_time]} (diff #{pressure_diff[:difference].round(2)} hpa)")
        message.reply("!!! Low pressure Caution !!!") if pressure_diff[:difference] < -2
      end

      private

      def pressure_diff
        @pressure_diff ||= Ruboty::Kiatsu::OpenWeatherMap.new(
          city_id: ENV["OPEN_WHEATHER_CITY_ID"] || 1848040,
        ).pressure_diff
      end
    end
  end
end
