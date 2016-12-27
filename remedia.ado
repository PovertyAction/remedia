*! Version 1.1.0 Ishmail Azindoo Baako (IPA) Dec 27, 2016

/* This program copies scto media files from the data source folder to a new folder
		and renames them using variables specified. 
		Please note the following for this current version of remedia.
			1. Uses values not labels.
			2. Can log in up to three layers of subfolders specified with BY.
			3. Uses id and enumerator to label the new media file.
			
			* Version 1.1.0 handles issues of missing data from the local storage

*/

cap version 13

program define remedia

	syntax varname(string) 		/*media variable*/								///
		[if] [in], 				/*Condistions*/									///
		[BY(varlist)] 			/*Variables for sorting media files*/			///
		id(varname) 			/*ID variable*/									///
		ENUMerator(varname) 	/*Enumerator Variable*/							///
		from(string) 			/*Data Source Folder*/							///
		to(string) 				/*Media Destination Folder*/					///
		[RESOlve(varname)]		/*Required if id var has dups*/
	
	qui {
		
		tempvar uid_dup fname mf_valid mf_miss
		
		/***********************************************************************
		Check syntax, source and destination folders
		***********************************************************************/
	
		// Check that dataset has observations
		if (_N==0) {
			noi di as err "No Observation"
			err 2000
		}
			
		// Check that media variable contains at least one non missing value
		cap assert mi(`varlist')
			if !_rc {
				noi di error "`varlist' has all missing values"
				err 2000
			}
		
		// Preserve original data set
		preserve
		
		// Apply [in] and [if] condition		
		if !mi("`in'") {
			keep `in'
		}
		
		if !mi("`if'") { 
			keep `if' 
		}
		
		// Drop observation without media
		drop if mi(`varlist')
		
		// Check that id variable is unique
		cap isid `id'
			if _rc == 459 {
				noi di in red "{p} Warning: The variable `id' does not uniquely identify observations with non missing values for `varlist'{smcl}"
				duplicates tag `id', gen (`uid_dup')
				
				if !mi("`resolve'") {
					cap isid `id' `resolve'
					if !_rc {
						noi di "{p} Media files with duplicate `id' will be resolved using the variable `resolve'. {smcl}"

						decap `resolve'
					}
					
					else {
						noi di as err "{p} resolve error: The variables `id' and `resolve' do not uniquely identify observations with non missing values for `varlist'. {smcl}"
						exit 459
					}
				}
				
				// Stop and insist the user specifies option resolve
				else {
					noi di as err "resolve option required"
					exit 198
				}
			}
			
			else {
				gen `uid_dup' = 0
			}
				
		// Check that source and destination folders exist
		
		foreach path in "`from'" "`to'" {
			cap confirm file "`path'/nul"
				if _rc == 601 {
					di in red "Folder `path' not found"
					exit 601
				}
		}
		
		
		// Check that the variables in by are 3 or less
		
		if !mi("`by'") {
			local bycount: word count `by'
			if `bycount' > 3 {	
				noi di in red "Too many variables specified with option by, Max is 3"
				exit 103
			}

			forval bynum = 1/`bycount' {
				local fvar: word `bynum' of `by'
				
				// Check that the by() vars have no missing values and warn user if otherwise
				cap assert !mi(`fvar') if !mi(`varlist')
					if _rc {
						noi di in red "Warning: `fvar' has missing values. Some Media Files will be logged to wrong folders"
					}
				
					decap `fvar'
				}

		}		
		
		noi di in green "This might take a while, please wait ..."

		/***********************************************************************
		Create Destination subfolders using the varlist in option BY
		***********************************************************************/

		gen `fname' = ""
		// Set the folder destination path as destination for media if by() is not specified
		
		if mi("`by'") {
			replace `fname' = "`to'"
		}
		
		// Else Create Folder Names from var1 in by()
		
		else {
		
			local fvar1: word 1 of `by'
			tostring `fvar1', force replace
					
			levelsof `fvar1', local (fvar1_levels)
				foreach level in `fvar1_levels' {		
					cap confirm file "`to'/`level'/nul"
						if _rc == 601 {
							mkdir "`to'/`level'"
						}
					
					// Replace fname with destination path
					replace `fname' = "`to'/`level'" if `fvar1' == "`level'"
				
					// Create subfolders from var 2 in by()
					if `bycount' >= 2 {
						local fvar2: word 2 of `by'
						tostring `fvar2', force replace
						
						levelsof `fvar2' if `fvar1' == "`level'", local (fvar2_levels)
							foreach level2 in `fvar2_levels' {
						
								cap confirm file "`to'/`level'/`level2'/nul"
									if _rc == 601 {
										mkdir "`to'/`level'/`level2'"
									}
							
								// Replace fname with destination path
								replace `fname' = "`to'/`level'/`level2'" if `fvar2' == "`level2'" & `fvar1' == "`level'"							

									// Create subfolders from var3 in by()
								
									if `bycount' ==3 {
										local fvar3: word 3 of `by'
										tostring `fvar3', force replace
									
										levelsof `fvar3' if `fvar2' == "`level2'" & `fvar1' == "`level'", local (fvar3_levels)
							
											foreach level3 in `fvar3_levels' {
							
												cap confirm file "`to'/`level'/`level2'/`level3'/nul"
												if _rc == 601 {
													mkdir "`to'/`level'/`level2'/`level3'"
												}
											
												// Replace fname with destination path
												replace `fname' = "`to'/`level'/`level2'/`level3'" if `fvar3' == "`level3'" & ///
													`fvar2' == "`level2'" & `fvar1' == "`level'"
												}
									}
							}
					}
				}
			}
			/*******************************************************************
			Log Media Files into respective folders
			*******************************************************************/
		
			gen `mf_valid' = substr(`varlist', 1, 5) == "media"
			
			// remove "media/" from the media name
			replace `varlist' = subinstr(`varlist', "media\", "", .)
			
			// Get the media file type
			local mf_ext_check = `varlist'[1]
			
			local tmp_ext ".3gpp .jpg .jpeg .png .gif"
			local ext_full_cnt: word count of `tmp_ext'
			local ext_cnt 0
			local loop_break 0
			
			while `loop_break' == 0 & `ext_cnt' <= `ext_full_cnt' {
				local ++ext_cnt
				local tmp_ext_check: word `ext_cnt' of `tmp_ext'
				if regexm("`mf_ext_check'", "`tmp_ext_check'") {
					local mf_ext "`tmp_ext_check'"
					local loop_break 1
				}
			}

			if mi("`mf_ext'") {
				noi di in red "Media type must be 3GPP, JPG , JPEG, GIF or PNG"
				exit 198
			}	
				local mf_track 0
				local uid_track 0
				local mf_miss_track	0											
				gen int `mf_miss' = 0												
				
				local N = _N
				forval mf = 1/`N' {
					local mf_copy = `mf_valid'[`mf']
						if `mf_copy' == 1 {
							local mf_id = `id'[`mf']
							local mf_enum = `enumerator'[`mf']
							local mf_sav = `fname'[`mf']
							local mf_file = `varlist'[`mf']
							
							local mf_dup = `uid_dup'[`mf']
							
							if `mf_dup' == 0 {
								cap confirm file "`mf_sav'/`mf_id'_`mf_enum'`mf_ext'"
									if _rc == 601 {
										cap copy "`from'/`mf_file'" "`mf_sav'/`mf_id'_`mf_enum'`mf_ext'", replace														
											if _rc == 601 {
												replace `mf_miss' = 1 if `id' == "`mf_id'" & `varlist' == "`mf_file'"
												local ++mf_miss_track
											}
											
											else if !_rc {
												local ++mf_track
											}
									}
							}
							
							else {
								local uid_key = `resolve'[`mf'] 
								cap confirm file "`mf_sav'/`mf_id'_`mf_enum'_`uid_key'`mf_ext'"
									if _rc == 601 {
										copy "`from'/`mf_file'" "`mf_sav'/`mf_id'_`mf_enum'_`uid_key'`mf_ext'", replace				
										local ++uid_track
									}
							}
						}
				}
		
		
				noi di in green "`mf_track' Media Files Logged"
				if `uid_track' > 0 {
					noi di "`uid_track' Media Files Duplicate on `id'. Differences resolved using variable `resolve'"
				}
		
			tempfile mf_temp
			save `mf_temp' 
			
			drop if `mf_valid'
			if _N > 0 {
		
				noi di as result _N as text in red " missing media file(s) from SurveyCTO server"
				noi di "id" _column(20) "enumerator"
			
				forval mf = 1/`N' {
				
					local mf_id = `id'[`mf']
					local mf_enum = `enumerator'[`mf']
					noi di "`mf_id'" _column(20) "`mf_enum'"

				}
			
			}
			
			use `mf_temp', clear
			drop if !`mf_miss' | !mi(`mf_miss')
			if _N > 0 {
			
				noi di as result _N as text in red " missing media files from directory (`to')"
				noi di "id" _column(20) "enumerator" 
				
				local N = _N
				forval mf = 1/`N' {
				
					local mf_id = `id'[`mf']
					local mf_enum = `enumerator'[`mf']
					noi di "`mf_id'" _column(20) "`mf_enum'"
				}
		
			}
			
		restore
	}
		
end

program decap 

qui {
	
	// Replace char ":", "/", "\" with "_" if resolve variable is string			
	args tmp_dv

	cap confirm string var `tmp_dv'
		if !_rc {
			replace `tmp_dv' = subinstr(`tmp_dv', "/", "_", .)
			replace `tmp_dv' = subinstr(`tmp_dv', "\", "_", .)
			replace `tmp_dv' = subinstr(`tmp_dv', ":", "_", .)
		}
	}
end






