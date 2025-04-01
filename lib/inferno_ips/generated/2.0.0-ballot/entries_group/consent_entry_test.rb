# frozen_string_literal: true

module IPSTestKit
  class ConsentEntryTest < Inferno::Test
    title 'Server returns Consent resource that matches the Consent profile'
    description %(
      This test will validate that the Consent resource returned from the server matches the Consent profile.
    )
    id :ips_consent_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Consent'
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Consent' && r.meta&.profile&.include?('')
      end

      skip_if existing_resources.empty?, "No existing resources of type 'Consent' with profile '' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r)
      end
    end
  end
end
