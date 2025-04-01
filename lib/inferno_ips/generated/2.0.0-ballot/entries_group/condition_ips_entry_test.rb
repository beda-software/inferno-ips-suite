# frozen_string_literal: true

module IPSTestKit
  class ConditionIpsEntryTest < Inferno::Test
    title 'Server returns Condition (IPS) resource that matches the Condition (IPS) profile'
    description %(
      This test will validate that the Condition (IPS) resource returned from the server matches the Condition (IPS) profile.
    )
    id :ips_condition_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Condition' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Condition-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Condition' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Condition-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Condition' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Condition-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Condition-uv-ips')
      end
    end
  end
end
