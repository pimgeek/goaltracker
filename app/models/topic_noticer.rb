class TopicNoticer

  include Mongoid::Document
  include Mongoid::Timestamps

  
  belongs_to :user
  belongs_to :topic

  validates :user, :topic, :presence => true


  default_scope -> { order('id asc') }



  module UserMethods
    def self.included(base)
      base.has_many :notices, :class_name => 'TopicNoticer', :foreign_key => 'user_id'

      base.send :include, InstanceMethods
    end

    module InstanceMethods

      def was_noticed?(topic)
        TopicNoticer.where(user_id: self.id, topic_id: topic.id).exists?
      end

    end

    
  end



end