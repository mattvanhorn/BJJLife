When "I create a new post" do
  Site.new_post_page.go.create_new_post
end

When "I add a comment to the first post" do
  Site.training_tips_page.posts.first.comment_link.click
  page = Site.post_page
  page.should be_displayed
  page.comment_field.set "yadda yadda"
  page.post_comment_btn.click
end

Then "I should see the post I created" do
  expected = Post.last
  page = Site.post_page.go(:post_id => expected.id)
  page.title.should have_text(expected.title)
  page.contributor.should have_text(@me.username)
end

Then "I should see all the posts" do
  Post.all.each do |post|
    item = @current_page.posts.detect{ |p| p.title.text == post.title }
    item.should be_present
    item.title[:href].should == post.url
    item.should have_text(post.description)
  end
end

Then /^I should be on the post page for that comment$/ do
  current_url.should == post_url(Comment.last.post)
end

Then "I should see that comment" do
  @current_page.should have_text(Comment.last.body)
end
