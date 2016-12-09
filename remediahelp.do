// This is to write a helpfile for remedia and log to smcl format

qui {

	cap log close
	log using "remedia.sthlp", replace
	local q """
	
	noi di
	noi di "{title:Title}"
	noi di
	noi di
	
	noi di _column(5) "remedia - Rename SurveyCTO media files"
	noi di
	noi di
	
	noi di "{title:Syntax}"
	noi di
	noi di _column(5) "remedia {var:} {help if:[if]} {help in:[in]}, [" "{ul:by}" "({varlist:})] " "{ul:id}" "(varname) " "{ul:enum}" "erator(varname) " "{ul:from}" "(folder) " "{ul:to}" "(folder)" "{ul:reso}" "lve(varname)"
	noi di
	noi di
	
	
	noi di "{it:options}" _column(25) "{it:description}"
	noi di "{hline}"
	noi di
	noi di "{ul:by}" _column(25) "sorting variables"
	noi di "{ul:id}" _column(25) "id variable"
	noi di "{ul:enum}" "erator" _column(25) "enumerator variable"
	noi di "{ul:from}" _column(25) "source folder of media files"
	noi di "{ul:to}" _column(25) "primary destination folder of media files"
	noi di "{ul:reso}" "lve" _column(25) "variable for resolving duplicates on id"
	
	
	noi di
	noi di
	noi di "{title:Description}"
	noi di
	noi di _column(5) "remedia is a user written stata command that renames and organizes SurveyCTO media files. This includes audio, video and image files"
	noi di
	
	noi di 
	noi di "{title:Options}"
	noi di _column(5) "by(varlist) sorts the data and creates folders and sub-folders using the variables specified. The maximum number of variables allowed in by is 3. If by is not specified," 
	noi di _column(10) "all media files will be logged into the primary destination folder specified in to(). Note that if the by() variables cointains missing variables some of the media" 
	noi di _column(10) "files will not be saved into the expected folders. If the variabels specified with by() contain characters such as " `"`q'"' "/" `"`q'"' "," `"`q'"' "\" `"`q'"' " and " `"`q'"' ":" `"`q'"' " remedia will replace them with " `"`q'"' "_" `"`q'"' " when"
	noi di _column(10) "creating folders."
	
	noi di 
	noi di _column(5) "id(varname) specifies the id variable of the dataset will be used to label the media files. If the id variable is not unique to the observations in the dataset remedia will"
	noi di _column(10) "throw and error and require that option resolve() be specified. Common id variables include hhid,plot_id and respondent_id"
	
	noi di
	noi di _column(5) "enumerator(varname) specifies the enumerator variable for the dataset. This variable, together with the id variable will be used as the new name of the media file in the destination"
	noi di _column(10) "folder. Note that remedia uses the values and not the labels of the variables, so if you require that the media files be renamed using the variable label then enumerator() must be"
	noi di _column(10) "a string variable containing the names of the enumerators"
	
	noi di
	noi di _column(5) "from(folder) specifies the folder path that contains the SurveyCTO media files. Note that SurveyCTO sync will create a folder named media in you main data folder that the csv files."
	
	noi di _column(10) "Specify this folder with from(). For instance from(" `"`q'"' "X:/Project Folder/Data Folder/scto_scv/media" `"`q'"' ")"
	
	noi di
	noi di _column(5) "to(folder) specifies the main destination folder path. if by is specified, additional sub folders will be created and media files saved to it" 
	
	noi di
	noi di _column(5) "resolve(varname) specifies the variable to be used in resolving duplicates on id. This is only required if the dataset in memory is duplicate on the id variable specified with id()" 
	noi di _column(5) "If the variable specified with resolve is string, characters such as " `"`q'"' "/" `"`q'"' "," `"`q'"' "\" `"`q'"' " and " `"`q'"' ":" `"`q'"' " will be replaced with " `"`q'"' "_" `"`q'"' " when used in the file name." 
	noi di
	noi di "{title:Remarks}"
	noi di
	noi di _column(5) "remedia is useful in renaming surveycto media files and saving them into folders"
	
	noi di
	noi di
	noi di "{title:Examples}"
	noi di
	noi di _column(5) "Assume we want to rename audio files by region and district using household id and enumerator id"
	noi di _column(10) "remedia audio_audit ///"
	noi di _column(15) "if audio_consent == 1, ///"
	noi di _column(15) "by(region district) ///"
	noi di _column(15) "id(hhid)"
	noi di _column(15) "enum(enumerator_id)"
	noi di _column(15) "from(" `"`q'"' "X:/Project Folder/Data/scto_csv" `"`q'"' ")"
	noi di _column(15) "to(" `"`q'"' "X:/Project Folder/Data/scto_csv" `"`q'"' ")"

	noi di
	noi di
	noi di "{title:Authors}"
	noi di
	noi di `"{browse "mailto:iabaako@poverty-action.org":Ishmail Azindoo Baako}"'
	noi di `"{browse "mailto:wratcliffe@poverty-action.org":William Ratcliffe}"'
	noi di
	noi di "Kindly Email " `"{browse "mailto:researchsupport@poverty-action.org":IPA Research Support}"' " with issues, suggestion and comments"
	log close
	
}
	
