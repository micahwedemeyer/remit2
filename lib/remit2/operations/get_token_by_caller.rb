# Updated for API Version 2008-09-17
module Remit
  module GetTokenByCaller
    class Request < Remit::Request
      action :GetTokenByCaller
      parameter :caller_reference
      parameter :token_id
    end
    
    class InnerResponse < Remit::BaseResponse
      parameter :token, :type => Token
    end
    
    class Response < Remit::Response
      parameter :inner, :element => "GetTokenByCallerResult", :type => InnerResponse
      inner_parameters :token
    end

    def get_token_by_caller(request = Request.new)
      call(request, Response)
    end
  end
end
