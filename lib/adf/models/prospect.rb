class ADF::Prospect
  unless_activerecord do
    include Validatable

    attr_accessor :requestdate, :vehicle, :customer, :vendor

    def initialize options = {}
      options.each { |k,v| instance_variable_set "@#{k}", v }
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
