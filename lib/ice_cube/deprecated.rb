module IceCube
	module Deprecated

		# Define a deprecated alias for a method
		# @param [Symbol] name - name of method to define
		# @param [Symbol] replacement - name of method to replace (alias)
		def deprecated_alias(name, replacement)
			# Create a wrapped version
			define_method(name) do |*args, &block|
				warn "IceCube: ##{name} deprecated (please use ##{replacement})"
				send replacement, *args, &block
			end
		end

		# Deprecate a defined method
		# @param [Symbol] name - name of deprecated method
		# @param [Symbol] replacement - name of the desired replacement
		def deprecated(name, replacement)
			# Replace old method
			old_name = :"#{name}_without_deprecation"
			alias_method old_name, name
			# And replace it with a wrapped version
			define_method(name) do |*args, &block|
				warn "IceCube: ##{name} deprecated (please use ##{replacement})"
				send old_name, *args, &block
			end
		end

    def self.schedule_options(schedule, options)
      if options[:start_date_override]
        warn "IceCube: :start_date_override option deprecated. " \
          "(please use a block { |s| s.start_time = override })"
        schedule.start_time = options[:start_date_override]
      end
    end

	end
end
