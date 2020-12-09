Dir[File.expand_path("../lib/*", __dir__)].each { |f| require_relative f }

require "pry-byebug"
