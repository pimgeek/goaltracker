class Topic

  include Mongoid::Document
  include Mongoid::Timestamps

  # field :talk_group_id,         type: Integer
  field :order,                 type: Integer, default: 0
  field :title,                 type: String
  field :title_tag,             type: String


  
  belongs_to :talk_group, :inverse_of => :parent_topic

  validates :title_tag, :presence => true


  default_scope -> { order('id asc') }
  scope :by_tag, ->(tag) { where(:title_tag => tag, :title.ne => '') }



end