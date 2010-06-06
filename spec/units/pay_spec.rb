require File.dirname(__FILE__) + '/units_helper'

describe "the Pay API" do  
  describe "a successful response" do
    it_should_behave_like 'a successful response'

    before do
      doc = <<-XML
        <PayResponse xmlns="http://fps.amazonaws.com/doc/2008-09-17/">
          <PayResult>
            <TransactionId>154588GALWND3ML3EJ3NFDZ7SMQZHLMLJZP</TransactionId>
            <TransactionStatus>Pending</TransactionStatus>
          </PayResult>
          <ResponseMetadata>
            <RequestId>b5d6e665-6343-41db-bac7-17e251f353bf:0</RequestId>
          </ResponseMetadata>
        </PayResponse>
      XML

      @response = Remit::Pay::Response.new(doc)
    end

    it "has a transaction id" do
      @response.transaction_id.should == '154588GALWND3ML3EJ3NFDZ7SMQZHLMLJZP'
    end

    it "has a transaction status" do
      @response.transaction_status.should == 'Pending'
    end

    it "has inner shortcuts" do
      @response.inner.should_not be_nil
    end
  end

  describe "for a failed request" do
    describe "InvalidRequest" do
      it_should_behave_like 'a failed response'
      
      before do
        doc = <<-XML
          <?xml version="1.0"?>
          <Response>
            <Errors>
              <Error>
                <Code>InvalidRequest</Code>
                <Message>The request doesn't conform to the interface specification in the WSDL. Element/Parameter "http://fps.amazonaws.com/doc/2008-09-17/:TemporaryDeclinePolicy" in request is either invalid or is found at unexpected location</Message>
              </Error>
            </Errors>
            <RequestID>b643bbc6-d5cd-46b4-9c02-4203a52a9b49</RequestID>
          </Response>
        XML

        @response = Remit::Pay::Response.new(doc)
        @error = @response.errors.first
      end

      it "should have an error code of 'InvalidRequest'" do
        @error.code.should == 'InvalidRequest'
      end

      it "should have a message" do
        @error.message.should == "The request doesn't conform to the interface specification in the WSDL. Element/Parameter \"http://fps.amazonaws.com/doc/2008-09-17/:TemporaryDeclinePolicy\" in request is either invalid or is found at unexpected location"
      end
    end
  end
end
