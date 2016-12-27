# Title
**remedia** is an IPA Stata programme that renames SurveyCTO media files. (version 1.1.0)

# Installing remedia:
To install remedia, copy and paste the stata command below into your stata command window and press enter:

`net install remedia, all replace from(https://raw.githubusercontent.com/PovertyAction/remedia/master)`

# Syntax
`remedia varname [if] [in], [by(varlist)] id(varname) enumerator(varname) from(folder) to(folder)resolve(varname)`
    
# Example
* Renaming media files onto one folder: In this scenario, we don’t care about organizing the media files into separate folders. The syntax will be as follows:
    
`remedia audio_audit, id(hhid) enum(enumerator_id) from("X:/Project Folder/Data/scto_csv") to("X:/Project Folder/Data/audio_audit")`

* Renaming into multiple folders: Assume we want to rename audio files by region and district using household id and enumerator id:

`remedia audio_audit, by(region) id(hhid) enum(enumerator_id) from("X:/Project Folder/Data/scto_csv") to("X:/Project Folder/Data/audio_audit")`

# Authors
Ishmail Azindoo Baako (iabaako@poverty-action.org) & 
William Ratcliffe (wratcliffe@poverty-action.org)
