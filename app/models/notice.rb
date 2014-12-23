class Notice

  include Mongoid::Document
  include Mongoid::Timestamps

  
  belongs_to :user
  belongs_to :topic

  validates :user, :topic, :presence => true


  default_scope -> { order('id asc') }



  module UserMethods
    def self.included(base)
      base.has_many :notices
    end
  end


  include NoticeComment::NoticeMethods



end