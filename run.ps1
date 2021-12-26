#Location of Arma 3 server exe
$CMD= ''

#Directory of server profile data
$profileDir=''
#Details on this folder can be found here:
#https://community.bistudio.com/wiki/server.cfg
$profiles='"-config=' + $profileDir + 'server.cfg"'
#Details on this folder can be found here:
#https://community.bistudio.com/wiki/basic.cfg
$profiles+='"-cfg=' + $profileDir + 'basic.cfg"'
#Setting the directory of server profile data.
#This is the directory that contains all the server logs
$profiles+='"-profiles=' + $profileDir + '"'

#Parameters for the server
#All parameters can be found here
#https://community.bistudio.com/wiki/Arma_3_Startup_Parameters
$args=''

#Change mod directory to Workshop folder
$modDir=''

#Add mods from Worksop folder to the server startup
$mods=' "-mod=argo;curator;heli;jets;kart;mark;orange;'
$mods+= $modDir + '' + ';'
$mods+= '"'

#Add mods from Worksop folder to the server startup
#$modDir='C:\Program Files (x86)\Steam\steamapps\common\Arma 3\!Workshop\'

$mods+= ' "-serverMod='
$mods+= $modDir + '' + ';'
$mods+= '"'

$args=$profiles + $args
$args+=$mods

$server = Start-Process -FilePath $CMD -ArgumentList $args -passthru

#Set Processor Affinity
#$server.ProcessorAffinity=3840
