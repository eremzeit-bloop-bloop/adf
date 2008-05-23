class ADF::Vehicle
  unless_activerecord do
    include Validatable

    attr_accessor :year, :make, :model

    def initialize options = {}
      options.each { |k,v| instance_variable_set "@#{k}", v }
    end
  end

  def self.from_adf doc
    ADF::Vehicle.new  :year =>  ( doc / :year  ).inner_html.to_i, 
                      :make =>  ( doc / :make  ).inner_html,
                      :model => ( doc / :model ).inner_html
  end
end
