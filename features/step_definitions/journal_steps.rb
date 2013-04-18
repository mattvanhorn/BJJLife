Given(/^I have no journals$/) do
  @me.journals.should be_empty
end

When(/^I create a journal with the following info:$/) do |table|
  table.rows_hash.each do |name, val|
    fill_in I18n.t("activerecord.attributes.journal.#{name}"), :with => val
  end
  click_on("Create Journal")

end

Given(/^I have a journal$/) do
  pending # express the regexp above with the code you wish you had
end

When(/^I create an entry in my journal$/) do
  @me.make_journal_entry
end

Then(/^I should see the journal entry$/) do
  @me.should be_seeing_journal_entry
end
