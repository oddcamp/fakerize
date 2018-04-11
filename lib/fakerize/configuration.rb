class Fakerize::Configuration
  attr_reader :config, :attributes

  # @param Hash
  #
  # @example
  # config = {
  #   email: ->() { Faker::Internet.email },
  #   first_name: ->() { Faker::Name.first_name },
  #   last_name: ->() { Faker::Name.last_name }
  # }
  def initialize(config)
    @config = config
    @attributes = config.keys

    attributes.each do |attribute|
      define_singleton_method attribute do
        config[attribute]
      end
    end
  end
end
