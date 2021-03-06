useful = {}

function useful.tri( cond, yes, no )
	if cond then
		return yes
	else
		return no
	end
end

function useful.sign(f)
	useful.tri(f>0,1,-1)
end

function useful.deadzone(f, size)
	local size = size or 0.25
	return useful.tri(math.abs(f)>size,f, 0)
end

function useful.almost(n, m, p)
	local p = 1
	if n<m+p and n>m-p then
		return true
	end
	return false
end