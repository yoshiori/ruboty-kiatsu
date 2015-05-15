require "ruboty/kiatsu/open_weather_map"

module Ruboty
  module Handlers
    class Kiatsu < Base
      on /kiatsu/, name: "check_pressure", description: "check pressure"

      env :OPEN_WHEATHER_CITY_ID, "The city id in open wheather map. default: 1848040(minato ku) ", optional: true

      def check_pressure(message)
        diff = pressure_diff
        message.reply("#{strftime(diff[:start_time])} 〜 #{strftime(diff[:end_time])} (diff #{diff[:difference].round(2)} hpa)")
        message.reply("!!! Low pressure Caution !!!") if diff[:difference] < -2
      end

      private

      def strftime(time)
        time.strftime("%m/%d %H:%M")
      end

      def pressure_diff
        Ruboty::Kiatsu::OpenWeatherMap.new(
          city_id: ENV["OPEN_WHEATHER_CITY_ID"] || 1848040,
        ).pressure_diff
      end
    end
  end
end
