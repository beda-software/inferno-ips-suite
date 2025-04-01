# frozen_string_literal: true

module IPSTestKit
  class DeviceUseStatementIpsEntryTest < Inferno::Test
    title 'Server returns Device Use Statement (IPS) resource that matches the Device Use Statement (IPS) profile'
    description %(
      This test will validate that the Device Use Statement (IPS) resource returned from the server matches the Device Use Statement (IPS) profile.
    )
    id :ips_device_use_statement_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'DeviceUseStatement' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/DeviceUseStatement-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'DeviceUseStatement' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/DeviceUseStatement-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'DeviceUseStatement' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/DeviceUseStatement-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/DeviceUseStatement-uv-ips')
      end
    end
  end
end
