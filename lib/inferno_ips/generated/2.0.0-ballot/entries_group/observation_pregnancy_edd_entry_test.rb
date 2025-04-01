# frozen_string_literal: true

module IPSTestKit
  class ObservationPregnancyEddEntryTest < Inferno::Test
    title 'Server returns Observation - Pregnancy: EDD resource that matches the Observation - Pregnancy: EDD profile'
    description %(
      This test will validate that the Observation - Pregnancy: EDD resource returned from the server matches the Observation - Pregnancy: EDD profile.
    )
    id :ips_observation_pregnancy_edd_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Observation' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-edd-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Observation' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-edd-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Observation' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-edd-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-pregnancy-edd-uv-ips')
      end
    end
  end
end
