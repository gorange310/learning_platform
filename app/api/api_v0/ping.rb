module ApiV0
  class Ping < Grape::API
    desc 'Ping pong'
    get "/ping" do
      # "pong"
      authenticate!
    end
  end
end
