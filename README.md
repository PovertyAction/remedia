# remedia
Stata program to rename SurveyCTO media files.


# help file

<pre>
<p>
<b><u>Title</u></b>
<p>
<p>
    remedia - Rename SurveyCTO media files
<p>
<p>
<b><u>Syntax</u></b>
<p>
    remedia <i>varname</i> [if] [in], [<u>by</u>(<i>varlist</i>)] <u>id</u>(varname) <u>enum</u>erator(varname) <u>fr</u>
<u>&gt; om</u>(folder) <u>to</u>(folder)<u>reso</u>lve(varname)
<p>
<p>
<i>options</i>                 <i>description</i>
-------------------------------------------------------------------------------
<p>
<u>by</u>                      sorting variables
<u>id</u>                      id variable
<u>enum</u>erator              enumerator variable
<u>from</u>                    source folder of media files
<u>to</u>                      primary destination folder of media files
<u>reso</u>lve                 variable for resolving duplicates on id
<p>
<p>
<b><u>Description</u></b>
<p>
    remedia is a user written stata command that renames and organizes SurveyCT
&gt; O media files. This includes audio, video and image files
<p>
<p>
<b><u>Options</u></b>
    by(varlist) sorts the data and creates folders and sub-folders using the va
&gt; riables specified. The maximum number of variables allowed in by is 3. If by 
&gt; is not specified,
         all media files will be logged into the primary destination folder spe
&gt; cified in to(). Note that if the by() variables cointains missing variables s
&gt; ome of the media
         files will not be saved into the expected folders. If the variabels sp
&gt; ecified with by() contain characters such as "/","\" and":" remedia will repl
&gt; ace them with "_" when
         creating folders.
<p>
    id(varname) specifies the id variable of the dataset will be used to label 
&gt; the media files. If the id variable is not unique to the obaservations in the
&gt;  dataset remedia will
         throw and error and require that option resolve() be specified. Common
&gt;  id variables include hhid,plot_id and respondent_id
<p>
    enumerator(varname) specifies the enumerator variable for the dataset. This
&gt;  variable, together with the id variable will be used as the new name of the 
&gt; media file in the destination
         folder. Note that remedia uses the values and not the labels of the va
&gt; riables, so if you require that the media files be renamed using the variable
&gt;  label then enumerator() must be
         a string variable containing the names of the enumerators
<p>
    from(folder) specifies the folder path that contains the SurveyCTO media fi
&gt; les. Note that SurveyCTO sync will create a folder named media in you main da
&gt; ta folder that the csv files.
         Specify this folder with from(). For instance from("X:/Project Folder/
&gt; Data Folder/scto_scv/media")
<p>
    to(folder) specifies the main destination folder path. if by is specified, 
&gt; additional sub folders will be created and media files saved to it
<p>
    resolve(varname) specifies the variable to be used in resolving duplicates 
&gt; on id. This is only required if the dataset in memory is duplicate on the id 
&gt; variable specified with id()
    If the variable specified with resolve is string, characters such as "/","\
&gt; " and":" will be replaced with "_" when used in the file name.
<p>
<b><u>Remarks</u></b>
<p>
    remedia is useful in renaming surveycto media files and saving them into fo
&gt; lders
<p>
<p>
<b><u>Examples</u></b>
<p>
    Assume we want to rename audio files by region and district using household
&gt;  id and enumerator id
         remedia audio_audit ///
              if audio_consent == 1, ///
              by(region district) ///
              id(hhid)
              enum(enumerator_id)
              from("X:/Project Folder/Data/scto_csv")
              to("X:/Project Folder/Data/scto_csv")
<p>
<p>
<b><u>Authors</u></b>
<p>
Ishmail Azindoo Baako
William Ratcliffe
<p>
Kindly Email IPA Research Support with issues, suggestion and comments
</pre>