World(FabricationMethods)

Fabrication::Config.register_with_steps = true

def with_ivars(fabricator)
  @they = yield fabricator
  model = @they.last.class.to_s.underscore
  instance_variable_set("@#{model.pluralize}", @they)
  instance_variable_set("@#{model.singularize}", @they.last)
  Fabrication::Cucumber::Fabrications[model.singularize.gsub(/\W+/,'_').downcase] = @they.last
end

Given /^(\d+) ([^"]*)$/ do |count, model_name|
  with_ivars Fabrication::Cucumber::StepFabricator.new(model_name) do |fab|
    fab.n(count.to_i)
  end
end

Given /^the following ([^"]*):$/ do |model_name, table|
  with_ivars Fabrication::Cucumber::StepFabricator.new(model_name) do |fab|
    fab.from_table(table)
  end
end

Given /^that ([^"]*) has the following ([^"]*):$/ do |parent, child, table|
  with_ivars Fabrication::Cucumber::StepFabricator.new(child, :parent => parent) do |fab|
    fab.from_table(table)
  end
end

Given /^(?:that|those) (.*) belongs? to that (.*)$/ do |children, parent|
  with_ivars Fabrication::Cucumber::StepFabricator.new(parent) do |fab|
    fab.has_many(children)
  end
end

