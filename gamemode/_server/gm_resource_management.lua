local __Resources = {
	"models/gmod_tower/arrow.mdl",
	"materials/models/gmod_tower/arrow.vmt",
}
function _GM.Resources:MountResources( _File )
    for _, _v in pairs( _File ) do
        resource.AddFile( _v )
    end
end

_GM.Resources:MountResources( __Resources )
