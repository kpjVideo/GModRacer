--this literally defeats the purpose of having meta tables, but it's a good "buffer" for people trying to parase the wrong type.

_GM.Networking = {}

--[[---------------------------------------------------------
   Name: _GM.Networking:SetNetVar( _Entity, _Name, _Var )
   Desc: Debug function used to set incoming networked variables
-----------------------------------------------------------]]

function _GM.Networking:SetNetVar( _Entity, _Name, _Var )

	_Entity:SetNetVar( tostring( _Name ), _Var )
end

--[[---------------------------------------------------------
   Name: _GM.Networking:GetNetVar( _Entity, _Name )
   Desc: Debug function used to parse incoming networked variables
-----------------------------------------------------------]]

function _GM.Networking:GetNetVar( _Entity, _Name )
	
	return _Entity:GetNetVar( tostring( _Name ) )
end


--[[---------------------------------------------------------
   Name: _P:SetRoleplayName( _First, _Last )
   Desc: Sets players full roleplay name in format of 'firstname', 'lastname'
-----------------------------------------------------------]]

function _P:SetRoleplayName( _First, _Last )

	if not _First or not _Last then return end

	if _First and isstring( _First ) then
		self:SetNetVar( "firstname", _First )
	end

	if _Last and isstring( _Last ) then
		self:SetNetVar( "lastname", _Last )
	end
end

--[[---------------------------------------------------------
   Name: _P:GetRoleplayName( )
   Desc: Grabs players full roleplay name in format of 'firstname', 'lastname'
-----------------------------------------------------------]]

function _P:GetRoleplayName()

	if self:GetNetVar( "firstname" ) and self:GetNetVar( "lastname" ) then
		return self:GetNetVar( "firstname" ) .. " " .. self:GetNetVar( "lastname" )
	end
end

--[[---------------------------------------------------------
   Name: _P:SetFirstName( _First )
   Desc: Sets players roleplay first name in format of 'firstname'
-----------------------------------------------------------]]

function _P:SetFirstName( _First )

	if not _First then return end

	if _First and isstring( _First ) then
		self:SetNetVar( "firstname", _First )
	end
end

--[[---------------------------------------------------------
   Name: _P:SetLastName( _Last )
   Desc: Sets players roleplay last name in format of 'lastname'
-----------------------------------------------------------]]

function _P:SetLastName( _Last )

	if not _Last then return end

	if _Last and isstring( _Last ) then
		self:SetNetVar( "lastname", _Last )
	end
end

--[[---------------------------------------------------------
   Name: _P:GetFirstName( )
   Desc: Grabs players roleplay first name
-----------------------------------------------------------]]

function _P:GetFirstName( )
	return self:GetNetVar("firstname") or "James"
end

--[[---------------------------------------------------------
   Name: _P:GetFirstName( )
   Desc: Grabs players roleplay last name
-----------------------------------------------------------]]

function _P:GetLastName( )
	return self:GetNetVar("lastname") or "Smith"
end