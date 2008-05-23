require File.dirname(__FILE__) + '/spec_helper'

describe 'ADF.parse( basic sample )' do

  before do
    @sample = read_sample 'valid/basic'
    @result = ADF.parse @sample
  end

  it 'should have a prospect' do
    @result.prospect.should be_a_kind_of(ADF::Prospect)
  end

  it 'should have a prospect with requestdate' do
    @result.prospect.requestdate.year.should == 2000
    @result.prospect.requestdate.to_s.should == '2000-03-30T15:30:20-08:00'
  end

  it 'should have a prospect with vehicle'
  it 'should have a prospect with customer'
  it 'should have a prospect with vendor'

end
