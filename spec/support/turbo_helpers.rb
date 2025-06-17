# Helper methods for testing Turbo Stream responses
module TurboHelpers
  def turbo_stream_headers
    { 
      "Accept" => "text/vnd.turbo-stream.html",
      "Turbo-Frame" => "_top"
    }
  end
  
  def expect_turbo_stream_response
    expect(response.content_type).to include("text/vnd.turbo-stream.html")
  end
  
  def turbo_stream_actions
    Nokogiri::HTML(response.body).css("turbo-stream").map { |node| node["action"] }
  end
end

RSpec.configure do |config|
  config.include TurboHelpers, type: :request
  config.include TurboHelpers, type: :controller
end