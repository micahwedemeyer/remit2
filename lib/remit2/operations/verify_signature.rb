require 'remit2/common'

# Updated for API Version 2008-09-17
module Remit
  module VerifySignature
    class Request < Remit::Request
      action :VerifySignature
      parameter :url_end_point, :required => true
      parameter :http_parameters, :require => true
    end

    class Response < Remit::Response
      paramter :verification_status
    end

    def verify_signature(request = Request.new)
      call(request, Response)
    end
  end
end
