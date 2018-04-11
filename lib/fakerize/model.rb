class Fakerize::Model
  attr_reader :model, :config

  def initialize(model, config = {})
    @model = model
    @config = Fakerize::Configuration.new default_config.merge(config)
  end

  def perform
    config.attributes.each do |attribute|
      # Example: user.first_name=
      model.send "#{attribute}=", config.send(attribute).call
    end

    # Example: :remove_profile_image!
    before_save_methods.each { |method| model.send(method) }

    model.save!
  end

  private

  def before_save_methods
    []
  end

  def default_config
    {}
  end
end
