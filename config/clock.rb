require 'clockwork'
require_relative '../app/jobs/drop_importer'

module Clockwork

  every(10.seconds, 'Import Drops') { import_drops }

end
