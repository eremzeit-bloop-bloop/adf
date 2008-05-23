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
    
    xml.instruct! :ADF, :VERSION => '1.0'
    #xml.instruct! :XML, :VERSION => '1.0' 

    # right now i'm doing the WHOLE THING here, but we'll simplify this and just call vehicle.to_adf, customer.to_adf, etc etc
    xml.adf do |adf|
      adf.prospect do |prospect|

        prospect.requestdate "#{ requestdate.iso_8601 }"

        prospect.vehicle do |vehicle|
          vehicle.year self.vehicle.year
          vehicle.make self.vehicle.make
          vehicle.model self.vehicle.model
        end 

        prospect.customer do |customer|
          customer.contact do |contact|
            contact.name self.customer.contact.name.to_s, :part => 'full'
            contact.phone self.customer.contact.phone.to_s
          end 
        end 

        prospect.vendor do |vendor|
          vendor.contact do |contact|
            contact.name self.vendor.contact.name.to_s, :part => 'full'
          end 
        end 

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
