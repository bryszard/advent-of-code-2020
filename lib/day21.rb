# frozen_string_literal: true

class Day21
  class << self
    def count_nonallergic_occurences(input)
      ingredients = input.split("\n")
      result = AllergensTranslator.new(ingredients).call

      result[:ingredients_map].map { |ingr| ingr[:encoded] }.flatten.count
    end

    def canonical_dangerous_list(input)
      ingredients = input.split("\n")
      result = AllergensTranslator.new(ingredients).call

      result[:translations].sort.map { |translation| translation[1] }.join(",")
    end
  end

  class AllergensTranslator
    def initialize(ingredients)
      @ingredients_map = ingredients.map do |row|
        allgns_encoded, allgns_translated = row.split(" (contains ")

        {
          encoded: allgns_encoded.split(" "),
          decoded: allgns_translated[0..-2].split(", ")
        }
      end
      @translations = {}
    end

    def call
      run_translations

      {
        translations: translations,
        ingredients_map: ingredients_map
      }
    end

    private

    attr_accessor :translations
    attr_reader :ingredients_map

    def run_translations
      return unless (next_translation = next_possible_translation)

      translated_allergen = next_translation[:decoded].first

      if next_translation[:encoded].size.eql?(1)
        translation = next_translation[:encoded].first
      else
        translation = common_encoded(next_translation).first
      end

      translations[translated_allergen] = translation

      ingredients_map.each do |ingredient|
        ingredient[:encoded].delete(translation)
        ingredient[:decoded].delete(translated_allergen)
      end

      run_translations
    end

    def next_possible_translation
      single_matches = ingredients_map.select { |ingredient| ingredient[:decoded].size.eql?(1) }

      if (single_allergen = single_matches.find { |ingredient| ingredient[:encoded].size.eql?(1) })
        single_allergen
      else
        all_untranslated = ingredients_map.map { |ingredient| ingredient[:decoded] }.flatten

        single_matches.find do |ingredient|
          all_untranslated.count(ingredient[:decoded].first) > 1 && unambiguous_translation?(ingredient)
        end
      end
    end

    def all_untranslated
      ingredients_map.map { |ingr| ingr[:encoded] }.flatten.count
    end

    def unambiguous_translation?(ingredient)
      common_encoded(ingredient).count.eql?(1)
    end

    def common_encoded(ingredient)
      compared_ingredients = (ingredients_map - [ingredient]).select do |ingr|
        ingr[:decoded].include?(ingredient[:decoded].first)
      end

      compared_ingredients.inject(ingredient[:encoded]) do |aggr, ingr|
        aggr & ingr[:encoded]
      end
    end
  end
end
