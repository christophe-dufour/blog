class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Search
  include Mongoid::Slug

  embeds_many :comments

  field :title, type: String
  field :body, type: String
  field :published_at, type: DateTime
  field :tags, type: Array
  field :meta, type: Hash
  field :preview_url, type: String

  validates_presence_of :title

  validates_presence_of :body, :preview_url, if: :published_at

  index({title: 1}, {unique: true})

  index({published_at: -1})

  default_scope -> { where(:published_at.ne => nil).order(published_at: :desc) }
  slug :title, :history => true

  search_in :title, :tags
end
