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
        # lower_bound = 9 ** (program_length - 2)
        # upper_bound = [9 ** (program_length), (106009656297628*1.1).round].min
        lower_bound = 105872213245252
        upper_bound = 105872213251300

        puts program + "    actual"

        500.times do
          puts part_one(input, overwrite_a: lower_bound)[0] + "   lower_bound: #{lower_bound.to_s}"
          puts part_one(input, overwrite_a: upper_bound)[0] + "    upper_bound: #{upper_bound.to_s}  "

          step_count = 2500
          step_size = [((upper_bound - lower_bound) / step_count).round, 1].max
          guesses = step_count.times.map do |i|
            lower_bound + step_size * i
          end

          puts "#{upper_bound - lower_bound} left to search, step size #{step_size}"

          to_overlapping = guesses.map do |guess|
            answer = part_one(input, overwrite_a: guess)[0]
            overlapping_count = answer.split(',').reverse.zip(program.split(',').reverse).take_while do |ans, actual|
              ans == actual
            end.count
            overlapping_count = -1 if answer.length != program.length
            puts "#{answer}   #{overlapping_count}   #{guess}"

            { guess: guess, ans: answer, overlapping: overlapping_count }
          end

          max_overlap = to_overlapping.map {|overlap| overlap.fetch(:overlapping, - 1)}.max

          # raise StandardError.new("Cant specify enough") if max_overlap == last_max_overlap

          puts "max_overlap: #{max_overlap}"
          first_most_overlapping_guess_index = to_overlapping.index do |overlap|
            max_overlap == overlap.fetch(:overlapping, - 1)
          end || 0
          first_most_overlapping_guess_index -= 1 unless first_most_overlapping_guess_index.zero?

          last_most_overlapping_guess_index = to_overlapping.length - (to_overlapping.reverse.index do |overlap|
            max_overlap == overlap.fetch(:overlapping, - 1)
          end || 1)
          last_most_overlapping_guess_index += 1 unless last_most_overlapping_guess_index == to_overlapping.count - 1

          if step_size == 1
            puts program + "   actual"
            good_guess = to_overlapping.find do |overlapping|
              overlapping[:ans] == program
            end
            puts good_guess[:ans] unless good_guess.nil?
            return good_guess&.fetch(:guess, false)
          end

          last_max_overlap = max_overlap
          lower_bound = guesses[first_most_overlapping_guess_index] || guesses.first
          upper_bound = guesses[last_most_overlapping_guess_index] || guesses.last
        end

        false
      end
    end
  end
end
