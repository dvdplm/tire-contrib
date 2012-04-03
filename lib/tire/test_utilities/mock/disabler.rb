module Tire
  module Disabler
    module ClassMethods
      MOCK_ES_RESPONSE_DOC = '{"took": 1,"timed_out": false,"_shards": {"total": 5,"successful": 5,"failed": 0},"hits": {"total": 0,"max_score": null,"hits": []}}'

      def enable! &blk
        old_enabled = @tire_enabled || false
        @tire_enabled = true
        WebMock.disable!
        if block_given?
          begin
            yield
          ensure
            @tire_enabled = old_enabled
            if not @tire_enabled
              self.disable!
            end
          end
        end
      end

      def disable!
        WebMock.enable! && WebMock.reset!
        WebMock
          .stub_request(:any, %r|#{Tire::Configuration.url}.*|)
          .to_return(status: 200, body: MOCK_ES_RESPONSE_DOC, headers: {})
      end
    end
  end
  extend Disabler::ClassMethods
end