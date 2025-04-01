# frozen_string_literal: true

module IPSTestKit
  class ImmunizationIpsEntryTest < Inferno::Test
    title 'Server returns Immunization (IPS) resource that matches the Immunization (IPS) profile'
    description %(
      This test will validate that the Immunization (IPS) resource returned from the server matches the Immunization (IPS) profile.
    )
    id :ips_immunization_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Immunization' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Immunization-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Immunization' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Immunization-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Immunization' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Immunization-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Immunization-uv-ips')
      end
    end
  end
end
