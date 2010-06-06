require File.dirname(__FILE__) + '/units_helper'

describe "the Remit API" do
  describe "a request" do
    before(:each) do
      @api = Remit::API.new(ACCESS_KEY, SECRET_KEY, true)
      
      # Generate a sample request
      @request = Remit::Pay::Request.new(
        :caller_reference => "ref",
        :sender_token_id => "sender-token",
        :transaction_amount => Remit::RequestTypes::Amount.new(:currency_code => "US", :value => "10")
      )
    end
    
    it "should calculate correct string to sign" do
      signature = /GET\nfps.sandbox.amazonaws.com\n\/\nAWSAccessKeyId=foo&Action=Pay&CallerReference=ref&SenderTokenId=sender-token&SignatureMethod=HmacSHA256&SignatureVersion=2&Timestamp=(.*)&TransactionAmount.CurrencyCode=US&TransactionAmount.Value=10&Version=2008-09-17/
      
      q = @api.query(@request)
      s = @api.string_to_sign("https://fps.sandbox.amazonaws.com/", "GET", q)
      s.to_s.should =~ signature
    end
    
  end
end
