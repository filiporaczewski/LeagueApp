class Match < ActiveRecord::Base
	belongs_to :league

	default_scope { order('id ASC') }
end
