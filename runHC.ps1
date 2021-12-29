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

$args=$profiles + $args

if (($modsArray.length -gt 0) -and ($modsArray[0].length -gt 0)){
    $mods=' -mod=curator;kart;heli;mark;expansion;jets;argo;orange;tacops;tank;enoch;aow;'
    for($i = 0; $i -lt $modsArray.length; $i++){
	    $mods += $modDir + '\' + $modsArray[$i] + ';'
    }
    $args+=$mods
}

$server = Start-Process -FilePath $CMD -ArgumentList $args -passthru