# frozen_string_literal: true

module IPSTestKit
  class PractitionerroleIpsEntryTest < Inferno::Test
    title 'Server returns PractitionerRole (IPS) resource that matches the PractitionerRole (IPS) profile'
    description %(
      This test will validate that the PractitionerRole (IPS) resource returned from the server matches the PractitionerRole (IPS) profile.
    )
    id :ips_practitionerrole_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'PractitionerRole' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/PractitionerRole-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'PractitionerRole' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/PractitionerRole-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/PractitionerRole-uv-ips')
      end
    end
  end
end
