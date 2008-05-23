class ADF::Vendor
  unless_activerecord do
    include NonActiveRecordModel
    attr_accessor :contact
  end

  def to_adf prospect
    prospect.vendor do |vendor|
      contact.to_adf vendor
    end 
  end

  def self.from_adf doc
    ADF::Vendor.new :contact => ADF::Contact.from_adf( doc / :contact )
  end
end
