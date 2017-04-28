local __Resources = {
	"models/gmod_tower/arrow.mdl",
	"materials/models/gmod_tower/arrow.vmt",
	"effects/confetti/confetti.vmt",
	"models/gmod_tower/arrow.vmt",
	"materials/proximity/racing/AUD.png",
	"materials/proximity/racing/brands/acura.png",
	"materials/proximity/racing/brands/alfa_romeo.png",
	"materials/proximity/racing/brands/aston_martin.png",
	"materials/proximity/racing/brands/audi.png",
	"materials/proximity/racing/brands/bmw.png",
	"materials/proximity/racing/brands/bugatti.png",
	"materials/proximity/racing/brands/cadillac.png",
	"materials/proximity/racing/brands/chevy.png",
	"materials/proximity/racing/brands/citroen.png",
	"materials/proximity/racing/brands/corvette.png",
	"materials/proximity/racing/brands/dodge.png",
	"materials/proximity/racing/brands/ferrari.png",
	"materials/proximity/racing/brands/fiat.png",
	"materials/proximity/racing/brands/ford.png",
	"materials/proximity/racing/brands/GM.png",
	"materials/proximity/racing/brands/honda.png",
	"materials/proximity/racing/brands/rolls-royce.png",
	"materials/proximity/racing/brands/volkswagen.png",
	"materials/proximity/racing/euro.png",
	"materials/proximity/racing/gbp.png",
	"materials/proximity/racing/krona.png",
	"materials/proximity/racing/mouse_left.png",
	"materials/proximity/racing/mouse_right.png",
	"materials/proximity/racing/sale.png",
	"materials/proximity/racing/settings.png",
	"materials/proximity/racing/usd.png",
	"materials/proximity/racing/wrong_way.png",
}

function _GM.Resources:MountResources( _File )
    for _, _v in pairs( _File ) do
        resource.AddFile( _v )
    end
end

_GM.Resources:MountResources( __Resources )