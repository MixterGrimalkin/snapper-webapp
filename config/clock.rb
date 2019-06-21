require 'clockwork'
require_relative '../app/jobs/drop_importer'
require_relative '../app/jobs/drop_sender'

module Clockwork

  every(3.seconds, 'Import Drops') { import_drops }
  every(30.seconds, 'Process Drops') { process_drops }

end
