module Index

  class PostSerializer < ActiveModel::Serializer
    attributes :id, :title, :published_at

    def id
      object.id.to_s
    end
  end
end