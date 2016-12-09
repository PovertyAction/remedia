
// Sample syntax

use "X:/Box.net/C4D End Line Tracking/data/C4D Endline Child Health Survey.dta", clear

remedia audio_audit 															///
	if audio_consent == 1,														///
	by(hh_reg_name hh_dis_name)													///
	id(hhid) 																	///	
	enum(surveyor_id) 															///
	from("X:/Box.net/C4D End Line Tracking/data/media")							///
	to("X:/Box.net/C4D End Line Tracking/audio_files")							///
	reso(key)

	

