module Maxipago
  class Client
    APIVERSION = "3.1.1.15"

    attr_reader :response, :request

    def use(request)
      @request = request
    end

    def execute(opts = {})
      raise "Sets the api type before execute commands." if request.nil?
      raise ArgumentError, "Execute method needs options" if opts.empty?

      @response = request.send_command(opts)
    end
  end
end
