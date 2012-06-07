# == Schema Information
#
# Table name: comments
#
#  id         :integer         not null, primary key
#  post_id    :integer
#  user_id    :integer
#  body       :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
# Indexes
#
#  index_comments_on_post_id  (post_id)
#  index_comments_on_user_id  (user_id)
#

describe Comment do
  it "should not reek" do
    get_source_file(__FILE__).should_not reek
  end

  it { should belong_to(:post) }
  it { should belong_to(:user) }

end
