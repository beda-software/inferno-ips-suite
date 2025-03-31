# frozen_string_literal: true

module IPSTestKit
  class ObservationPregnancyOutcomeEntryTest < Inferno::Test
    title 'Server returns Observation - Pregnancy: outcome resource that matches the Observation - Pregnancy: outcome profile'
    description %(
      This test will validate that the Observation - Pregnancy: outcome resource returned from the server matches the Observation - Pregnancy: outcome profile.
    )
    id :ips_observation_pregnancy_outcome_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Observation' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-outcome-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Observation' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-outcome-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-outcome-uv-ips')
      end
    end
  end
end
