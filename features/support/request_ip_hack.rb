module Rack
  class Request

    def ip_with_mocking
      test_ip = ENV['RAILS_TEST_IP_ADDRESS']

      if test_ip.present?
        return test_ip
      else
        return ip_without_mocking
      end
    end

    alias_method_chain :ip, :mocking

  end
end
