# frozen_string_literal: true

module IPSTestKit
  class MedicationStatementIpsEntryTest < Inferno::Test
    title 'Server returns Medication Statement (IPS) resource that matches the Medication Statement (IPS) profile'
    description %(
      This test will validate that the Medication Statement (IPS) resource returned from the server matches the Medication Statement (IPS) profile.
    )
    id :ips_medication_statement_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'MedicationStatement' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationStatement-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'MedicationStatement' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationStatement-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/MedicationStatement-uv-ips')
      end
    end
  end
end
