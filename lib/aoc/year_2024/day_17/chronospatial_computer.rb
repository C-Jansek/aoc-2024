module Aoc
  module Year2024
    class Day17
      def self.example_input
        <<-INPUT.strip
          Register A: 729
          Register B: 0
          Register C: 0
          
          Program: 0,1,5,4,3,0
        INPUT
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        registers, program = input.strip.split(/\n\s*\n/).map(&:strip)

        a, b, c = registers.lines.map do |register|
          register.strip.match(/Register [A-C]: (\d*)/)[1].to_i
        end
        program = program.strip.split(' ')[1].split(',').map(&:to_i)
        {
          registers: {
            a: a,
            b: b,
            c: c
          },
          program: program,
        }
      end

      def combo_operand_value(combo, a, b, c)
        return combo if combo.between?(0, 3)

        return a if combo == 4
        return b if combo == 5
        return c if combo == 6

        raise StandardError("Unexpected combo operand #{combo}")
      end

      def xor(a, b)
        a = a.rjust([a.length, b.length].max, '0').split('').map(&:to_i)
        b = b.rjust([a.length, b.length].max, '0').split('').map(&:to_i)

        a.zip(b).map do |first, second|
          ((!first.zero? && !second.zero?) || (first.zero? && second.zero?)) ? '0' : '1'
        end.join('').to_i(2)
      end

      def part_one(input, overwrite_a: -1)
        parsed = parse(input)

        a, b, c = parsed.dig(:registers).values_at(:a, :b, :c)
        program = parsed.dig(:program)
        instruction_pointer = 0

        a = overwrite_a if overwrite_a > 0

        output = []

        while instruction_pointer < program.length
          opcode = program[instruction_pointer]
          operand = program[instruction_pointer + 1]

          case opcode
          when 0
            combo_operand = combo_operand_value(operand, a, b, c)
            a = (a / 2 ** combo_operand).truncate
          when 1
            b = xor(b.to_s(2), operand.to_s(2)).to_i
          when 2
            b = combo_operand_value(operand, a, b, c) % 8
          when 3
            unless a == 0
              instruction_pointer = operand - 2 # minus two to compensate for normal increment
            end
          when 4
            b = xor(b.to_s(2), c.to_s(2)).to_i
          when 5
            output << (combo_operand_value(operand, a, b, c) % 8).to_s
          when 6
            combo_operand = combo_operand_value(operand, a, b, c)
            b = (a / 2 ** combo_operand).truncate
          when 7
            combo_operand = combo_operand_value(operand, a, b, c)
            c = (a / 2 ** combo_operand).truncate
          else
            raise StandardError("Unexpected opcode #{opcode}")
          end

          instruction_pointer += 2
        end

        [output.join(','), a, b, c]
      end

      def part_two(input, overwrite_a: -1)
        parsed = parse(input)
        program = parsed.dig(:program).map(&:to_s).join(',')

        puts program
        part_one(input, overwrite_a: overwrite_a)[0]
      end
    end
  end
end
