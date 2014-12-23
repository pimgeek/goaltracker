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

      base.send :include, InstanceMethods
    end

    module InstanceMethods

      def was_noticed?(topic)
        Notice.where(user_id: self.id, topic_id: topic.id).exists?
      end

      def get_notice(topic)
        return nil unless was_noticed?(topic)
        Notice.where(user_id: self.id, topic_id: topic.id).first
      end
    end

    
  end


  include NoticeComment::NoticeMethods



end