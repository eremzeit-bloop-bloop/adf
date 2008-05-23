require File.dirname(__FILE__) + '/../lib/adf'

def read_sample sample
  sample.sub! /\.adf\.xml$/i, ''
  File.read( File.dirname(__FILE__) + File.join('/samples/',sample) + '.adf.xml' )
end

# Valid Attributes for Models
def valid_adf_contact_attributes
  { :name => 'John Doe', :email => 'john@doe.com' }
end

# lets you define valid attributes for any class by creating a method here called 
# valid_[class_name]_attributes which returns a hash of attributes
#
# Usage:
#   ADF::Contact.new_valid
#   ADF::Contact.create_valid
#   ADF::Contact.new_valid :name => 'Override Value'
#   ADF::Contact.new_valid :dependencies => [:Prospect]
#
module ValidAttributes
  def self.included base
    base.extend self
  end 

  def valid_attributes options = {}
    self.send( "valid_#{ self.name.gsub('::','_').underscore }_attributes" ).merge options
  end 

  def new_valid options = {}
    create_dependencies options.delete(:dependencies)
    new valid_attributes.merge(options) 
  end   

  def create_valid options = {}
    create_dependencies options.delete(:dependencies)
    create valid_attributes.merge(options)
  end

  def create_dependencies dependencies = []
    unless dependencies.nil? or dependencies.empty?
      dependencies.each do |model_name|
        model_class = model_name.to_s.camelcase.constantize
        model_class.create_valid unless model_class.count > 0
      end
    end
  end
end

Object.class_eval do
  include ValidAttributes
end
