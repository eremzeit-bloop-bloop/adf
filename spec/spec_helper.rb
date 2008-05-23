require File.dirname(__FILE__) + '/../lib/adf'

def read_sample sample
  sample.sub! /\.adf\.xml$/i, ''
  File.read( File.dirname(__FILE__) + File.join('/samples/',sample) + '.adf.xml' )
end
