class ADF::Prospect < ADF::Base
  attr_accessor_with_default :requestdate, DateTime.parse('2000-03-30T15:30:20-08:00')
end
