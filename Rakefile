require 'inferno_ps_suite_generator'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end

namespace :db do
  desc 'Apply changes to the database'
  task :migrate do
    require 'inferno/config/application'
    require 'inferno/utils/migration'
    Inferno::Utils::Migration.new.run
  end
end

namespace :ips do
  desc 'Generate tests'
  task :generate do
    InfernoPsSuiteGenerator::Generator.generate(
      {
        title: 'IPS Inferno',
        ig_human_name: 'IPS',
        ig_identifier: 'hl7.fhir.au.ps',
        gem_name: 'inferno_ips',
        core_file_path: './lib/inferno_ips.rb',
        output_path: './lib/inferno_ips',
        test_module_name: 'IPS',
        test_id_prefix: 'ips',
        test_kit_module_name: 'IPSTestKit',
        test_suite_class_name: 'IPSInferno',
        base_output_file_name: 'inferno_ips.rb',
        version: '2.0.0-ballot',
        igs: 'hl7.fhir.uv.ips#2.0.0-ballot',
        specific_profiles: {
          docref_op: 'http://hl7.org/fhir/uv/ipa/OperationDefinition/docref',
          summary_op: 'http://hl7.org/fhir/uv/ips/OperationDefinition/summary',
          ps_bundle: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Bundle-uv-ips',
          ps_composition: 'http://hl7.org/fhir/uv/ips/StructureDefinition/Composition-uv-ips'
        }
      }
    )
  end
end
