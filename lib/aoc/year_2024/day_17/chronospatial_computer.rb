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

        program_length = parsed.dig(:program).length

        # Find the upper and lower bounds of A by the length of the program
        lower_bound = 9 ** (program_length - 2)
        upper_bound = 9 ** (program_length)

        puts program + "    actual"

        500.times do
          step_count = 200
          step_size = [((upper_bound - lower_bound) / step_count).round, 1].max
          guesses = step_count.times.map do |i|
            lower_bound + step_size * i
          end

          puts "#{upper_bound - lower_bound} left to search, step size #{step_size}"
          puts part_one(input, overwrite_a: lower_bound)[0] + "   lower_bound: #{lower_bound.to_s}"
          puts part_one(input, overwrite_a: upper_bound)[0] + "    upper_bound: #{upper_bound.to_s}  "

          to_overlapping = guesses.map do |guess|
            answer = part_one(input, overwrite_a: guess)[0]
            overlapping_count = answer.split(',').reverse.zip(program.split(',').reverse).take_while do |ans, actual|
              ans == actual
            end.count
            overlapping_count = 0 if answer.length != program.length
            { guess: guess, ans: answer, overlapping: overlapping_count }
          end

          max_overlap = to_overlapping.max {|overlap| overlap.fetch(:overlapping, - 1)}[:overlapping]
          puts "max_overlap: #{max_overlap}"
          first_most_overlapping_guess = to_overlapping.find do |overlap|
            max_overlap == overlap.fetch(:overlapping, - 1)
          end

          last_most_overlapping_guess = to_overlapping.reverse.find do |overlap|
            max_overlap == overlap.fetch(:overlapping, - 1)
          end

          if step_size == 1
            puts program + "   actual"
            good_guess = to_overlapping.find do |overlapping|
              overlapping[:ans] == program
            end
            puts good_guess[:ans] unless good_guess.nil?
            return good_guess&.fetch(:guess, false)
          end

          lower_bound = guesses[[guesses.index(first_most_overlapping_guess[:guess]) - 1, 0].max]
          upper_bound = guesses[[guesses.index(last_most_overlapping_guess[:guess]) + 1, guesses.length - 1].min]
        end
      end
    end
  end
end
