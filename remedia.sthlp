{smcl}
{com}{sf}{ul off}{res}
{title:Title}


{col 5}remedia - Rename SurveyCTO media files


{title:Syntax}

{col 5}remedia {var:} {help if:[if]} {help in:[in]}, [{ul:by}({varlist:})] {ul:id}(varname) {ul:enum}erator(varname) {ul:from}(folder) {ul:to}(folder){ul:reso}lve(varname)


{it:options}{col 25}{it:description}
{hline}

{ul:by}{col 25}sorting variables
{ul:id}{col 25}id variable
{ul:enum}erator{col 25}enumerator variable
{ul:from}{col 25}source folder of media files
{ul:to}{col 25}primary destination folder of media files
{ul:reso}lve{col 25}variable for resolving duplicates on id


{title:Description}

{col 5}remedia is a user written stata command that renames and organizes SurveyCTO media files. This includes audio, video and image files


{title:Options}
{col 5}by(varlist) sorts the data and creates folders and sub-folders using the variables specified. The maximum number of variables allowed in by is 3. If by is not specified,
{col 10}all media files will be logged into the primary destination folder specified in to(). Note that if the by() variables cointains missing variables some of the media
{col 10}files will not be saved into the expected folders. If the variabels specified with by() contain characters such as "/","\" and ":" remedia will replace them with "_" when
{col 10}creating folders.

{col 5}id(varname) specifies the id variable of the dataset will be used to label the media files. If the id variable is not unique to the observations in the dataset remedia will
{col 10}throw and error and require that option resolve() be specified. Common id variables include hhid,plot_id and respondent_id

{col 5}enumerator(varname) specifies the enumerator variable for the dataset. This variable, together with the id variable will be used as the new name of the media file in the destination
{col 10}folder. Note that remedia uses the values and not the labels of the variables, so if you require that the media files be renamed using the variable label then enumerator() must be
{col 10}a string variable containing the names of the enumerators

{col 5}from(folder) specifies the folder path that contains the SurveyCTO media files. Note that SurveyCTO sync will create a folder named media in you main data folder that the csv files.
{col 10}Specify this folder with from(). For instance from("X:/Project Folder/Data Folder/scto_scv/media")

{col 5}to(folder) specifies the main destination folder path. if by is specified, additional sub folders will be created and media files saved to it

{col 5}resolve(varname) specifies the variable to be used in resolving duplicates on id. This is only required if the dataset in memory is duplicate on the id variable specified with id()
{col 10}If the variable specified with resolve is string, characters such as "/","\" and ":" will be replaced with "_" when used in the file name.

{title:Remarks}

{col 5}remedia is useful in renaming surveycto media files and saving them into folders


{title:Examples}

{col 5}Assume we want to rename audio files by region and district using household id and enumerator id
{col 10}remedia audio_audit ///
{col 15}if audio_consent == 1, ///
{col 15}by(region district) ///
{col 15}id(hhid) ///
{col 15}enum(enumerator_id) ///
{col 15}from("X:/Project Folder/Data/scto_csv") ///
{col 15}to("X:/Project Folder/Data/scto_csv")


{title:Authors}

{browse "mailto:iabaako@poverty-action.org":Ishmail Azindoo Baako}
{browse "mailto:wratcliffe@poverty-action.org":William Ratcliffe}

Kindly Email {browse "mailto:researchsupport@poverty-action.org":IPA Research Support} with issues, suggestion and comments
{smcl}
{res}{sf}{ul off}