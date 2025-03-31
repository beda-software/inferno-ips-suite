# frozen_string_literal: true

module IPSTestKit
  class PatientIpsEntryTest < Inferno::Test
    title 'Server returns Patient (IPS) resource that matches the Patient (IPS) profile'
    description %(
      This test will validate that the Patient (IPS) resource returned from the server matches the Patient (IPS) profile.
    )
    id :ips_patient_ips_entry_test

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Patient' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Patient' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Patient-uv-ips')
      end
    end
  end
end
