# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{remit2}
  s.version = "0.0.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Micah Wedemeyer", "Tyler Hunt"]
  s.date = %q{2010-06-06}
  s.email = %q{micah@peachshake.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    "lib/remit2.rb",
     "lib/remit2/data_types.rb",
     "lib/remit2/error_codes.rb",
     "lib/remit2/get_pipeline.rb",
     "lib/remit2/ipn_request.rb",
     "lib/remit2/operations/cancel_subscription_and_refund.rb",
     "lib/remit2/operations/cancel_token.rb",
     "lib/remit2/operations/discard_results.rb",
     "lib/remit2/operations/fund_prepaid.rb",
     "lib/remit2/operations/get_account_activity.rb",
     "lib/remit2/operations/get_account_balance.rb",
     "lib/remit2/operations/get_all_credit_instruments.rb",
     "lib/remit2/operations/get_all_prepaid_instruments.rb",
     "lib/remit2/operations/get_debt_balance.rb",
     "lib/remit2/operations/get_outstanding_debt_balance.rb",
     "lib/remit2/operations/get_payment_instruction.rb",
     "lib/remit2/operations/get_prepaid_balance.rb",
     "lib/remit2/operations/get_results.rb",
     "lib/remit2/operations/get_token_by_caller.rb",
     "lib/remit2/operations/get_token_usage.rb",
     "lib/remit2/operations/get_tokens.rb",
     "lib/remit2/operations/get_total_prepaid_liability.rb",
     "lib/remit2/operations/get_transaction.rb",
     "lib/remit2/operations/install_payment_instruction.rb",
     "lib/remit2/operations/pay.rb",
     "lib/remit2/operations/refund.rb",
     "lib/remit2/operations/reserve.rb",
     "lib/remit2/operations/retry_transaction.rb",
     "lib/remit2/operations/settle.rb",
     "lib/remit2/operations/settle_debt.rb",
     "lib/remit2/operations/write_off_debt.rb",
     "lib/remit2/pipeline_response.rb",
     "lib/remit2/request.rb",
     "lib/remit2/response.rb",
     "lib/remit2/signature.rb"
  ]
  s.homepage = %q{http://github.com/micahwedemeyer/remit2}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{remit2}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{An API for using the Amazon Flexible Payment Service (FPS) - updated for version 2008-09-17 of the API.}
  s.test_files = [
    "spec/units/cancel_subscription_and_refund_spec.rb",
     "spec/units/get_pipeline_spec.rb",
     "spec/units/ipn_request_spec.rb",
     "spec/units/pay_spec.rb",
     "spec/units/remit_spec.rb",
     "spec/spec_helper.rb",
     "spec/units/units_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<relax>, ["~> 0.0.7"])
    else
      s.add_dependency(%q<relax>, ["~> 0.0.7"])
    end
  else
    s.add_dependency(%q<relax>, ["~> 0.0.7"])
  end
end

