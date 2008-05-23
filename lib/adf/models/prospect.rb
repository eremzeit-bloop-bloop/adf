class ADF::Prospect < ADF::Base
  attr_accessor :requestdate

  def initialize options = {}
    options.each { |k,v| instance_variable_set "@#{k}", v }
  end

  def self.from_adf adf
    doc = ( Hpricot.XML( adf ) / :adf / :prospect )
    ADF::Prospect.new :requestdate => DateTime.parse( ( doc / :requestdate ).inner_html )
  end
end
