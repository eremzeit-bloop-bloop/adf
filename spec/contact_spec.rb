require File.dirname(__FILE__) + '/spec_helper'

describe ADF::Contact  do

  it '#new_valid should be valid' do
    ADF::Contact.new_valid.should be_valid
  end

  it 'should require a name' do
    ADF::Contact.new_valid(:name => nil).should_not be_valid
  end

  it 'should require an email OR a phone'

end
