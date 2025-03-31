# frozen_string_literal: true

module IPSTestKit
  class ObservationShAlcoholUseEntryTest < Inferno::Test
    title 'Server returns Observation - SH: alcohol use resource that matches the Observation - SH: alcohol use profile'
    description %(
      This test will validate that the Observation - SH: alcohol use resource returned from the server matches the Observation - SH: alcohol use profile.
    )
    id :ips_observation_sh_alcohol_use_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource
      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'Observation' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-alcoholuse-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'Observation' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-alcoholuse-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Observation-alcoholuse-uv-ips')
      end
    end
  end
end
