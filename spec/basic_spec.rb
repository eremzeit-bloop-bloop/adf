require File.dirname(__FILE__) + '/spec_helper'

[ :parse, :build ].each do |method|

  describe ADF, "#{ method } basic sample"  do

    before do
      @sample = read_sample 'valid/basic'
      @result = ADF.parse @sample
      @result = ADF.parse( @result.to_adf ) if method == :build
    end

    # this is a test, testing my continuous integration system ...
    it 'should fail' do
      1.should == 2
    end

    it 'should be a prospect' do
      @result.should be_a_kind_of(ADF::Prospect)
    end

    it 'should have a requestdate' do
      @result.requestdate.year.should == 2000
      @result.requestdate.to_s.should == '2000-03-30T15:30:20-08:00'
    end

    it 'should have a vehicle' do
      @result.vehicle.should be_a_kind_of(ADF::Vehicle)
      @result.vehicle.year.should == 1999
      @result.vehicle.make.should == 'Chevrolet'
      @result.vehicle.model.should == 'Blazer'
    end

    it 'should have a customer' do
      @result.customer.should be_a_kind_of(ADF::Customer)
      @result.customer.contact.should be_a_kind_of(ADF::Contact)
      @result.customer.contact.name.to_s.should == 'John Doe'
      @result.customer.contact.phone.to_s.should == '393-999-3922'
    end

    it 'should have a vendor' do
      @result.vendor.should be_a_kind_of(ADF::Vendor)
      @result.vendor.contact.should be_a_kind_of(ADF::Contact)
      @result.vendor.contact.name.to_s.should == 'Acura of Bellevue'
    end

  end

end
