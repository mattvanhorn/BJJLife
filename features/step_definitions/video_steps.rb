When /I add a video/ do
  @current_page.add_a_video
end

When /I add a youtube video/ do
  @current_page.add_youtube_video
end

When /I add a vimeo video/ do
  @current_page.add_vimeo_video
end

When /I delete the video named "(.*?)"/ do |title|
  Site.videos_admin_page.delete_video(title)
end

When /I (like|hate) the video "(.*?)"/ do |like_or_hate, name|
  @current_page.send(like_or_hate, name)
end

Then(/^I should see the video I added$/) do
  @current_page.videos.detect{|v|v.has_text? Video.last.name}.should be_present
end

Then /I should see all the videos/ do
  Video.all.each do |video|
    @current_page.should have_video(video)
  end
end
