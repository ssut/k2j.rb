# encoding: utf-8
require 'k2j/maps'

module K2J
  # K2J Converter
  #
  # @version 0.1.0
  class Converter
    class << self
      initialized = false

      def initialize
        break_map(K2J::Map::CHO, K2J::Map.method(:cho))
        break_map(K2J::Map::JOONG, K2J::Map.method(:joong))
        break_map(K2J::Map::JONG, K2J::Map.method(:jong))

        @initialized = true
      end

      def convert(str)
        initialize unless @initialized

        result = ''
        str.size.times do |i|
          ch = str[i]

          special = special_case(str[i - 1], ch, str[i + 1])
          unless special.nil?
            result << special
            next
          end

          col = index_of(K2J::Map::CHO, K2J::Map.cho(ch))
          row = index_of(K2J::Map::JOONG, K2J::Map.joong(ch))
          gana = K2J::Map::HIRAGANA[col * 13 + row]

          result << (gana.nil? ? ch : gana)

          ad = index_of(K2J::Map::JONG, K2J::Map.jong(ch))
          case ad
          when 0
            result << "ん"
          when 1
            result << "っ"
          end
        end

        result
      end

      private
      def special_case(ch1, ch2, ch3)
        case ch2
        when '-'
          if ch1 != '-' and ch3 != '-'
            "う"
          elsif ch1 != '-'
            '-'
          else
            ''
          end
        when '.'
          "。"
        when '와'
          'わ'
        when '워'
          'を'
        when "\n"
          "\n"
        when ' '
          ' '
        else
          nil
        end
      end

      def index_of(map, ch)
        map.each_with_index do |k, i|
          k.size.times do |j|
            if map[i][j] == ch
              return i
            end
          end
        end
      end

      def break_map(map, func)
        map.each_with_index do |k, i|
          k.size.times do |j|
            map[i] = map[i].gsub(map[i][j], func.call(map[i][j]))
          end
        end
      end
    end
  end
end
