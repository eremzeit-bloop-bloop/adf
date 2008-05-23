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

    Further help:
      adf commands         # list all available commands
      adf help <COMMAND>   # show help for COMMAND
      adf help             # show this help message

doco
  end 

  ### helper methods
  def resource file
    File.expand_path( File.dirname(__FILE__) + "/../../resources/#{ file }" )
  end
  def validate_dtd options
    file, dtd = options[:file], options[:dtd]

    file_content = File.read file
    output = `xmllint --dtdvalid '#{ dtd }' '#{ file }' 2>&1`.sub file_content, ''

    dtd = File.basename dtd
    if output.empty?
      system %{echo -e "\e[32mVALID OK\e[37m [#{dtd}]\n"}
    else
      system %{echo -e "\e[31mFAILED\e[37m [#{dtd}]\n\n#{output}"}
    end
  end
  ### --------------

  def validate_help
    <<doco
Usage: #{ script_name } validate adf-sample.xml

  Options:
    -d, --dtd         Validates using DTD *
    -a, --altdtd      Validates using alternate DTD *
    -x, --xsd         Validates using XSD *
    -o, --objects     Validates using this library's objects
                      
                      * requires xmllint
  Summary:
    Validates an ADF formatted file
doco
  end
  def validate *args
    options = { :dtd => false, :altdtd => false, :xsd => false, :objects => false }
    opts = OptionParser.new do |opts|
      opts.on('-d','--dtd')     { options[:dtd]     = true }
      opts.on('-a','--altdtd')  { options[:altdtd]  = true }
      opts.on('-x','--xsd')     { options[:xsd]     = true }
      opts.on('-o','--objects') { options[:objects] = true }
    end
    opts.parse! args
    file = args.last

    unless file and File.file? file
      puts 'You must pass in a file to validate'
      exit
    end
    unless options[:dtd] or options[:altdtd] or options[:xsd] or options[:objects]
      puts "Validation type not selected, defaulting to --dtd\n\n"
      options[:dtd] = true
    end

    validate_dtd :dtd => resource('ADF-1.0.dtd'), :file => file if options[:dtd]
    validate_dtd :dtd => resource('ADF-1.0.improved.dtd'), :file => file if options[:altdtd]
    puts `xmllint --schema '#{ File.dirname(__FILE__)   + '/../../resources/ADF-1.0.xsd' }' #{ file }` if options[:xsd]
    puts '--objects validation not yet supported' if options[:objects]
  end

end
