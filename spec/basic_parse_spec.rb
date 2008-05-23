require File.dirname(__FILE__) + '/spec_helper'

describe 'ADF.parse( basic sample )' do

  before do
    @sample = read_sample 'valid/basic'
    @result = ADF.parse @sample
  end

  it 'should be a prospect' do
    @result.should be_a_kind_of(ADF::Prospect)
  end

  it 'should have a requestdate' do
    @result.requestdate.year.should == 2000
    @result.requestdate.to_s.should == '2000-03-30T15:30:20-08:00'
  end

  it 'should have a vehicle'
  it 'should have a customer'
  it 'should have a vendor'

end
