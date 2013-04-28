module Admin
  class VideosPage < SitePrism::Page
    include CommonPageBehavior
    include IndexPageBehavior
    init_url_and_matcher(Rails.application.routes.url_helpers.admin_videos_path)
  end

  class NewVideoPage < SitePrism::Page
    URL = Rails.application.routes.url_helpers.new_admin_video_path
    set_url URL
    set_url_matcher %r(#{URL})

    element :name_field, "input[name='video[name]']"
    element :url_field, "input[name='video[url]']"
    element :create_btn, "input[name='commit']"

    def add_a_video
      add_youtube_video
    end

    def add_youtube_video
      name_field.set "Mitsuyo Maeda: The Origin of BJJ"
      url_field.set "m0fH_8kv7ac"
      create_btn.click
    end

    def add_vimeo_video
      name_field.set "BJJ European Championships 2011"
      url_field.set "http://vimeo.com/19850565"
      create_btn.click
    end
  end
end

class NewVideoPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.new_video_path
  set_url URL
  set_url_matcher %r(#{URL})

  element :name_field, "input[name='video[name]']"
  element :url_field, "input[name='video[url]']"
  element :create_btn, "input[name='commit']"

  def add_a_video
    load
    name_field.set "Mitsuyo Maeda: The Origin of BJJ"
    url_field.set "m0fH_8kv7ac"
    create_btn.click
  end


end

class VideosPage < SitePrism::Page
  URL = Rails.application.routes.url_helpers.videos_path
  set_url URL
  set_url_matcher %r(#{URL})

  elements :videos, "li.video"

  def has_video?(video)
    videos.detect{|v|
      v.has_selector?("a[href='#{video.url}']") &&
      v.has_selector?(".video-name[text()='#{video.name}']")
    }.present?
  end

  def like(name)
    vote(name, :up)
  end
  def hate(name)
    vote(name, :down)
  end

  def vote(name, up_or_down)
    videos.detect{ |v| v.has_selector?(".video-name[text()='#{name}']") }.find(".icon-thumbs-#{up_or_down}").click()
  end
end

