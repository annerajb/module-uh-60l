BIOS.protocol.beginModule("UH-60L", 0x8600)
BIOS.protocol.setExportModuleAircrafts({"UH-60L"})
--by WarLord (aka BlackLibrary) v.2.2

local inputProcessors = moduleBeingDefined.inputProcessors
local documentation = moduleBeingDefined.documentation

local document = BIOS.util.document

local parse_indication = BIOS.util.parse_indication

local defineIndicatorLight = BIOS.util.defineIndicatorLight
local definePushButton = BIOS.util.definePushButton
local definePotentiometer = BIOS.util.definePotentiometer
local defineToggleSwitch = BIOS.util.defineToggleSwitch
local defineMultipositionSwitch = BIOS.util.defineMultipositionSwitch
local defineFloat = BIOS.util.defineFloat
local defineTumb = BIOS.util.defineTumb
local define3PosTumb = BIOS.util.define3PosTumb
local defineRockerSwitch = BIOS.util.defineRockerSwitch
local defineIntegerFromGetter = BIOS.util.defineIntegerFromGetter
local defineString = BIOS.util.defineString
local defineRotary = BIOS.util.defineRotary
--
local cockpit = BIOS.CurrentPluginDir.."Vendored\\"
dofile(cockpit.."devices.lua")
dofile(cockpit.."command_defs.lua")

function guid_indicator(indicator_id)
	local ret = {}
	local li = list_indication(indicator_id)
	if li == "" then return nil end
	local m = li:gmatch("-----------------------------------------\n([^\n]+)\n([^\n]*)\n")
	while true do
        local name, value = m()
        if not name then break end
		table.insert(ret, value)
	end
	return ret
end
local function getUHFPreset()
	--C:\Users\AnnerJBonilla\Saved Games\DCS\Mods\aircraft\UH-60L\Cockpit\Scripts\device_init.lua indicators array
    local ind = guid_indicator(8)
    if ind == nil then return "ER" end
	-- screen off (i hate guids..)
    if table.maxn(ind) <= 22 then 
		return "" 
	end
	return ind[3]
end
------------- radio
local function getARC164_COMM1_String_Frequency()
	local uhf_comm1 = GetDevice(devices.UHF_RADIO)
	if not uhf_comm1:is_on() then return "       " end
	local freq = tostring(uhf_comm1:get_frequency())
	if freq == nil then return "       " end
	return freq:sub(0,6)
end

-- local function define3PosTumb1(msg, device_id, command, arg_number, category, description)
-- 	defineTumb(msg, device_id, command, arg_number, 0.01, {0.0, 0.2}, nil, false, category, description)
-- end

-- -- electrical
defineToggleSwitch("BATT_SW", devices.EFM_HELPER, EFM_commands.batterySwitch, 17, "Electrical Systems", "Battery Switch, ON/OFF")
-- elements["PNT-018"]	= default_button_tumb_v2_inverted(_("External Power Switch, ON/OFF/RESET"),	devices.EFM_HELPER, EFM_commands.extPwrSwitch, EFM_commands.extPwrSwitch2, 18)
-- elements["PNT-019"]	= default_button_tumb_v2_inverted(_("APU GEN Switch, ON/OFF/TEST"),	devices.EFM_HELPER, EFM_commands.apuGenSwitch, EFM_commands.apuGenSwitch2, 19)
-- elements["PNT-020"]	= default_button_tumb_v2_inverted(_("GEN 1 Switch, ON/OFF/TEST"),	devices.EFM_HELPER, EFM_commands.gen1Switch, EFM_commands.gen1Switch2, 20)
-- elements["PNT-021"]	= default_button_tumb_v2_inverted(_("GEN 2 Switch, ON/OFF/TEST"),	devices.EFM_HELPER, EFM_commands.gen2Switch, EFM_commands.gen2Switch2, 21)

-- -- Fuel and Engines
-- elements["PNT-022"]	= default_3_position_tumb(_("Fuel Pump Switch, FUEL PRIME/OFF/APU BOOST"),	devices.EFM_HELPER, EFM_commands.switchFuelPump, 22)
-- elements["PNT-023"]	= default_3_position_tumb(_("Air Source Switch, APU/OFF/ENG"),	devices.EFM_HELPER, EFM_commands.switchAirSource, 23)
defineToggleSwitch("APU_CONTROL_SW", devices.EFM_HELPER,EFM_commands.switchAPU, 24, "Electric Systems", "APU CONTROL, ON/OFF")
-- elements["PNT-024"]	= default_2_position_tumb(_("APU CONTROL, ON/OFF"),	devices.EFM_HELPER, EFM_commands.switchAPU, 24)
-- -- PNT-025 APU EXTINGUISH
-- --function default_axis_limited(hint_,device_,command_,arg_,default_,gain_,updatable_,relative_,arg_lim_)
-- elements["PNT-026"]	= default_axis_limited(_("Engine 1 Control"),	devices.ECQ, device_commands.setEng1Control, 26, 0, 0.1, true, false, {0,1})
-- elements["PNT-027"]	= default_axis_limited(_("Engine 2 Control"),	devices.ECQ, device_commands.setEng2Control, 27, 0, 0.1, true, false, {0,1})
-- --multiposition_switch_relative(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
-- elements["PNT-028"]	= multiposition_switch(_("Engine 1 FSS, OFF/DIR/XFD"),	devices.ECQ, device_commands.eng1FSS, 28, 3, 1/2, false, 0, 1, false)
-- elements["PNT-029"]	= multiposition_switch(_("Engine 2 FSS, OFF/DIR/XFD"),	devices.ECQ, device_commands.eng2FSS, 29, 3, 1/2, false, 0, 1, false)
-- elements["PNT-030"]	= default_trimmer_button(_("Engine 1 Starter"),	devices.ECQ, device_commands.eng1Starter, 30)
-- elements["PNT-031"]	= default_trimmer_button(_("Engine 2 Starter"),	devices.ECQ, device_commands.eng2Starter, 31)

-- -- STAB PANEL
-- --springloaded_3_pos_tumb(hint_,device_,command1_,command2_,arg_,animation_speed_,val1_,val2_,val3_)
-- elements["PNT-032"]	= springloaded_3_pos_tumb(_("Stabilator Manual Slew UP/DOWN"),	devices.AFCS, device_commands.slewStabUp, device_commands.slewStabDown, 32)
-- elements["PNT-033"]	= push_button_tumb(_("Stabilator Auto ON/OFF"),	devices.AFCS, device_commands.afcsStabAuto, 33, 8)
-- elements["PNT-034"]	= push_button_tumb(_("SAS 1 ON/OFF"),	devices.AFCS, device_commands.afcsSAS1, 34, 8)
-- elements["PNT-035"]	= push_button_tumb(_("SAS 2 ON/OFF"),	devices.AFCS, device_commands.afcsSAS2, 35, 8)
-- elements["PNT-036"]	= push_button_tumb(_("Trim ON/OFF"),	devices.AFCS, device_commands.afcsTrim, 36, 8)
-- elements["PNT-037"]	= push_button_tumb(_("FPS ON/OFF"),	devices.AFCS, device_commands.afcsFPS, 37, 8)
-- elements["PNT-038"]	= push_button_tumb(_("SAS Boost ON/OFF"),	devices.AFCS, device_commands.afcsBoost, 38, 8)
-- --elements["PNT-039"]	= push_button_tumb(_("SAS Power On Reset (inop)"),	devices.EFM_HELPER, EFM_commands.stabPwrReset, 39, 8)

-- --FUEL PUMPS
-- elements["PNT-040"]	= default_2_position_tumb(_("No. 1 Fuel Boost Pump ON/OFF"),	devices.EFM_HELPER, EFM_commands.fuelPumpL, 40, 8)
-- elements["PNT-041"]	= default_2_position_tumb(_("No. 2 Fuel Boost Pump ON/OFF"),	devices.EXTLIGHTS, device_commands.fuelProbe, 41, 8)

-- -- Engine Control Locks
-- --default_animated_lever(hint_,device_,command_,arg_,animation_speed_,arg_lim_)
-- elements["PNT-042"]	= default_animated_lever(_("Engine 1 Control Level OFF/IDLE"),	devices.ECQ, device_commands.eng1ControlDetent, 42, 2, {-1, 0})
-- elements["PNT-043"]	= default_animated_lever(_("Engine 2 Control Level OFF/IDLE"),	devices.ECQ, device_commands.eng2ControlDetent, 43, 2, {-1, 0})

-- -- PILOT BARO ALTIMETER
-- elements["PNT-063"]	= default_axis(_("Barometric Scale Set"),  devices.PLTAAU32A, device_commands.pilotBarometricScaleSet, 63, 0, 0.1, false, true)
-- -- COPILOT BARO ALTIMETER
-- elements["PNT-073"]	= default_axis(_("Barometric Scale Set"),  devices.CPLTAAU32A, device_commands.copilotBarometricScaleSet, 73, 0, 0.1, false, true)
-- -- PARKING BRAKE
-- elements["PNT-080"]	= springloaded_2_pos_tumb(_("Parking Brake ON/OFF"),    devices.EFM_HELPER, device_commands.parkingBrake, 80)

-- -- AHRU
local function getAHRSText()
	local ind = list_indication(11)
end
definePushButton("AHRU_BTN_MODE", devices.AHRU, device_commands.ahruMode, 90,  "AHRU", "AHRU Mode Selector (Inop.)")
definePushButton("AHRU_BTN_FUNC", devices.AHRU, device_commands.ahruFunc, 91,  "AHRU", "AHRU Function Selector (Inop.)")
definePushButton("AHRU_BTN_UP", devices.AHRU, device_commands.ahruUp, 92,  "AHRU", "AHRU Display Cursor Movement UP (Inop.)")
definePushButton("AHRU_BTN_RIGHT", devices.AHRU, device_commands.ahruRight, 93,  "AHRU", "AHRU Display Cursor Movement RIGHT (Inop.)")
definePushButton("AHRU_BTN_ENTER", devices.AHRU, device_commands.ahruEnter, 94,  "AHRU", "AHRU Enter Selection (Inop.)")

-- -- PILOT HSI
-- --default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
-- elements["PNT-130"]	= default_axis(_("Heading Set"),	devices.PLTCISP, device_commands.pilotHSIHdgSet, 130, 0, 0.1, false, true)
-- elements["PNT-131"]	= default_axis(_("Course Set"),	devices.PLTCISP, device_commands.pilotHSICrsSet, 131, 0, 0.1, false, true)

-- -- COPILOT HSI
-- --default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
-- elements["PNT-150"]	= default_axis(_("Heading Set"),	devices.CPLTCISP, device_commands.copilotHSIHdgSet, 150, 0, 0.1, false, true)
-- elements["PNT-151"]	= default_axis(_("Course Set"),	    devices.CPLTCISP, device_commands.copilotHSICrsSet, 151, 0, 0.1, false, true)
-- MISC
definePushButton("FUEL_INDICATOR_TEST", devices.MISC, device_commands.miscFuelIndTest, 290, "MISC", "Tail Wheel Lock")
definePushButton("TAIL_WHEEL_LOCK", devices.miscTailWheelLock, device_commands.miscTailWheelLock, 291, "MISC", "Tail Wheel Lock")
definePushButton("GYRO_ERECT", devices.MISC, device_commands.miscGyroEffect, 292, "MISC", "Tail Wheel Lock")
--TODO: fix tailwheel to be turned off during transition
defineIndicatorLight("LIGHTING_MISC_TAILWHEELLOCK", 294, "MISC","Tailwheel Light(green)")
defineToggleSwitch("TAIL_SERVO_SW", devices.MISC,  device_commands.miscTailServo, 296, "MISC", "Tail Servo Select NORMAL/BACKUP (Inop.)")

-- -- CAUTION/DISPLAY PANELS
-- elements["PNT-301"]	= springloaded_2_pos_tumb(_("Lamp Test"),	devices.VIDS, device_commands.cduLampTest, 301, 8)
-- elements["PNT-302"]	= springloaded_2_pos_tumb(_("Lamp Test"),	devices.VIDS, device_commands.pilotPDUTest, 302, 8)
-- elements["PNT-303"]	= springloaded_2_pos_tumb(_("Lamp Test"),	devices.VIDS, device_commands.copilotPDUTest, 303, 8)

-- elements["PNT-304"]	= springloaded_3_pos_tumb(_("CAP Lamp Test"),	devices.CAUTION_ADVISORY_PANEL, device_commands.CAPLampTest, device_commands.CAPLampBrightness, 304)
-- elements["PNT-305"]	= default_button(_("Master Caution Reset"),	devices.CAUTION_ADVISORY_PANEL, device_commands.CAPMasterCautionReset, 305, 8)
-- elements["PNT-306"]	= default_button(_("Master Caution Reset"),	devices.CAUTION_ADVISORY_PANEL, device_commands.CAPMasterCautionReset, 306, 8)

---- AN/ASN-128B
defineTumb("ASN128B_DISPLAY_MODE",devices.ASN128B, device_commands.SelectDisplay, 500, 0.01,{0.0,0.06},nil,false,"AN/ASN-128B","AN/ASN-128B Display Selector");
defineTumb("ASN128B_MODE_SELECTOR",devices.ASN128B, device_commands.SelectMode, 501, 0.01,{0.0,0.05},nil,false,"AN/ASN-128B","AN/ASN-128B Mode Selector");
definePushButton("ASN128B_BTN_KYBD", devices.ASN128B, device_commands.SelectBtnKybd,     502,"AN/ASN-128B", "AN/ASN-128B Btn KYBD")
definePushButton("ASN128B_BTN_LEFT", devices.ASN128B, device_commands.SelectBtnLtrLeft,  503,  "AN/ASN-128B", "AN/ASN-128B Btn LTR LEFT")	
definePushButton("ASN128B_BTN_MID", devices.ASN128B, device_commands.SelectBtnLtrMid,   504,"AN/ASN-128B", "AN/ASN-128B Btn LTR MID")	
definePushButton("ASN128B_BTN_RIGHT", devices.ASN128B, device_commands.SelectBtnLtrRight, 505,"AN/ASN-128B", "AN/ASN-128B Btn LTR RIGHT")
definePushButton("ASN128B_BTN_F1", devices.ASN128B, device_commands.SelectBtnF1,       506,"AN/ASN-128B", "AN/ASN-128B Btn F1")	    
definePushButton("ASN128B_BTN_1", devices.ASN128B, device_commands.SelectBtn1,        507,"AN/ASN-128B", "AN/ASN-128B Btn 1")	    
definePushButton("ASN128B_BTN_2", devices.ASN128B, device_commands.SelectBtn2,        508,"AN/ASN-128B", "AN/ASN-128B Btn 2")	    
definePushButton("ASN128B_BTN_3", devices.ASN128B, device_commands.SelectBtn3,        509,"AN/ASN-128B", "AN/ASN-128B Btn 3")	    
definePushButton("ASN128B_BTN_TGT_STR", devices.ASN128B, device_commands.SelectBtnTgtStr,   510,"AN/ASN-128B", "AN/ASN-128B Btn TGT STR")	
definePushButton("ASN128B_BTN_4", devices.ASN128B, device_commands.SelectBtn4,        511,"AN/ASN-128B", "AN/ASN-128B Btn 4")	    
definePushButton("ASN128B_BTN_5", devices.ASN128B, device_commands.SelectBtn5,        512,"AN/ASN-128B", "AN/ASN-128B Btn 5")	    
definePushButton("ASN128B_BTN_6", devices.ASN128B, device_commands.SelectBtn6,        513,"AN/ASN-128B", "AN/ASN-128B Btn 6")	    
definePushButton("ASN128B_BTN_INC", devices.ASN128B, device_commands.SelectBtnInc,      514,"AN/ASN-128B", "AN/ASN-128B Btn INC")	    
definePushButton("ASN128B_BTN_7", devices.ASN128B, device_commands.SelectBtn7,        515,"AN/ASN-128B", "AN/ASN-128B Btn 7")	    
definePushButton("ASN128B_BTN_8", devices.ASN128B, device_commands.SelectBtn8,        516,"AN/ASN-128B", "AN/ASN-128B Btn 8")	    
definePushButton("ASN128B_BTN_9", devices.ASN128B, device_commands.SelectBtn9,        517,"AN/ASN-128B", "AN/ASN-128B Btn 9")	    
definePushButton("ASN128B_BTN_DEC", devices.ASN128B, device_commands.SelectBtnDec,      518,"AN/ASN-128B", "AN/ASN-128B Btn DEC")	    
definePushButton("ASN128B_BTN_CLR", devices.ASN128B, device_commands.SelectBtnClr,      519,"AN/ASN-128B", "AN/ASN-128B Btn CLR")	    
definePushButton("ASN128B_BTN_0", devices.ASN128B, device_commands.SelectBtn0,        520,"AN/ASN-128B", "AN/ASN-128B Btn 0")	    
definePushButton("ASN128B_BTN_ENT", devices.ASN128B, device_commands.SelectBtnEnt,      521,"AN/ASN-128B", "AN/ASN-128B Btn ENT")	    

-- -- CIS/MODE SEL
-- elements["PNT-930"]	= push_button_tumb(_("CIS Heading Mode ON/OFF"),	    devices.CISP, device_commands.PilotCISHdgToggle, 930, 8)
-- elements["PNT-931"]	= push_button_tumb(_("CIS Nav Mode ON/OFF"),	        devices.CISP, device_commands.PilotCISNavToggle, 931, 8)
-- elements["PNT-932"]	= push_button_tumb(_("CIS Altitude Hold Mode ON/OFF"),	devices.CISP, device_commands.PilotCISAltToggle, 932, 8)

-- elements["PNT-933"]	= push_button_tumb(_("NAV Mode: Doppler/GPS ON/OFF"),	    devices.PLTCISP, device_commands.PilotNavGPSToggle, 933, 8)
-- elements["PNT-934"]	= push_button_tumb(_("NAV Mode: VOR/ILS ON/OFF"),	        devices.PLTCISP, device_commands.PilotNavVORILSToggle, 934, 8)
-- elements["PNT-935"]	= push_button_tumb(_("NAV Mode: Back Course ON/OFF"),	    devices.PLTCISP, device_commands.PilotNavBACKCRSToggle, 935, 8)
-- elements["PNT-936"]	= push_button_tumb(_("NAV Mode: FM Homing ON/OFF"),	        devices.PLTCISP, device_commands.PilotNavFMHOMEToggle, 936, 8)
-- elements["PNT-937"]	= push_button_tumb(_("Turn Rate Selector NORM/ALTR"),       devices.PLTCISP, device_commands.PilotTURNRATEToggle, 937, 8)
-- elements["PNT-938"]	= push_button_tumb(_("Course Heading Selector PLT/CPLT"),	devices.PLTCISP, device_commands.PilotCRSHDGToggle, 938, 8)
-- elements["PNT-939"]	= push_button_tumb(_("Vertical Gyro Selector NORM/ALTR"),	devices.PLTCISP, device_commands.PilotVERTGYROToggle, 939, 8)
-- elements["PNT-940"]	= push_button_tumb(_("No. 2 Bearing Selector ADF/VOR"),	    devices.PLTCISP, device_commands.PilotBRG2Toggle, 940, 8)

-- elements["PNT-941"]	= push_button_tumb(_("NAV Mode: Doppler/GPS ON/OFF"),	    devices.CPLTCISP, device_commands.CopilotNavGPSToggle, 941, 8)
-- elements["PNT-942"]	= push_button_tumb(_("NAV Mode: VOR/ILS ON/OFF"),	        devices.CPLTCISP, device_commands.CopilotNavVORILSToggle, 942, 8)
-- elements["PNT-943"]	= push_button_tumb(_("NAV Mode: Back Course ON/OFF"),	    devices.CPLTCISP, device_commands.CopilotNavBACKCRSToggle, 943, 8)
-- elements["PNT-944"]	= push_button_tumb(_("NAV Mode: FM Homing ON/OFF"),	        devices.CPLTCISP, device_commands.CopilotNavFMHOMEToggle, 944, 8)
-- elements["PNT-945"]	= push_button_tumb(_("Turn Rate Selector NORM/ALTR"),       devices.CPLTCISP, device_commands.CopilotTURNRATEToggle, 945, 8)
-- elements["PNT-946"]	= push_button_tumb(_("Course Heading Selector PLT/CPLT"),	devices.CPLTCISP, device_commands.CopilotCRSHDGToggle, 946, 8)
-- elements["PNT-947"]	= push_button_tumb(_("Vertical Gyro Selector NORM/ALTR"),	devices.CPLTCISP, device_commands.CopilotVERTGYROToggle, 947, 8)
-- elements["PNT-948"]	= push_button_tumb(_("No. 2 Bearing Selector ADF/VOR"),	    devices.CPLTCISP, device_commands.CopilotBRG2Toggle, 948, 8)

-- -- AN/AVS-7 PANEL
-- elements["PNT-1100"]	= default_3_position_tumb(_("AN/AVS-7 OFF/ON/ADJUST"),                      devices.AVS7, device_commands.setAVS7Power, 1100)
-- elements["PNT-1101"]	= default_3_position_tumb(_("AN/AVS-7 Program Pilot/Copilot (Inop)"),	    devices.AVS7, device_commands.foo, 1101)
-- elements["PNT-1102"]	= default_3_position_tumb(_("AN/AVS-7 Pilot MODE 1-4/DCLT (Inop)"),         devices.AVS7, device_commands.foo, 1102)
-- elements["PNT-1103"]	= default_3_position_tumb(_("AN/AVS-7 Copilot MODE 1-4/DCLT (Inop)"),	    devices.AVS7, device_commands.foo, 1103)
-- elements["PNT-1104"]	= default_3_position_tumb(_("AN/AVS-7 BIT/ACK (Inop)"),	                    devices.AVS7, device_commands.foo, 1104)
-- elements["PNT-1105"]	= default_3_position_tumb(_("AN/AVS-7 ALT/P/R DEC/INC PGM NXT/SEL (Inop)"),	devices.AVS7, device_commands.foo, 1105)
-- elements["PNT-1106"]	= springloaded_3_pos_tumb2(_("AN/AVS-7 Pilot BRT/DIM"),	                    devices.AVS7, device_commands.incAVS7Brightness, device_commands.decAVS7Brightness, 1106)
-- elements["PNT-1107"]	= default_3_position_tumb(_("AN/AVS-7 Pilot DSPL POS D/U (Inop)"),      	devices.AVS7, device_commands.foo, 1107)
-- elements["PNT-1108"]	= default_3_position_tumb(_("AN/AVS-7 Pilot DSPL POS L/R (Inop)"),      	devices.AVS7, device_commands.foo, 1108)
-- elements["PNT-1109"]	= default_3_position_tumb(_("AN/AVS-7 Copilot BRT/DIM (Inop)"),	            devices.AVS7, device_commands.foo, 1109)
-- elements["PNT-1110"]	= default_3_position_tumb(_("AN/AVS-7 Copilot DSPL POS D/U (Inop)"),    	devices.AVS7, device_commands.foo, 1110)
-- elements["PNT-1111"]	= default_3_position_tumb(_("AN/AVS-7 Copilot DSPL POS L/R (Inop)"),    	devices.AVS7, device_commands.foo, 1111)


--UHF Radio Panel / AN/ARC-164
defineTumb("UHF_FUNCTION", devices.ARC164,  device_commands.arc164_mode, 			50, 0.1, {0.0, 0.3}, nil, false, "UHF Radio", "AN/ARC-164  Function Dial OFF/MAIN/BOTH/ADF")
definePotentiometer("UHF_VOL", devices.ARC164, device_commands.arc164_volume, 		51, {0, 1}, "UHF Radio", "AN/ARC-164 Volume")
defineTumb("UHF_MODE", devices.ARC164, device_commands.arc164_xmitmode,    			52, 0.01, {0.0,0.02},nil,false,"UHF Radio", "AN/ARC-164 Frequency Mode Dial MNL/PRESET/GRD")
defineTumb("UHF_100MHZ_SEL", devices.ARC164, device_commands.arc164_freq_Xooooo, 	53, 0.1, {0.0, 0.2}, {"2", "3", "A"}, false, "UHF Radio", "UHF 100MHz Selector")
defineTumb("UHF_10MHZ_SEL", devices.ARC164, device_commands.arc164_freq_oXoooo, 	54, 0.1, {0.0, 0.9}, nil, false, "UHF Radio", "UHF 10MHz Selector")
defineTumb("UHF_1MHZ_SEL", devices.ARC164, device_commands.arc164_freq_ooXooo, 		55, 0.1, {0.0, 0.9}, nil, false, "UHF Radio", "UHF 1MHz Selector")
defineTumb("UHF_POINT1MHZ_SEL", devices.ARC164, device_commands.arc164_freq_oooXoo, 56, 0.1, {0.0, 0.9}, nil, false, "UHF Radio", "UHF 0.1MHz Selector")
defineTumb("UHF_POINT25_SEL", devices.ARC164, device_commands.arc164_freq_ooooXX, 	57, 0.1, {0.0, 0.3}, {"00", "25", "50", "75"}, false, "UHF Radio", "UHF 0.25MHz Selector")
defineTumb("UHF_PRESET_SEL", devices.ARC164, device_commands.arc164_preset, 		58, 0.05, {0.0, 1.0}, {" 1", " 2", " 3", " 4", " 5", " 6", " 7", " 8", " 9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20"}, false, "UHF Radio", "UHF Preset Channel Selector")

-- sadly unsupported by the arc164 on the uh-60l mod but supported on the a-10 irc
-- defineTumb("UHF_T_TONE", devices.ARC164, 3009, 169, 1, {-1, 1}, nil, false, "UHF Radio", "T-Tone Button")
-- defineToggleSwitch("UHF_SQUELCH", devices.ARC164, 3010, 170, "UHF Radio", "Squelch Switch")
-- definePushButton("UHF_TEST", devices.ARC164, 3012, 172, "UHF Radio", "Display Test Button")
-- definePushButton("UHF_STATUS", devices.ARC164, 3013, 173, "UHF Radio", "Status Button")
-- definePushButton("UHF_LOAD", devices.ARC164, 3015, 735, "UHF Radio", "Load Button")
-- defineToggleSwitch("UHF_COVER", devices.ARC164, 3014, 734, "UHF Radio", "Load Button Cover")
defineString("UHF_FREQUENCY", getARC164_COMM1_String_Frequency, 7, "UHF Radio", "COMM1 ARC-164 Frequency (string)")
defineString("UHF_PRESET", getUHFPreset, 2, "UHF Radio", "UHF Preset Display")

-- -- Pilot APN-209 Radar Altimeter
-- --default_axis(hint_,device_,command_,arg_, default_, gain_,updatable_,relative_,cycled_,attach_left_,attach_right_)
-- elements["PNT-170"]	= default_axis(_("Low Altitude Set"),  devices.PLTAPN209, device_commands.apn209PilotLoSet, 170, 0, 20, true, true, true)
-- elements["PNT-171"]	= default_axis(_("High Altitude Set"), devices.PLTAPN209, device_commands.apn209PilotHiSet, 171, 0, 20, true, true, true)

-- elements["PNT-183"]	= default_axis(_("Low Altitude Set"),  devices.CPLTAPN209, device_commands.apn209CopilotLoSet, 183, 0, 20, true, true, true)
-- elements["PNT-184"]	= default_axis(_("High Altitude Set"), devices.CPLTAPN209, device_commands.apn209CopilotHiSet, 184, 0, 20, true, true, true)


-- -- Lighting
-- elements["PNT-251"]	= default_axis_limited(_("Glareshield Lights OFF/BRT"),                 devices.EXTLIGHTS, device_commands.glareshieldLights,   251, 0, 0.1, true, false, {0,1})
-- elements["PNT-252"]	= default_3_position_tumb(_("Position Lights DIM/OFF/BRT"),             devices.EXTLIGHTS, device_commands.posLightIntensity,   252)
-- elements["PNT-253"]	= default_2_position_tumb(_("Position Lights STEADY/FLASH"),            devices.EXTLIGHTS, device_commands.posLightMode,        253)
-- elements["PNT-254"]	= default_3_position_tumb(_("Anticollision Lights UPPER/BOTH/LOWER"),   devices.EXTLIGHTS, device_commands.antiLightGrp,        254)
-- elements["PNT-255"]	= default_3_position_tumb(_("Anticollision Lights DAY/OFF/NIGHT"),      devices.EXTLIGHTS, device_commands.antiLightMode,       255)
-- elements["PNT-256"]	= default_2_position_tumb(_("Nav Lights NORM/IR"),                      devices.EXTLIGHTS, device_commands.navLightMode,        256)
-- elements["PNT-257"]	= default_3_position_tumb(_("Cabin Lights BLUE/OFF/WHITE"),             devices.EXTLIGHTS, device_commands.cabinLightMode,      257)
-- elements["PNT-259"]	= default_axis_limited(_("Copilot Flight Instrument Lights OFF/BRT"),   devices.EXTLIGHTS, device_commands.cpltInstrLights,     259, 0, 0.1, true, false, {0,1})
-- elements["PNT-260"]	= default_axis_limited(_("Lighted Switches OFF/BRT"),                   devices.EXTLIGHTS, device_commands.lightedSwitches,     260, 0, 0.1, true, false, {0,1})
-- elements["PNT-261"]	= multiposition_switch(_("Formation Lights OFF/1/2/3/4/5"),             devices.EXTLIGHTS, device_commands.formationLights,     261, 6, 0.2, false, 0, 100, false)
-- elements["PNT-262"]	= default_axis_limited(_("Upper Console Lights OFF/BRT"),               devices.EXTLIGHTS, device_commands.upperConsoleLights,  262, 0, 0.1, true, false, {0,1})
-- elements["PNT-263"]	= default_axis_limited(_("Lower Console Lights OFF/BRT"),               devices.EXTLIGHTS, device_commands.lowerConsoleLights,  263, 0, 0.1, true, false, {0,1})
-- elements["PNT-264"]	= default_axis_limited(_("Pilot Flight Instrument Lights OFF/BRT"),     devices.EXTLIGHTS, device_commands.pltInstrLights,      264, 0, 0.1, true, false, {0,1})
-- elements["PNT-265"]	= default_axis_limited(_("Non Flight Instrument Lights OFF/BRT"),       devices.EXTLIGHTS, device_commands.nonFltInstrLights,   265, 0, 0.1, true, false, {0,1})
-- elements["PNT-266"]	= default_axis_limited(_("Radar Altimeter Dimmer"),                     devices.EXTLIGHTS, device_commands.pltRdrAltLights,     266, 0, 0.1, true, false, {0,1})
-- elements["PNT-267"]	= default_axis_limited(_("Radar Altimeter Dimmer"),                     devices.EXTLIGHTS, device_commands.cpltRdrAltLights,    267, 0, 0.1, true, false, {0,1})
-- elements["PNT-268"]	= default_2_position_tumb(_("Magnetic Compass Light ON/OFF"),           devices.EXTLIGHTS, device_commands.magCompassLights,    268)
-- elements["PNT-269"]	= default_3_position_tumb(_("Cockpit Lights BLUE/OFF/WHITE"),           devices.EXTLIGHTS, device_commands.cockpitLightMode,    269)

-- -- AN/APR-39
defineToggleSwitch("APR39_POWER", devices.APR39, device_commands.apr39Power, 270, "AN/APR-39 RWR", "AN/APR-39 Power ON/OFF")
definePushButton("ARC201_FM1_BTN_1", devices.APR39, device_commands.apr39SelfTest, 271,  "AN/APR-39 RWR", "AN/APR-39 Self Test (Inop.)")
defineToggleSwitch("APR39_ALTITUDE", devices.APR39, device_commands.apr39Altitude, 272, "AN/APR-39 RWR", "AN/APR-39 Altitude HIGH/LOW (Inop.)")
-- default_axis(_("AN/APR-39 Volume"),    	                        devices.APR39, device_commands.apr39Volume, 273)
-- default_axis(_("AN/APR-39 Brilliance"),    	                    devices.APR39, device_commands.apr39Brightness, 274)

-- -- PILOT LC6 CHRONOMETER
-- elements["PNT-280"]	= default_button(_("Pilot's Chronometer RESET/SET Button"), devices.PLTLC6, device_commands.resetSetBtn, 280)
-- elements["PNT-281"]	= default_button(_("Pilot's Chronometer MODE Button"), devices.PLTLC6, device_commands.modeBtn, 281)
-- elements["PNT-282"]	= default_button(_("Pilot's Chronometer START/STOP/ADVANCE Button"), devices.PLTLC6, device_commands.startStopAdvBtn, 282)

-- -- COPILOT LC6 CHRONOMETER
-- elements["PNT-283"]	= default_button(_("Copilot's Chronometer RESET/SET Button"), devices.CPLTLC6, device_commands.resetSetBtn, 283)
-- elements["PNT-284"]	= default_button(_("Copilot's Chronometer MODE Button"), devices.CPLTLC6, device_commands.modeBtn, 284)
-- elements["PNT-285"]	= default_button(_("Copilot's Chronometer START/STOP/ADVANCE Button"), devices.CPLTLC6, device_commands.startStopAdvBtn, 285)

-- -- PILOT ICS PANEL
-- --multiposition_switch_relative(hint_,device_,command_,arg_,count_,delta_,inversed_,min_,animation_speed_,cycled_)
-- elements["PNT-400"]	= multiposition_switch(_("Pilot ICP XMIT Selector"),            devices.BASERADIO, device_commands.pilotICPXmitSelector, 400, 6,  1/5,  false, 0, 16, false)
definePotentiometer("PLT_ICS_VOL", devices.PLT_ICP, device_commands.pilotICPSetVolume, 		401, {0, 1}, "Pilot ICP", "Pilot ICP RCV Volume")
defineToggleSwitch("PLT_ICS_SW_HOT_MIKE", devices.PLT_ICP, device_commands.foo, 					 402, "Pilot ICP", "Pilot ICP Hot Mike (Inop.)")   
defineToggleSwitch("PLT_ICS_SW_RCV_FM1", devices.PLT_ICP, device_commands.pilotICPToggleFM1, 	 403, "Pilot ICP", "Pilot ICP RCV FM1")            
defineToggleSwitch("PLT_ICS_SW_RCV_UHF", devices.PLT_ICP, device_commands.pilotICPToggleUHF, 	 404, "Pilot ICP", "Pilot ICP RCV UHF")            
defineToggleSwitch("PLT_ICS_SW_RCV_VHF", devices.PLT_ICP, device_commands.pilotICPToggleVHF, 	 405, "Pilot ICP", "Pilot ICP RCV VHF")            
defineToggleSwitch("PLT_ICS_SW_RCV_FM2", devices.PLT_ICP, device_commands.pilotICPToggleFM2, 	 406, "Pilot ICP", "Pilot ICP RCV FM2")            
defineToggleSwitch("PLT_ICS_SW_RCV_HF", devices.PLT_ICP, device_commands.pilotICPToggleHF, 		 407, "Pilot ICP", "Pilot ICP RCV HF")             
defineToggleSwitch("PLT_ICS_SW_RCV_VOR", devices.PLT_ICP, device_commands.pilotICPToggleVOR, 	 408, "Pilot ICP", "Pilot ICP RCV VOR/LOC")        
defineToggleSwitch("PLT_ICS_SW_RCV_ADR", devices.PLT_ICP, device_commands.pilotICPToggleADF, 	 409, "Pilot ICP", "Pilot ICP RCV ADF")            
-- -- TODO OTHER ICS PANELS?

-- -- ARC-186 VHF
-- elements["PNT-410"]	= default_axis_limited(_("AN/ARC-186 Volume"),                      devices.ARC186, device_commands.arc186Volume, 410, 0, 0.1, true, false, {0,1})
-- elements["PNT-411"]	= default_button_tumb_v2_inverted(_("AN/ARC-186 Tone (Inop.)"),	    devices.ARC186, device_commands.arc186Tone, device_commands.arc186Tone, 411)
-- elements["PNT-412"]	= multiposition_switch(_("AN/ARC-186 10MHz Selector"),              devices.ARC186, device_commands.arc186Selector10MHz, 412, 13,  1/12,  false, 0, 16, true)
-- elements["PNT-413"]	= multiposition_switch(_("AN/ARC-186 1MHz Selector"),               devices.ARC186, device_commands.arc186Selector1MHz, 413, 10,  0.1,  false, 0, 16, true)
-- elements["PNT-414"]	= multiposition_switch(_("AN/ARC-186 100KHz Selector"),             devices.ARC186, device_commands.arc186Selector100KHz, 414, 10,  0.1,  false, 0, 16, true)
-- elements["PNT-415"]	= multiposition_switch(_("AN/ARC-186 25KHz Selector"),              devices.ARC186, device_commands.arc186Selector25KHz, 415, 4,  0.25,  false, 0, 16, true)
-- elements["PNT-416"]	= multiposition_switch(_("AN/ARC-186 Frequency Control Selector"),  devices.ARC186, device_commands.arc186FreqSelector, 416, 4,  1/3,  false, 0, 16, false)
-- elements["PNT-417"]	= default_button(_("AN/ARC-186 Load Pushbutton"),                   devices.ARC186, device_commands.arc186Load, 417)
-- elements["PNT-418"]	= multiposition_switch(_("AN/ARC-186 Preset Channel Selector"),     devices.ARC186, device_commands.arc186PresetSelector, 418, 20,  0.05,  false, 0, 16, true)
-- elements["PNT-419"]	= multiposition_switch(_("AN/ARC-186 Mode Selector"),               devices.ARC186, device_commands.arc186ModeSelector, 419, 3,  0.5,  false, 0, 16, false)

-- -- AFMS
-- elements["PNT-460"]	= default_3_position_tumb(_("Aux Fuel Transfer Mode MAN/OFF/AUTO"),         devices.AFMS, device_commands.afmcpXferMode, 460)
-- elements["PNT-461"]	= default_3_position_tumb(_("Aux Fuel Manual Transfer RIGHT/BOTH/LEFT"),    devices.AFMS, device_commands.afmcpManXfer,461)
-- elements["PNT-462"]	= default_2_position_tumb(_("Aux Fuel Transfer From OUTBD/INBD"),           devices.AFMS, device_commands.afmcpXferFrom, 462, 8)
-- elements["PNT-463"]	= multiposition_switch(_("Aux Fuel Pressurization Selector"),               devices.AFMS, device_commands.afmcpPress, 463, 4,  1/3,  false, 0, 16, false)

local function getFuelTransfer()
	local ind = list_indication(12)
end
-- -- DOORS
-- elements["PNT-470"]	= default_2_position_tumb(_("Copilot Door"),         devices.MISC, device_commands.doorCplt, 470)
-- elements["PNT-471"]	= default_2_position_tumb(_("Pilot Door"),           devices.MISC, device_commands.doorPlt, 471)
-- elements["PNT-472"]	= default_2_position_tumb(_("Left Gunner Window"),   devices.MISC, device_commands.doorLGnr, 472)
-- elements["PNT-473"]	= default_2_position_tumb(_("Right Gunner Window"),  devices.MISC, device_commands.doorRGnr, 473)
-- elements["PNT-474"]	= default_2_position_tumb(_("Left Cargo Door"),      devices.MISC, device_commands.doorLCargo, 474)
-- elements["PNT-475"]	= default_2_position_tumb(_("Right Cargo Door"),     devices.MISC, device_commands.doorRCargo, 475)

-- -- M130 CM System
-- elements["PNT-550"]	= default_2_position_tumb(_("Flare Dispenser Mode Cover (Inop.)"), devices.M130, device_commands.cmFlareDispenseModeCover, 550, 8)
-- --cmFlareDispenseMode
-- elements["PNT-552"]	= multiposition_switch_relative(_("Flare Counter"),                      devices.M130, device_commands.cmFlareCounterDial, 552, 10, 1/9, false, 0, 16, true)
-- elements["PNT-553"]	= multiposition_switch_relative(_("Chaff Counter"),                      devices.M130, device_commands.cmChaffCounterDial, 553, 10, 1/9, false, 0, 16, true)
-- elements["PNT-559"]	= default_2_position_tumb(_("Countermeasures Arming Switch"),   devices.M130, device_commands.cmArmSwitch, 559, 8)
-- elements["PNT-560"]	= multiposition_switch(_("Chaff Dispenser Mode Selector"),      devices.M130, device_commands.cmProgramDial, 560, 3, 1/2, false, 0, 16, false)
-- elements["PNT-561"]	= default_button(_("Chaff Dispense"),                           devices.M130, device_commands.cmChaffDispense, 561)
	

-- -- AN/ARC-201 FM1
defineTumb("ARC201_FM1_SEL_PRESET",devices.ARC201_FM1, device_commands.fm1PresetSelector, 	600, 0.01,{0.0,0.07},nil,false,"AN/ARC-201 FM1","AN/ARC-201 FM1 Preset Selector");
defineTumb("ARC201_FM1_SEL_FUNC",devices.ARC201_FM1, device_commands.fm1FunctionSelector, 	601, 0.01,{0.0,0.08},nil,false,"AN/ARC-201 FM1","AN/ARC-201 FM1 Function Selector");
defineTumb("ARC201_FM1_SEL_PWR",devices.ARC201_FM1, device_commands.fm1PwrSelector, 		602, 0.01,{0.0,0.03},nil,false,"AN/ARC-201 FM1","AN/ARC-201 FM1 Mode Selector");
defineTumb("ARC201_FM1_SEL_MODE",devices.ARC201_FM1, device_commands.fm1ModeSelector, 		603, 0.01,{0.0,0.03},nil,false,"AN/ARC-201 FM1","AN/ARC-201 FM1 Mode Selector");
--elements["PNT-604"]	= default_axis_limited(_("AN/ARC-201 (FM1) Volume"),            devices.ARC201_FM1, device_commands.fm1Volume, 604, 0, 0.1, true, false, {0,1})
definePotentiometer("ARC201_FM1_VOL", devices.ARC201_FM1, device_commands.fm1Volume, 		604, {0, 1}, "AN/ARC-201 FM1", "AN/ARC-201 FM1 Volume")

definePushButton("ARC201_FM1_BTN_1", devices.ARC201_FM1, device_commands.fm1Btn1, 605,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 1")
definePushButton("ARC201_FM1_BTN_2", devices.ARC201_FM1, device_commands.fm1Btn2, 606,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 2")
definePushButton("ARC201_FM1_BTN_3", devices.ARC201_FM1, device_commands.fm1Btn3, 607,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 3")
definePushButton("ARC201_FM1_BTN_4", devices.ARC201_FM1, device_commands.fm1Btn4, 608,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 4")
definePushButton("ARC201_FM1_BTN_5", devices.ARC201_FM1, device_commands.fm1Btn5, 609,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 5")
definePushButton("ARC201_FM1_BTN_6", devices.ARC201_FM1, device_commands.fm1Btn6, 6010,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 6")
definePushButton("ARC201_FM1_BTN_7", devices.ARC201_FM1, device_commands.fm1Btn7, 611,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 7")
definePushButton("ARC201_FM1_BTN_8", devices.ARC201_FM1, device_commands.fm1Btn8, 612,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 8")
definePushButton("ARC201_FM1_BTN_9", devices.ARC201_FM1, device_commands.fm1Btn9, 613,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 9")
definePushButton("ARC201_FM1_BTN_0", devices.ARC201_FM1, device_commands.fm1Btn0, 614,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn 0")
definePushButton("ARC201_FM1_BTN_CLR", devices.ARC201_FM1, device_commands.fm1BtnClr, 615,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn CLR")
definePushButton("ARC201_FM1_BTN_ENT", devices.ARC201_FM1, device_commands.fm1BtnEnt, 616,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn ENT")
definePushButton("ARC201_FM1_BTN_FREQ", devices.ARC201_FM1, device_commands.fm1BtnFreq, 617,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn FREQ")
definePushButton("ARC201_FM1_BTN_ERF_OFST", devices.ARC201_FM1, device_commands.fm1BtnErfOfst, 618,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn ERF/OFST")
definePushButton("ARC201_FM1_BTN_TIME", devices.ARC201_FM1, device_commands.fm1BtnTime, 619,  "AN/ARC-201 FM1", "AN/ARC-201 (FM1) Btn TIME")

-- -- AN/ARN-149
-- elements["PNT-620"]	= multiposition_switch(_("AN/ARN-149 PRESET Selector"),     devices.ARN149, device_commands.arn149Preset, 620, 3,  0.5,  false, 0, 100, false)
-- elements["PNT-621"]	= default_3_position_tumb(_("AN/ARN-149 TONE/OFF/TEST"),       devices.ARN149, device_commands.arn149ToneTest, 621, 8)
-- elements["PNT-622"]	= default_axis_limited(_("AN/ARN-149 Volume"),              devices.ARN149, device_commands.arn149Volume, 622, 0, 0.1, true, false, {0,1})
-- elements["PNT-623"]	= default_2_position_tumb(_("AN/ARN-149 TAKE CMD (Inop.)"),    devices.ARN149, device_commands.foo, 623, 8)
-- elements["PNT-624"]	= multiposition_switch(_("AN/ARN-149 POWER Selector"),      devices.ARN149, device_commands.arn149Power, 624, 3,  0.5,  false, 0, 100, false)
-- elements["PNT-625"]	= multiposition_switch(_("AN/ARN-149 1000s Khz Selector"),  devices.ARN149, device_commands.arn149thousands, 625, 3,  0.5,  false, 0, 100, false)
-- elements["PNT-626"]	= multiposition_switch(_("AN/ARN-149 100s Khz Selector"),   devices.ARN149, device_commands.arn149hundreds, 626, 10,  0.1,  false, 0, 100, true)
-- elements["PNT-627"]	= multiposition_switch(_("AN/ARN-149 10s Khz Selector"),    devices.ARN149, device_commands.arn149tens, 627, 10,  0.1,  false, 0, 100, true)
-- elements["PNT-628"]	= multiposition_switch(_("AN/ARN-149 1s Khz Selector"),     devices.ARN149, device_commands.arn149ones, 628, 10,  0.1,  false, 0, 100, true)
-- elements["PNT-629"]	= multiposition_switch(_("AN/ARN-149 .1s Khz Selector"),    devices.ARN149, device_commands.arn149tenths, 629, 10,  0.1,  false, 0, 100, true)

-- -- AN/ARN-147
-- elements["PNT-650"]	= multiposition_switch_relative(_("AN/ARN-147 MHz Selector"), devices.ARN147, device_commands.arn147MHz, 650, 10,  0.1,  false, 0, 100, true)
-- elements["PNT-651"]	= multiposition_switch_relative(_("AN/ARN-147 KHz Selector"), devices.ARN147, device_commands.arn147KHz, 651, 10,  0.1,  false, 0, 100, true)
-- elements["PNT-652"]	= default_2_position_tumb(_("AN/ARN-147 Marker Beacon HI/LO (Inop.)"),  devices.ARN147, device_commands.foo, 652, 8)
-- elements["PNT-653"]	= default_3_position_tumb(_("AN/ARN-147 Power Selector OFF/ON/TEST"),   devices.ARN147, device_commands.arn147Power, 653, 8)

-- -- WIPERS
-- elements["PNT-631"]	= wiper_selector(_("Wipers PARK/OFF/LOW/HI"),   devices.MISC, device_commands.wiperSelector, 631, 4,  0.5,  false, -0.5, 16, false)
-- --elements["PNT-631"]	= multiposition_switch(_("Wipers PARK/OFF/LOW/HI"),   devices.MISC, device_commands.wiperSelector, 631, 4,  0.33,  false, 0, 16, false)

-- -- ARC-201 FM2
defineTumb("ARC201_FM2_SEL_PRESET",devices.ARC201_FM2, device_commands.fm2PresetSelector, 	700, 0.01,{0.0,0.07},nil,false,"AN/ARC-201 FM2","AN/ARC-201 FM2 Preset Selector");
defineTumb("ARC201_FM2_SEL_FUNC",devices.ARC201_FM2, device_commands.fm2FunctionSelector, 	701, 0.01,{0.0,0.08},nil,false,"AN/ARC-201 FM2","AN/ARC-201 FM2 Function Selector");
defineTumb("ARC201_FM2_SEL_PWR",devices.ARC201_FM2, device_commands.fm2PwrSelector, 		702, 0.01,{0.0,0.03},nil,false,"AN/ARC-201 FM2","AN/ARC-201 FM2 Mode Selector");
defineTumb("ARC201_FM2_SEL_MODE",devices.ARC201_FM2, device_commands.fm2ModeSelector, 		703, 0.01,{0.0,0.03},nil,false,"AN/ARC-201 FM2","AN/ARC-201 FM2 Mode Selector");
--elements["PNT-604"]	= default_axis_limited(_("AN/ARC-201 (FM2) Volume"),            devices.ARC201_FM2, device_commands.fm2Volume, 704, 0, 0.1, true, false, {0,1})
definePotentiometer("ARC201_FM2_VOL", devices.ARC201_FM2, device_commands.fm2Volume, 		704, {0, 1}, "AN/ARC-201 FM2", "AN/ARC-201 FM2 Volume")

definePushButton("ARC201_FM2_BTN_1", devices.ARC201_FM2, device_commands.fm2Btn1, 705,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 1")
definePushButton("ARC201_FM2_BTN_2", devices.ARC201_FM2, device_commands.fm2Btn2, 706,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 2")
definePushButton("ARC201_FM2_BTN_3", devices.ARC201_FM2, device_commands.fm2Btn3, 707,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 3")
definePushButton("ARC201_FM2_BTN_4", devices.ARC201_FM2, device_commands.fm2Btn4, 708,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 4")
definePushButton("ARC201_FM2_BTN_5", devices.ARC201_FM2, device_commands.fm2Btn5, 709,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 5")
definePushButton("ARC201_FM2_BTN_6", devices.ARC201_FM2, device_commands.fm2Btn6, 710,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 6")
definePushButton("ARC201_FM2_BTN_7", devices.ARC201_FM2, device_commands.fm2Btn7, 711,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 7")
definePushButton("ARC201_FM2_BTN_8", devices.ARC201_FM2, device_commands.fm2Btn8, 712,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 8")
definePushButton("ARC201_FM2_BTN_9", devices.ARC201_FM2, device_commands.fm2Btn9, 713,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 9")
definePushButton("ARC201_FM2_BTN_0", devices.ARC201_FM2, device_commands.fm2Btn0, 714,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn 0")
definePushButton("ARC201_FM2_BTN_CLR", devices.ARC201_FM2, device_commands.fm2BtnClr, 715,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn CLR")
definePushButton("ARC201_FM2_BTN_ENT", devices.ARC201_FM2, device_commands.fm2BtnEnt, 716,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn ENT")
definePushButton("ARC201_FM2_BTN_FREQ", devices.ARC201_FM2, device_commands.fm2BtnFreq, 717,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn FREQ")
definePushButton("ARC201_FM2_BTN_ERF_OFST", devices.ARC201_FM2, device_commands.fm2BtnErfOfst, 718,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn ERF/OFST")
definePushButton("ARC201_FM2_BTN_TIME", devices.ARC201_FM2, device_commands.fm2BtnTime, 719,  "AN/ARC-201 FM2", "AN/ARC-201 (FM2) Btn TIME")

-- -- CPLT ICP
-- elements["PNT-800"]	= multiposition_switch(_("Copilot ICP XMIT Selector (Inop.)"),            devices.CPLT_ICP, device_commands.copilotICPXmitSelector, 800, 6,  1/5,  false, 0, 16, false)
-- elements["PNT-801"]	= default_axis_limited(_("Copilot ICP RCV Volume (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPSetVolume, 801, 0, 0.1, true, false, {0,1})
-- elements["PNT-802"]	= default_2_position_tumb(_("Copilot ICP Hot Mike (Inop.)"),              devices.CPLT_ICP, device_commands.foo, 802, 8)
-- elements["PNT-803"]	= default_2_position_tumb(_("Copilot ICP RCV FM1 (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleFM1, 803, 8)
-- elements["PNT-804"]	= default_2_position_tumb(_("Copilot ICP RCV UHF (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleUHF, 804, 8)
-- elements["PNT-805"]	= default_2_position_tumb(_("Copilot ICP RCV VHF (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleVHF, 805, 8)
-- elements["PNT-806"]	= default_2_position_tumb(_("Copilot ICP RCV FM2 (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleFM2, 806, 8)
-- elements["PNT-807"]	= default_2_position_tumb(_("Copilot ICP RCV HF (Inop.)"),                devices.CPLT_ICP, device_commands.copilotICPToggleHF, 807, 8)
-- elements["PNT-808"]	= default_2_position_tumb(_("Copilot ICP RCV VOR/LOC (Inop.)"),           devices.CPLT_ICP, device_commands.copilotICPToggleVOR, 808, 8)
-- elements["PNT-809"]	= default_2_position_tumb(_("Copilot ICP RCV ADF (Inop.)"),               devices.CPLT_ICP, device_commands.copilotICPToggleADF, 809, 8)


local dummyAlloc = moduleBeingDefined.memoryMap:allocateString { maxLength = 100 }


BIOS.protocol.endModule()