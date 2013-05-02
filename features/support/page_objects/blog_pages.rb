class PostSection < SitePrism::Section
  element :title, "header h3 a"
  element :comment_link, ".comments a"
end

class TrainingTipsPage < SitePrism::Page
  set_url '/blogs{/blog_id}'
  set_url_matcher %r(/blogs/\d+)

  element :new_post_link, "a[href='#{Rails.application.routes.url_helpers.new_post_path}']"

  sections :posts, PostSection, "article.post"

  def load(*args)
    if args.any?
      super(*args)
    else
      super(:blog_id => Blog.last.try(:id))
    end
  end
end

class PostPage < SitePrism::Page
  set_url "/posts{/post_id}"
  set_url_matcher %r(/posts/\d+)

  element :title, "article header h3 a"
  element :contributor, "span.credit"
  element :comment_field, "textarea[name='comment[body]']"
  element :post_comment_btn, "input[name='commit']"
end

class NewPostPage < SitePrism::Page
  include ::CommonPageBehavior
  init_url_and_matcher(Rails.application.routes.url_helpers.new_post_path)

  element :title_field, 'input[name="post[title]"]'
  element :url_field, 'input[name="post[url]"]'
  element :description_field, 'textarea[name="post[description]"]'
  element :create_post_btn, 'input[name="commit"]'

  def create_new_post
    fill_out_form
    submit_form
  end

  private

  def fill_out_form
    title_field.set "Some Great Article"
    url_field.set "http://www.example.com"
    description_field.set "This is a really great article."
  end

  def submit_form
    create_post_btn.click
  end
end

