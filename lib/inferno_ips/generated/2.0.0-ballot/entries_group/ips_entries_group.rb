# frozen_string_literal: true

require_relative 'patient_ips_entry_test'

require_relative 'allergy_intolerance_ips_entry_test'

require_relative 'condition_ips_entry_test'

require_relative 'device_entry_test'

require_relative 'device_use_statement_ips_entry_test'

require_relative 'diagnosticreport_ips_entry_test'

require_relative 'imaging_study_ips_entry_test'

require_relative 'immunization_ips_entry_test'

require_relative 'medication_ips_entry_test'

require_relative 'medication_request_ips_entry_test'

require_relative 'medication_statement_ips_entry_test'

require_relative 'practitioner_ips_entry_test'

require_relative 'practitionerrole_ips_entry_test'

require_relative 'procedure_ips_entry_test'

require_relative 'organization_ips_entry_test'

require_relative 'observation_pregnancy_edd_entry_test'

require_relative 'observation_pregnancy_outcome_entry_test'

require_relative 'observation_pregnancy_status_entry_test'

require_relative 'observation_sh_alcohol_use_entry_test'

require_relative 'observation_sh_tobacco_use_entry_test'

require_relative 'observation_results_laboratorypathology_ips_entry_test'

require_relative 'observation_results_radiology_ips_entry_test'

require_relative 'vital_signs_profile_entry_test'

require_relative 'specimen_ips_entry_test'

require_relative 'flag_alert_ips_entry_test'

require_relative 'clinicalimpression_entry_test'

require_relative 'careplan_entry_test'

require_relative 'consent_entry_test'

require_relative 'documentreference_entry_test'

module IPSTestKit
  class EntriesGroup < Inferno::TestGroup
    title '$summary Entries Tests'
    description 'A set of tests to check entries from $summary for read action and validate them according to profile specified in the AU PS Implementation Guide'
    id :ips_entries
    run_as_group

    test from: :ips_patient_ips_entry_test

    test from: :ips_allergy_intolerance_ips_entry_test

    test from: :ips_condition_ips_entry_test

    test from: :ips_device_entry_test

    test from: :ips_device_use_statement_ips_entry_test

    test from: :ips_diagnosticreport_ips_entry_test

    test from: :ips_imaging_study_ips_entry_test

    test from: :ips_immunization_ips_entry_test

    test from: :ips_medication_ips_entry_test

    test from: :ips_medication_request_ips_entry_test

    test from: :ips_medication_statement_ips_entry_test

    test from: :ips_practitioner_ips_entry_test

    test from: :ips_practitionerrole_ips_entry_test

    test from: :ips_procedure_ips_entry_test

    test from: :ips_organization_ips_entry_test

    test from: :ips_observation_pregnancy_edd_entry_test

    test from: :ips_observation_pregnancy_outcome_entry_test

    test from: :ips_observation_pregnancy_status_entry_test

    test from: :ips_observation_sh_alcohol_use_entry_test

    test from: :ips_observation_sh_tobacco_use_entry_test

    test from: :ips_observation_results_laboratorypathology_ips_entry_test

    test from: :ips_observation_results_radiology_ips_entry_test

    test from: :ips_vital_signs_profile_entry_test

    test from: :ips_specimen_ips_entry_test

    test from: :ips_flag_alert_ips_entry_test

    test from: :ips_clinicalimpression_entry_test

    test from: :ips_careplan_entry_test

    test from: :ips_consent_entry_test

    test from: :ips_documentreference_entry_test
  end
end
