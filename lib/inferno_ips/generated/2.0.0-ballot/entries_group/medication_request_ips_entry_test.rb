# frozen_string_literal: true

module IPSTestKit
  class MedicationRequestIpsEntryTest < Inferno::Test
    title 'Server returns Medication Request (IPS) resource that matches the Medication Request (IPS) profile'
    description %(
      This test will validate that the Medication Request (IPS) resource returned from the server matches the Medication Request (IPS) profile.
    )
    id :ips_medication_request_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'MedicationRequest' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationRequest-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'MedicationRequest' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationRequest-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationRequest-uv-ips')
      end
    end
  end
end
