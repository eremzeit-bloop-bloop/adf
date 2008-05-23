class ADF::Contact
  unless_activerecord do
    include Validatable

    attr_accessor :name, :phone

    def initialize options = {}
      options.each { |k,v| instance_variable_set "@#{k}", v }
    end
  end

  def to_adf node
    node.contact do |contact|
      contact.name  name.to_s, :part => 'full'
      contact.phone phone.to_s unless phone.to_s.empty?
    end 
  end

  def self.from_adf doc
    ADF::Contact.new  :name  => ( doc / :name  ).inner_html, 
                      :phone => ( doc / :phone ).inner_html
  end
end
