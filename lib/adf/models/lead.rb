class ADF::Lead < ADF::Base
  attr_accessor_with_default :prospect, ADF::Prospect.new
end
