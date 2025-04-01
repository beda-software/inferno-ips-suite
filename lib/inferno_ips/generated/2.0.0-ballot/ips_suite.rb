# frozen_string_literal: true

require_relative 'summary_operation_group/ips_summary_operation_group'

require_relative 'entries_group/ips_entries_group'

require_relative 'docref_operation_group/ips_docref_group'

module IPSTestKit
  class Suite < Inferno::TestSuite
    id :ips_suite
    title 'IPS Inferno'
    description 'IPS Inferno consist of $summary tests, $summary entries tests and $docref tests'

    input :url,
          title: 'FHIR Server Base Url'

    input :credentials,
          title: 'OAuth Credentials',
          type: :oauth_credentials,
          optional: true

    fhir_client do
      url :url
      oauth_credentials :credentials
    end

    fhir_resource_validator do
      igs 'hl7.fhir.uv.ips#2.0.0-ballot'
    end

    group from: :ips_summary_operation

    group from: :ips_entries

    group from: :ips_docref_operation_group
  end
end
