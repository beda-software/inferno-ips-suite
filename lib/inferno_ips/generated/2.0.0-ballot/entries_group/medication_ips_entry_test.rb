# frozen_string_literal: true

module IPSTestKit
  class MedicationIpsEntryTest < Inferno::Test
    title 'Server returns Medication (IPS) resource that matches the Medication (IPS) profile'
    description %(
      This test will validate that the Medication (IPS) resource returned from the server matches the Medication (IPS) profile.
    )
    id :ips_medication_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Medication' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Medication-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Medication' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Medication-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Medication-uv-ips')
      end
    end
  end
end
