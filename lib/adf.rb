$:.unshift File.dirname(__FILE__)

require 'date'
require 'rubygems'
require 'active_support'
require 'validatable' # for non-AR class validations

class ADF

  # ADF 'models' and 'object' currently inherit from this ...
  class Base
    include Validatable
  end

  # get an ADF::Lead from an ADF formatted XML string
  def self.parse adf
    ADF::Lead.new 
  end

  # loads all ADF objects as ActiveRecord models
  def self.load_models
    raise "NOT CURRENTLY SUPPORTED ... will get to it when i get to it ..."
  end

  # loads all ADF objects as normal classes with AR validations
  def self.load_objects
    model_files.each { |model| require model }
  end

  # undefines model or constant classes
  def self.undefine
    model_names.each { |name| ADF.send :remove_const, name.to_sym }
  end

  # private

  def self.model_names
    model_files.map {|file| File.basename(file).sub(/\..*/,'').capitalize }
  end

  def self.model_files
    Dir[ File.join(File.dirname(__FILE__), 'adf', 'models', '*.rb') ]
  end

end

# for auto-loading models (for now ...)
ADF.load_objects
