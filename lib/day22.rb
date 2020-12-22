# frozen_string_literal: true

require "digest"

class Day22_2
  class << self
    def calculate_game_score(input)
      player_1, player_2 = input.split("\n\n").map { |player_input| player_input.split("\n").drop(1).map(&:to_i) }
      end_state = CombatGame.new(player_1, player_2).call

      game_score = 0
      end_state.flatten.compact.reverse.each_with_index do |card, index|
        game_score += card * (index + 1)
      end

      game_score
    end
  end

  class CombatGame
    def initialize(player_1, player_2, debug_id = 1)
      @player_1 = player_1.dup
      @player_2 = player_2.dup
      @play_states = []
      @debug_id = debug_id
    end

    def call
      puts "Starting Game #{debug_id}"

      run_round

      puts "Game #{debug_id} finished with #{player_1.empty? ? 'Player 2' : 'Player 1'} winning"

      [player_1, player_2]
    end

    private

    def run_round
      return if player_1.empty? || player_2.empty?

      state = Digest::SHA256.hexdigest("Player1##{player_1.join},Player2##{player_2.join}")

      if play_states.include?(state)
        self.player_1 = player_1 + player_2
        self.player_2 = []
      else
        self.play_states << state

        # Draw cards
        card_1 = player_1[0]
        card_2 = player_2[0]

        if player_1[1..-1].size >= card_1 && player_2[1..-1].size >= card_2
          play_recursive_combat(card_1, card_2)
        else
          play_regular_round(card_1, card_2)
        end
      end
    rescue SystemStackError => e
      puts "Raised Stack too deep"
      run_round
    end

    attr_accessor :player_1, :player_2, :play_states
    attr_reader :debug_id

    def play_recursive_combat(card_1, card_2)
      new_player_1 = player_1[1..-1].take(card_1)
      new_player_2 = player_2[1..-1].take(card_2)

      result = CombatGame.new(new_player_1, new_player_2, debug_id + 1).call

      if result[0].size > result[1].size
        # Player 1 wins
        self.player_1 = player_1[1..-1] + [card_1, card_2]
        self.player_2 = player_2[1..-1]
      else
        # Player 2 wins
        self.player_1 = player_1[1..-1]
        self.player_2 = player_2[1..-1] + [card_2, card_1]
      end

      run_round
    end

    def play_regular_round(card_1, card_2)
      if card_1 > card_2
        # Player 1 wins
        self.player_1 = player_1[1..-1] + [card_1, card_2]
        self.player_2 = player_2[1..-1]
      else
        # Player 2 wins
        self.player_1 = player_1[1..-1]
        self.player_2 = player_2[1..-1] + [card_2, card_1]
      end

      run_round
    end
  end
end

class Day22_1
  class << self
    def calculate_game_score(input)
      player_1, player_2 = input.split("\n\n").map { |player_input| player_input.split("\n").drop(1).map(&:to_i) }
      end_state = CombatGame.new(player_1, player_2).call

      game_score = 0
      end_state.flatten.compact.reverse.each_with_index do |card, index|
        game_score += card * (index + 1)
      end

      game_score
    end
  end

  class CombatGame
    def initialize(player_1, player_2)
      @player_1 = player_1.dup
      @player_2 = player_2.dup
    end

    def call
      run_round

      [player_1, player_2]
    end

    private

    def run_round
      return if player_1.empty? || player_2.empty?

      card_1 = player_1.shift
      card_2 = player_2.shift

      card_1 > card_2 ? self.player_1 = player_1 + [card_1, card_2] : self.player_2 = player_2 + [card_2, card_1]

      run_round
    end

    attr_accessor :player_1, :player_2
  end
end
