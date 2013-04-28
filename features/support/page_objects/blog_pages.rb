class PostPage < SitePrism::Page
  set_url '/posts{?/post_id}'
  set_url_matcher %r(/posts/\d+)
end
