# frozen_string_literal: true

module IPSTestKit
  class AllergyIntoleranceIpsEntryTest < Inferno::Test
    title 'Server returns Allergy Intolerance (IPS) resource that matches the Allergy Intolerance (IPS) profile'
    description %(
      This test will validate that the Allergy Intolerance (IPS) resource returned from the server matches the Allergy Intolerance (IPS) profile.
    )
    id :ips_allergy_intolerance_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'AllergyIntolerance' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/AllergyIntolerance-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'AllergyIntolerance' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/AllergyIntolerance-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'AllergyIntolerance' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/AllergyIntolerance-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/AllergyIntolerance-uv-ips')
      end
    end
  end
end
