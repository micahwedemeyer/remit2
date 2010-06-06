require File.dirname(__FILE__) + '/units_helper'

describe 'an IPN request' do
  before(:each) do
    @request_params = {
      "statusMessage"=>"The transaction was successful and the payment instrument was charged.",
      "buyerName"=>"Some Buyer",
      "paymentReason"=>"My Reason",
      "callerReference"=>"asdf1234",
      "transactionDate"=>"1275778668",
      "transactionAmount"=>"USD 4.00",
      "signature"=>"iQDcQv0lnyFet2shDSVtk8VZB7c=",
      "recipientName"=>"John Doe",
      "transactionId"=>"13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO",
      "recipientEmail"=>"me@example.com",
      "notificationType"=>"TransactionStatus",
      "transactionStatus"=>"SUCCESS",
      "operation"=>"PAY", 
      "paymentMethod"=>"CC",
      "statusCode"=>"Success"
    }

    @request = Remit::IpnRequest.new(@request_params, 'THISISMYTESTKEY')
  end

  it 'should be a valid request' do
    @request.should be_valid
  end

  it 'should pass through access to given parameters' do
    @request.transactionStatus.should == 'SUCCESS'
    @request.operation.should == 'PAY'
    @request.transactionId.should == '13KIGL9RC25853BGPPOS2VSKBKF2JERR3HO'
  end
end
