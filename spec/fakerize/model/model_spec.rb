class Company
  attr_accessor :name

  def initialize(name:)
    @name = name
  end

  def remove_logo! ; end
  def save! ; end
end

class Fakerize::Company < Fakerize::Model
  private

  def default_config
    { name: ->() { Faker::Company.name } }
  end

  def before_save_methods
    [:remove_logo!]
  end
end

RSpec.describe Fakerize::Model do
  let(:company_name) { Faker::Company.name }
  let(:company) { Company.new(name: company_name) }

  describe "#new" do
    it "assigns @model" do
      fakerize_model = Fakerize::Company.new(company)
      expect(fakerize_model.model).to eq(company)
    end

    it "assigns Faker::Configuration" do
      fakerize_model = Fakerize::Company.new(company)
      expect(fakerize_model.config).to be_instance_of(Fakerize::Configuration)
    end
  end

  describe "#perform" do
    it "assigns new Company name" do
      fakerize_model = Fakerize::Company.new(company)

      expect(company.name).to eq(company_name)
      expect(fakerize_model.model.name).to eq(company_name)

      fakerize_model.perform

      expect(fakerize_model.model.name).to_not eq(company_name)
    end

    it "calls before_save methods on model" do
      fakerize_model = Fakerize::Company.new(company)

      expect(fakerize_model.model).to receive(:remove_logo!)
      fakerize_model.perform
    end

    it "calls save! on model" do
      fakerize_model = Fakerize::Company.new(company)

      expect(fakerize_model.model).to receive(:save!)
      fakerize_model.perform
    end
  end
end
