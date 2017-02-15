local list_creator
list_creator = function(pType)
	if pType ~= 'new' then
		return print('list_creator has no function : '..pType)
	end
	
	local head = {value = 'head'}
	local tail = {value = 'tail'}
	
	head.next = tail
	tail.prev = head
	
	return function(pType, pObj)
		
		local function addInner(item0, item1, obj)
			local item = { value=obj }
			
			item.next = item1
			item.prev = item0
			
			item1.prev = item
			item0.next = item
			
		end
		
		local function add(obj)
			return addInner(tail.prev, tail, obj)
		end
		
		local function remove(obj)
			local item = head.next
			while item ~= tail do
				if item.value == obj then
					local prev = item.prev
					local next = item.next
					
					prev.next = next
					next.prev = prev
					
					break
				end
			end
		end
		
		local function size()
			local count = 0
			local item = head.next
			while item ~= tail do
				item = item.next
				count = count + 1
			end
			return count
		end
		
		local function iterator()
			local iter = head
			
			local function hasNext()
				return iter.next ~= tail
			end
		
			local function next()
				iter = iter.next
				return iter.value
			end
			
			local function remove()
				if iter ~= tail and iter ~= head then
					local prev = iter.prev
					local next = iter.next
					
					prev.next = next
					next.prev = prev
				end
			end
			
			local function add(obj)
				if iter ~= tail then
					return addInner(iter, iter.next)
				end
			end
			
			return function(pType, obj)
				if pType == 'hasNext' then
					return hasNext()
				elseif pType == 'next' then
					return next()
				elseif pType == 'remove' then
					return remove()
				elseif pType == 'add' then
					return add(obj)
				else
					print("iterator has no function : "..pType)
				end
			end
		end
			
		local function iterator_reverse()
			local iter = tail
			
			local function hasPrev()
				return iter.prev ~= head
			end
			
			local function prev()
				iter = iter.prev
				return iter.value
			end
			
			local function remove()
				if iter ~= tail and iter ~= head then
					local prev = iter.prev
					local next = iter.next
					
					prev.next = next
					next.prev = prev
				end
			end
			
			local function add(obj)
				if iter ~= head then
					return addInner(iter.prev, iter)
				end
			end
				
			return function(pType, obj)
				if pType == 'hasPrev' then
					return hasPrev()
				elseif pType == 'prev' then
					return prev()
				elseif pType == 'remove' then
					return remove()
				elseif pType == 'add' then
					return add(obj)
				else
					print("iteratorReverse has no function : "..pType)
				end
			end
		end
		
		local function pop_front()
			if head.next ~= tail then
				local item = head.next
				local nextItem = item.next
				
				head.next = nextItem
				nextItem.prev = head
				
				return item.value
			else
				return print("pop_front:list has no elements!")
			end
		end
		
		local function pop_back()
			if tail.prev ~= head then
				local item = tail.prev
				local prevItem = item.prev
				
				tail.prev = prevItem
				prevItem.next = tail
				
				return item.value
			else
				return print("pop_back:list has no elements!")
			end
		end
		
		local function add_front(obj)
			return addInner(head, head.next,obj)
		end

		local function for_each(func)
			-- body
			local iter = iterator()
			while iter('hasNext') do
				local value = iter('next')
				local ret = func(value)
				if ret then
					return ret
				end
			end
		end

		local function for_each_reverse( func )
			-- body
			local iter = iterator_reverse()
			while iter('hasPrev') do
				local value = iter('prev')
				local ret = func(value)
				if ret then
					return ret
				end
			end
		end

		local function get( index , isBack)
			-- body
			local iter = iterator()
			while iter('hasNext') do
				local value = iter('next')
				if index <= 0 then
					return value
				end
				index = index - 1
			end
		end

		local function get_reverse( index )
			-- body
			local iter = iterator()
			while iter('hasPrev') do
				local value = iter('prev')
				if index <= 0 then
					return value
				end
				index = index - 1
			end
		end

		local function clear()
			-- body
			while size() > 0 do
				pop_back()
			end
		end
		
		if pType == 'add' then
			return add(pObj)
		elseif pType == 'remove' then
			return remove(pObj)
		elseif pType == 'size' then
			return size()
		elseif pType == 'iterator' then
			return iterator()
		elseif pType == 'iterator_reverse' then
			return iterator_reverse()
		elseif pType == 'pop_back' then
			return pop_back()
		elseif pType == 'pop_front' then
			return pop_front()
		elseif pType == 'add_front' then
			return add_front(pObj)
		elseif pType == 'for_each' then
			return for_each(pObj)
		elseif pType == 'for_each_reverse' then
			return for_each_reverse(pObj)
		elseif pType == 'get' then
			return get(pObj)
		elseif pType == 'get_reverse' then
			return get_reverse(pObj)
		elseif pType == 'clear' then
			return clear()
		else
			return print("list has no function : "..pType)
		end
	end
end

return list_creator