# frozen_string_literal: true

module IPSTestKit
  class CareplanEntryTest < Inferno::Test
    title 'Server returns CarePlan resource that matches the CarePlan profile'
    description %(
      This test will validate that the CarePlan resource returned from the server matches the CarePlan profile.
    )
    id :ips_careplan_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'CarePlan'
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'CarePlan' && r.meta&.profile&.include?('')
      end

      skip_if existing_resources.empty?, "No existing resources of type 'CarePlan' with profile '' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r)
      end
    end
  end
end
