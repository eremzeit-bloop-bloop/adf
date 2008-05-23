class ADF::Prospect
  unless_activerecord do
    include Validatable

    attr_accessor :requestdate, :vehicle, :customer, :vendor

    def initialize options = {}
      options.each { |k,v| instance_variable_set "@#{k}", v }
    end
  end

  def to_adf
    xml = Builder::XmlMarkup.new :indent => 4
    xml.instruct! :ADF, :VERSION => '1.0'  #xml.instruct! :XML, :VERSION => '1.0' 

    xml.adf do |adf|
      adf.prospect do |prospect|
        prospect.requestdate "#{ requestdate.iso_8601 }"
        vehicle.to_adf  prospect
        customer.to_adf prospect
        vendor.to_adf   prospect
      end
    end
  end

  def self.from_adf adf
    doc = ( Hpricot.XML( adf ) / :adf / :prospect )
    ADF::Prospect.new :requestdate  => DateTime.parse( ( doc / :requestdate ).inner_html ),
                      :vehicle      => ADF::Vehicle.from_adf(   doc / :vehicle  ),
                      :customer     => ADF::Customer.from_adf(  doc / :customer ),
                      :vendor       => ADF::Vendor.from_adf(    doc / :vendor   )
  end
end
