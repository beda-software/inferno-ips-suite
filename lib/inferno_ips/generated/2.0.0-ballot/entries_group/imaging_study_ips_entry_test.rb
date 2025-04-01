# frozen_string_literal: true

module IPSTestKit
  class ImagingStudyIpsEntryTest < Inferno::Test
    title 'Server returns Imaging Study (IPS) resource that matches the Imaging Study (IPS) profile'
    description %(
      This test will validate that the Imaging Study (IPS) resource returned from the server matches the Imaging Study (IPS) profile.
    )
    id :ips_imaging_study_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'ImagingStudy' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/ImagingStudy-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'ImagingStudy' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/ImagingStudy-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'ImagingStudy' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/ImagingStudy-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/ImagingStudy-uv-ips')
      end
    end
  end
end
