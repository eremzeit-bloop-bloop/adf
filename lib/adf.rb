$:.unshift File.dirname(__FILE__)

require 'date'
require 'rubygems'
require 'hpricot'
require 'active_support'
require 'validatable' # for non-AR class validations

# little extension for our model classes so we can do some stuff 
# _only_ when our classes are NOT activerecord classes
class Object
  class << self
    def unless_activerecord &block
      block.call unless defined?ActiveRecord and self.superclass == ActiveRecord::Base
    end
  end
end

# ADF is a utility class and the namespace for all of the model classes
class ADF

  # get an ADF::Prospect from an ADF formatted XML string
  def self.parse adf
    ADF::Prospect.from_adf adf
  end

  # loads all ADF objects as ActiveRecord models
  def self.load_models
    undefine
    require 'active_record' unless defined?ActiveRecord
    model_names.each { |name| eval "class ADF::#{name} < ActiveRecord::Base; end", TOPLEVEL_BINDING }
    load_objects
  end

  # loads all ADF objects as normal classes with AR validations
  def self.load_objects
    model_files.each { |model| require model }
  end

  # undefines model or constant classes
  def self.undefine
    model_names.each { |name| ADF.send :remove_const, name.to_sym }
  end

  private

  def self.model_names
    model_files.map {|file| File.basename(file).sub(/\..*/,'').capitalize }
  end

  def self.model_files
    Dir[ File.join(File.dirname(__FILE__), 'adf', 'models', '*.rb') ]
  end

end

# for auto-loading models ( by default ... for now ... )
ADF.load_objects
