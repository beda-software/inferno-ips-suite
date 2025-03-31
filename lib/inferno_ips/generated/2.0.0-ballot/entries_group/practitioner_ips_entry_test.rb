# frozen_string_literal: true

module IPSTestKit
  class PractitionerIpsEntryTest < Inferno::Test
    title 'Server returns Practitioner (IPS) resource that matches the Practitioner (IPS) profile'
    description %(
      This test will validate that the Practitioner (IPS) resource returned from the server matches the Practitioner (IPS) profile.
    )
    id :ips_practitioner_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Practitioner' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Practitioner-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Practitioner' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Practitioner-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Practitioner-uv-ips')
      end
    end
  end
end
