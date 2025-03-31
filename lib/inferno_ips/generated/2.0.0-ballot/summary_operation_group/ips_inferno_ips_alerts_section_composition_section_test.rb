# frozen_string_literal: true

module IPSTestKit
  class IPSInfernoIPSAlertsSectionCompositionSectionTest < Inferno::Test
    title 'Validate IPS Alerts Section'
    description 'This test verifies that the IPS Alerts Section within the Composition entry of a $summary Bundle is correctly structured. It extracts the references listed in the section, checks that the corresponding resources exist in the Bundle, and ensures they conform to the expected resource type and profile requirements.'
    id :ips_ips_alerts_section_composition_section_test

    optional

    uses_request :summary_operation

    run do
      composition_entry = resource.entry.find { |r| r.resource.resourceType == 'Composition' }
      skip_if !composition_entry, 'Composition entry does not exists'

      composition_resource = composition_entry.resource
      current_section = composition_resource.section.find { |s| s.code.coding.first.code == '104605-1' }
      skip_if !current_section, 'Section does not exists'
      skip_if !current_section.entry, 'Section entry does not exists'

      section_entries_refs = current_section.entry.map(&:reference)
      target_resources_and_profiles = 'Flag::http://hl7.org/fhir/uv/ips/StructureDefinition/Flag-alert-uv-ips'.split(';').map do |segment|
        resource, profiles = segment.split('::')
        {
          resource: resource,
          profiles: profiles&.split(',')&.reject(&:empty?) || []
        }
      end

      existing_resources = section_entries_refs.map { |ref| resource.entry.find { |e| e.fullUrl == ref } }.compact

      filtered_existing_resources = existing_resources.select do |er|
        target_resource = target_resources_and_profiles.find { |trp| trp[:resource] == er.resource.resourceType }
        target_resource && target_resource[:profiles].any? { |profile| er.resource.meta&.profile&.include?(profile) }
      end

      info section_entries_refs.to_s
      info target_resources_and_profiles.to_s
      info existing_resources.to_s
      info filtered_existing_resources.to_s

      assert section_entries_refs.length == filtered_existing_resources.length, 'TODO: Incorrect number of entries'
    end
  end
end
