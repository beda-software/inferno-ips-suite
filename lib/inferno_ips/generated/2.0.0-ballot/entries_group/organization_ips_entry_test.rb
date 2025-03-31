# frozen_string_literal: true

module IPSTestKit
  class OrganizationIpsEntryTest < Inferno::Test
    title 'Server returns Organization (IPS) resource that matches the Organization (IPS) profile'
    description %(
      This test will validate that the Organization (IPS) resource returned from the server matches the Organization (IPS) profile.
    )
    id :ips_organization_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Organization' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Organization-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Organization' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Organization-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Organization-uv-ips')
      end
    end
  end
end
