local ITEM = {}

ITEM.Name = "Нулевой рефрактор ( Нестабильный )"

ITEM.Description = "Обнуляет выход для инъекционного пучка"

ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = true

ITEM.Model = "models/props_combine/breenlight.mdl"

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Unstable" ] = true
	wep.UseColor = Color( 255, 255, 255, 255 )
end

wOS:RegisterItem( ITEM )