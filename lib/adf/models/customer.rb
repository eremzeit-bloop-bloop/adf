class ADF::Customer

  unless_activerecord do
    include NonActiveRecordModel
    attr_accessor :contact
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
