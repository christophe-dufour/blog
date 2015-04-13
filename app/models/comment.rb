##
# Comment in this app are handled by disqus (https://disqus.com/)
# For SEO reason, we want to embed some comment in <noscript> tag. So we will keep it here.
#
class Comment
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :post, inverse_of: :comments

  field :body, type: String

  validates_presence_of :body, :post
end