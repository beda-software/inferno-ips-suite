# frozen_string_literal: true

module IPSTestKit
  class DiagnosticreportIpsEntryTest < Inferno::Test
    title 'Server returns DiagnosticReport (IPS) resource that matches the DiagnosticReport (IPS) profile'
    description %(
      This test will validate that the DiagnosticReport (IPS) resource returned from the server matches the DiagnosticReport (IPS) profile.
    )
    id :ips_diagnosticreport_ips_entry_test

    optional

    uses_request :summary_operation

    run do
      initial_bundle = resource

      initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'DiagnosticReport' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/DiagnosticReport-uv-ips')
      end

      existing_resources = initial_bundle.entry.map(&:resource).select do |r|
        r.resourceType == 'DiagnosticReport' && r.meta&.profile&.include?('http://hl7.org/fhir/uv/ips/StructureDefinition/DiagnosticReport-uv-ips')
      end

      skip_if existing_resources.empty?,
              "No existing resources of type 'DiagnosticReport' with profile 'http://hl7.org/fhir/uv/ips/StructureDefinition/DiagnosticReport-uv-ips' found."

      existing_resources.each do |r|
        assert_valid_resource(resource: r, profile_url: 'http://hl7.org/fhir/uv/ips/StructureDefinition/DiagnosticReport-uv-ips')
      end
    end
  end
end
