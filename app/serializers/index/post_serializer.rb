module Index

  class PostSerializer < ActiveModel::Serializer
    attributes :id, :title

    def id
      object.id.to_s
    end
  end
end