# frozen_string_literal: true

require_relative 'docref_operation_support'

require_relative 'docref_operation_success'

module IPSTestKit
  class DocRefOperation < Inferno::TestGroup
    title '$docref Operation Tests'
    description 'Verify support for the $docref operation as as described in the AU PS Guidance'
    id :ips_docref_operation_group
    run_as_group

    test from: :ips_docref_operation_support

    test from: :ips_docref_operation_success
  end
end
