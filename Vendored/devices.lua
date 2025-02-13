local count = 0
local function counter()
	count = count + 1
	return count
end
-------DEVICE ID-------
devices = {}

-- Radios - DO NOT CHANGE THIS ORDER!
devices["PLT_ICP"] 			= counter()
devices["ARC201_FM1"]       = counter()
devices["ARC164"]           = counter()
devices["INTERCOM"]			= counter()
devices["UHF_RADIO"]		= counter() -- 5
devices["FM1_RADIO"]		= counter()
devices["ARC186"]			= counter()
devices["VHF_RADIO"]		= counter()
devices["ARC201_FM2"]       = counter()
devices["FM2_RADIO"]		= counter()
devices["BASERADIO"]		= counter()
devices["HF_RADIO"]			= counter()
devices["ADF_RADIO"]		= counter()
devices["VORILS_RADIO"]		= counter()


devices["ELECTRIC_SYSTEM"]	= counter() -- 14
devices["ECQ"]				= counter()
devices["AFCS"]				= counter()
devices["AHRU"]				= counter()
devices["APR39"] 			= counter()
devices["EXTLIGHTS"]		= counter()
devices["HELMET_DEVICE"] 	= counter()
devices["AVIONICS"]			= counter()
devices["ASN128B"]			= counter()
devices["CAUTION_ADVISORY_PANEL"]	= counter() -- 23
devices["VIDS"]				= counter()
devices["KNEEBOARD"]		= counter()
devices["EFM_HELPER"]		= counter()
devices["SOUNDSYSTEM"]      = counter()
devices["DEBUG"]      		= counter()
devices["AVS7"]      		= counter()
devices["CREWE"]            = counter()
devices["M130"]				= counter()
devices["SYNC_CONTROLLER"] 	= counter()
devices["POSITION"] 		= counter()
devices["PLTLC6"] 			= counter()
devices["CPLTLC6"] 			= counter()
devices["PLTCISP"] 			= counter()
devices["CPLTCISP"] 		= counter()
devices["CISP"] 			= counter()
devices["ARN149"] 			= counter()
devices["ARN147"] 			= counter()
devices["PLTAAU32A"] 		= counter()
devices["CPLTAAU32A"] 		= counter()
devices["PLTAPN209"] 		= counter()
devices["CPLTAPN209"] 		= counter()
devices["MISC"] 			= counter()
devices["AFMS"] 			= counter()
devices["MACROS"] 			= counter()