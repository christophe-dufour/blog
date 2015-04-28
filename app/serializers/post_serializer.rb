class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :published_at, :html_body

  include ApplicationHelper

  def id
    object.id.to_s
  end

  def html_body
    markdown.render object.body
  end
end
