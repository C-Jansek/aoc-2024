module Aoc
  module Year2024
    class Day09
      def self.example_input
        <<-MSG.strip
          2333133121414131402
        MSG
      end

      def self.personal_input
        File.open("#{__dir__}/./input.txt").read
      end

      def parse(input)
        input.strip.split('').each_with_index.map do |character, index|
          character.to_i.times.map do
            if index % 2 == 0
              ((index + 1) / 2)
            else
              -1
            end
          end
        end.flatten
      end

      def compress(storage)
        compressed_storage = storage
        storage_only_blocks = compressed_storage.select do |block|
          block != -1
        end
        block_count = storage_only_blocks.count
        reversed_storage = compressed_storage.reverse
        removed_elements_count = 0

        compressed_storage.each_with_index do |block, index|
          break if index >= block_count
          next unless block == -1

          replace_with = -1
          while replace_with == -1
            replace_with = reversed_storage.shift
            removed_elements_count += 1
          end

          replace_with_index = compressed_storage.length - removed_elements_count
          compressed_storage[index], compressed_storage[replace_with_index] = storage_only_blocks.pop, -1
        end

        compressed_storage
      end

      def compress_in_blocks(storage)
        compressed_storage = [{ value: storage[0], amount: 1 }]

        storage.each_cons(2) do |first, second|
          if first != second
            compressed_storage.push({ value: second, amount: 1 })
          else
            compressed_storage.last[:amount] += 1
          end
        end

        compressed_storage.reverse.each do |block|
          replace_index = compressed_storage.find_index do |storage|
            break if storage[:value] == block[:value]

            storage[:value] == -1 && storage[:amount] >= block[:amount]
          end

          next if replace_index == nil

          current_index = compressed_storage.find_index(block)
          compressed_storage[current_index] = { value: -1, amount: block[:amount] }

          if compressed_storage[replace_index][:amount] == block[:amount]
            compressed_storage[replace_index] = block
          else
            remaining_amount = compressed_storage[replace_index][:amount] - block[:amount]
            compressed_storage[replace_index] = block
            compressed_storage.insert(replace_index + 1, { value: -1, amount: remaining_amount })
          end
        end

        compressed_storage.map do |block|
          block[:amount].times.map { block[:value] }
        end.flatten
      end

      def calculate_checksum(storage)
        storage.map.with_index do |block, index|
          next 0 if block == -1

          block.to_i * index
        end.sum
      end

      def part_one(input)
        parsed = parse(input)
        calculate_checksum(compress(parsed))
      end

      def part_two(input)
        parsed = parse(input)
        calculate_checksum(compress_in_blocks(parsed))
      end
    end
  end
end
