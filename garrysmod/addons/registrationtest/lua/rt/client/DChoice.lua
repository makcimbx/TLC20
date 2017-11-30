local PANEL = {}
 
function PANEL:Init()
	self.selected = false
	self.group = {}
end
 
function PANEL:OnMousePressed()
	if not self.selected then
		self:SetSelected(true)
	end
end
 
function PANEL:SetSelected(doSelect)
	if doSelect then
		for i, button in ipairs(self.group) do
			button:SetChecked(false)
			button.selected = false
		end
		self:SetChecked(true)
		self.selected = true
	end
end

function PANEL:SetValue( val )
	self.value = val
end

function PANEL:GetValue()
	return self.value
end

function PANEL:GetSelected()
	return self.selected
end
 
function PANEL:SetGroup(group)
	self.group = group
end
derma.DefineControl("DChoice", "Custom Panel", PANEL, "DCheckBox")