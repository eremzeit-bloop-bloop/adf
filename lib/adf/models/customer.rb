class ADF::Customer
  unless_activerecord do
    include Validatable

    attr_accessor :contact

    def initialize options = {}
      options.each { |k,v| instance_variable_set "@#{k}", v }
    end
  end

  def to_adf prospect
    prospect.customer do |customer|
      contact.to_adf customer
    end 
  end

  def self.from_adf doc
    ADF::Customer.new :contact => ADF::Contact.from_adf( doc / :contact )
  end
end
