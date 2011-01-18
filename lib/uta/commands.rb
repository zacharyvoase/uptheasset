require 'optparse'

module UTA
  # Contains all the command definitions for the `uta` CLI.
  module Commands
    # Retrieve the command class for the given symbol
    def self.[](command_name)
      self.const_get(
        self.constants
          .select { |const| const.to_s.downcase == command_name.to_s.downcase }
          .first)
    end
  end

  class Command
    # Parse the command-line arguments for this command.
    # @abstract
    def initialize(args)
    end

    # Execute this command.
    # @abstract
    def run
    end
  end
end
