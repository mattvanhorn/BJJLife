Then /^I should see (\d+) ([\w]+) slides in the carousel$/ do |num, model|
  page.should have_selector("#carousel .#{model}", :count => num.to_i)
end

Then /^(?:I|they) (should|should not) see that ([\w]+)$/ do |should_or_not, model|
  instance = instance_variable_get(:"@#{model}")
  case instance
  when Product
    page.send(should_or_not, have_content(instance.name))
  else
    raise 'unsupported model'
  end
end
