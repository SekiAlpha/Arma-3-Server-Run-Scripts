#Location of Arma 3 server exe
$CMD= ''

#Directory of server profile data
$profileDir=''

#Parameters for the server
#All parameters can be found here
#https://community.bistudio.com/wiki/Arma_3_Startup_Parameters
$args='-client'

#Change mod directory to Workshop folder
$modDir=''

#Add mods from Worksop folder to the server startup
$modsArray = @(
	''
)

#You don't have to edit beyond this point

#Setting the directory of server profile data.
#This is the directory that contains all the server logs
$profiles+='"-profiles=' + $profileDir + '"'

#Detection if all required directories exist

if (($CMD -eq '') -or ($profileDir -eq  '') -or ($modDir -eq '')){
    Read-Host "Looks like some variables have been left empty. Press enter to close the program"
    Exit
}

if (-not (Test-Path $CMD -PathType leaf)){
    Read-Host "Looks like the location of the arma 3 exe was not found. Press enter to close the program"
    Exit
}
if (-not (Test-Path $profileDir -PathType container)){
    Read-Host "Looks like the profileDir value you entered isn't a folder. Press enter to close the program"
    Exit
}
if (-not (Test-Path $modDir -PathType container)){
    Read-Host "Looks like the modDir value you entered isn't a folder. Press enter to close the program"
    Exit
}
if (-not (Test-Path ($profileDir + '\config') -PathType container)){
    Read-Host "Looks like the profile directory value you entered doesn't have a config folder. Press enter to close the program"
    Exit
}

#Sets the location of the parameter file
$paramFile=$profileDir+'\config\parameters.par'
#Combines and formats all the mods to be parsed into the parameter file
$paramFileArgs= 'class Arg {'

if (($modsArray.length -gt 0) -and ($modsArray[0].length -gt 0)){
    $mods='-mod=curator;kart;heli;mark;expansion;jets;argo;orange;tacops;tank;enoch;aow;'
    for($i = 0; $i -lt $modsArray.length; $i++){
	    $mods += $modDir + '\' + $modsArray[$i] + ';'
    }
    $paramFileArgs+= 'mods="' + $mods + '";'
}

$paramFileArgs+= '};'

#parses mods into parameter file
Set-Content -Path $paramFile -Value $paramFileArgs

$args += ' -par=' + $paramFile

$server = Start-Process -FilePath $CMD -ArgumentList $args -passthru