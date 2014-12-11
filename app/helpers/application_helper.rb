module ApplicationHelper

  def root_url      
    request.protocol + request.host + request.port_string
  end

  def parse_tags
    file = Rails.root.join('config', 'share_tags.yaml')
    @tags = YAML::load_documents(File.open(file))
    @titles = @tags.map {|t| t.keys[0]}
  end

  
end
