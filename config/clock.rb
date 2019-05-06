require 'clockwork'
require_relative '../app/jobs/drop_importer'

module Clockwork

  every(10.seconds, 'frequent.job') { import_drops }

end
