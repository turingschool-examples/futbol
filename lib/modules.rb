module Sort

	def sort_objects_by(array_of_objects, header)
		array_of_objects.group_by do |object|
			object.info[header]
		end
	end
	
end