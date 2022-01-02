#Location of Arma 3 server exe
$CMD= ''

#Directory of server profile data
$profileDir=''

#Parameters for the server
#All parameters can be found here
#https://community.bistudio.com/wiki/Arma_3_Startup_Parameters
$args=''

#Change mod directory to Workshop folder
$modDir=''

#Add mods from Worksop folder to the server startup
$modsArray = @(
	''
)

#Add mods from Worksop folder to the server startup
#$modDir='C:\Program Files (x86)\Steam\steamapps\common\Arma 3\!Workshop\'

$serverModArray = @(
    ''
)

#You don't have to edit beyond this point

#Details on this folder can be found here:
#https://community.bistudio.com/wiki/server.cfg
$serverCfg='"-config=' + $profileDir + '\config\server.cfg"'

#Details on this folder can be found here:
#https://community.bistudio.com/wiki/basic.cfg
$basicCfg='"-cfg=' + $profileDir + '\config\basic.cfg"'

#Setting the directory of server profile data.
#This is the directory that contains all the server logs
$profiles='"-profiles=' + $profileDir + '"'

$args=$profiles + ' ' + $serverCfg+ ' ' + $basicCfg

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


if (($modsArray.length -gt 0) -and ($modsArray[0].length -gt 0)){
    $mods=' -mod=curator;kart;heli;mark;expansion;jets;argo;orange;tacops;tank;enoch;aow;'
    for($i = 0; $i -lt $modsArray.length; $i++){
	    $mods += $modDir + '\' + $modsArray[$i] + ';'
    }
    $args+=$mods
}

if (($serverModArray.length -gt 0) -and ($serverModArray[0].length -gt 0)){
    $serMods= ' -serverMod='
    for($i = 0; $i -lt $serverModArray.length; $i++){
	    $serMods+= $modDir + '\' + $serverModArray[$i] + ';'
    }
    $args+=$serMods
}

$server = Start-Process -FilePath $CMD -ArgumentList $args -passthru

#Set Processor Affinity
#$server.ProcessorAffinity=3840