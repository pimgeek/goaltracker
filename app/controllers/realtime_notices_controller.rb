class RealtimeNoticesController < FayeRails::Controller
  channel '/topics' do
    subscribe do
      
      Rails.logger.debug "Received on #{channel}: #{inspect}"

      'ddd'


      # ChatMessage.create(message: message['message'], created_at: created_at)


    end


  end
end
