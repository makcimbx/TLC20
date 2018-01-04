local ITEM = {}

--The name of the item ( is also an identifier for spawning the item )
ITEM.Name = "Unstable Crystal ( Green )"

--The description that appears with the item name
ITEM.Description = "A broken crystal, giving an unsteady blade"

--The category it belongs to
ITEM.Type = WOSTYPE.CRYSTAL

--Add user groups that are allowed to use this tree. If anyone is allowed, set this to FALSE ( TREE.UserGroups = false )
ITEM.UserGroups = false

--Does this item disappear from the inventory after it's been applied?
ITEM.BurnOnUse = false

--The model of the item on the floor / inventory
ITEM.Model = "models/green4/green4.mdl"

--The chance for the item to appear randomly. 0 = will not spawn, 100 = incredibly high chance
ITEM.Rarity = 5

ITEM.OnEquip = function( wep )
	wep.CustomSettings[ "Unstable" ] = true
	wep.UseColor = Color(14, 191, 0, 255)
end

wOS:RegisterItem( ITEM )