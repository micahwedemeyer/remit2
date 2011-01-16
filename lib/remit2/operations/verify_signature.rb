# Updated for API Version 2008-09-17
module Remit
  module VerifySignature
    class Request < Remit::Request
      action :VerifySignature
      parameter :url_end_point, :required => true
      parameter :http_parameters, :require => true
    end
    
    class InnerResponse < Remit::BaseResponse
      parameter :verification_status
    end
    
    class Response < Remit::Response
      parameter :inner, :element => "VerifySignatureResult", :type => InnerResponse
      inner_parameters :verification_status
    end

    def verify_signature(request = Request.new)
      call(request, Response)
    end
  end
end
