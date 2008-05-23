require 'optparse'
require 'simplecli'

class ADF::Bin
  include SimpleCLI

  def usage *args
    puts <<doco

  adf == %{ Auto-lead Data Format Utility }

    Usage:
      adf -h/--help      [Not Implemented Yet]
      adf -v/--version   [Not Implemented Yet]
      adf command [options]

    Examples:
      adf highlight my-file.rb

    Further help:
      adf commands         # list all available commands
      adf help <COMMAND>   # show help for COMMAND
      adf help             # show this help message

doco
  end 

  def example_help
    <<doco
Usage: #{ script_name } example

  Summary:
    Just an example
doco
  end
  def example *args
    puts "example: #{ args.inspect }"
  end

end
