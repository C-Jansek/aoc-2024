module Aoc
  module Helpers
    class Grid
      module ParsingModes
        DIGIT = 'digit'.to_sym.freeze
        INTEGER_SPACE_SEPARATED = 'integer_space_separated'.to_sym.freeze
        CHARACTER = 'character'.to_sym.freeze
        STRING_SPACE_SEPARATED = 'string_space_separated'.to_sym.freeze

        ALL = constants.map { |c| const_get(c) }.freeze
      end

      module Directions
        NORTH_EAST = 'north_east'.to_sym.freeze
        NORTH = 'north'.to_sym.freeze
        NORTH_WEST = 'north_west'.to_sym.freeze
        WEST = 'west'.to_sym.freeze
        SOUTH_WEST = 'south_west'.to_sym.freeze
        SOUTH = 'south'.to_sym.freeze
        SOUTH_EAST = 'south_east'.to_sym.freeze
        EAST = 'east'.to_sym.freeze

        ALL_DIRECT = [NORTH, WEST, SOUTH, EAST].freeze
        ALL_DIAGONAL = [NORTH_EAST, NORTH_WEST, SOUTH_WEST, SOUTH_EAST].freeze

        ALL = ALL_DIRECT + ALL_DIAGONAL
      end

      Point = Struct.new(:x, :y)

      DIRECTION_TO_DELTA = {
        Directions::NORTH_EAST => Point[-1, -1],
        Directions::NORTH => Point[0, -1],
        Directions::NORTH_WEST => Point[1, -1],
        Directions::WEST => Point[1, 0],
        Directions::SOUTH_WEST => Point[1, 1],
        Directions::SOUTH => Point[0, 1],
        Directions::SOUTH_EAST => Point[-1, 1],
        Directions::EAST => Point[-1, 0],
      }

      attr_reader :points, :width, :height

      def initialize(input, parsing_mode: ParsingModes::CHARACTER)
        validate_parsing_mode(parsing_mode)

        @points = parse(input, parsing_mode)
        @width = @points[0].length
        @height = @points.length
      end

      def parse(input, parsing_mode)
        input.strip.lines.map do |line|
          row = line.strip

          case parsing_mode
          when ParsingModes::CHARACTER
            row.split('')
          when ParsingModes::DIGIT
            row.split('').map(&:to_i)
          when ParsingModes::INTEGER_SPACE_SEPARATED
            row.split(' ').map(&:to_i)
          when ParsingModes::STRING_SPACE_SEPARATED
            row.split(' ')
          else
            raise ArgumentError("Unknown parsing mode #{parsing_mode}.")
          end
        end
      end

      def inside_grid(point)
        point.x >= 0 && point.x < width && point.y >= 0 && point.y < height
      end

      def find_with_value(value)
        row, y = points.each_with_index.find do |row, y|
          row.include?(value)
        end

        _cell, x = row.each_with_index.find do |cell, x|
          cell == value
        end

        Point[x, y]
      end

      private

      def validate_parsing_mode(parsing_mode)
        unless ParsingModes::ALL.include?(parsing_mode)
          raise ArgumentError("Unknown parsing mode #{parsing_mode}.")
        end
      end
    end
  end
end