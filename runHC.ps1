#Location of Arma 3 server exe
$CMD= ''

#Directory of server profile data
$profileDir=''
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

#Restart Sript

$H = Get-Host
$Win = $H.UI.RawUI.WindowSize
$Win.Height = 10
$Win.Width  = 65
$H.UI.RawUI.Set_WindowSize($Win)
#Title of the Powershell/CMD Prompt window
$H.ui.RawUI.WindowTitle = ''

#Set Processor Affinity
#$server.ProcessorAffinity=3840

#When to Restart in HHmmss
$restartTime = 070000
$restartCounter = 0
#If the console window is closed also close the server
Register-EngineEvent PowerShell.Exiting {Stop-Process -id $server.Id}

#Console loop and server restart loop
while ($true) {
    #Get time and convert into Int
    $time = [convert]::ToInt32((Get-Date -Format HHmmss), 10)
    #If between restartTime and restartTime + 10 shut down the server and start after 3 seconds
    if (($time -ge $restartTime) -and ($time -le ($restartTime + 2))) {
        Stop-Process -id $server.Id
        $restartCounter++
        Start-Sleep -Seconds 3
        $server = Start-Process -FilePath $CMD -ArgumentList $args -passthru
		$server.ProcessorAffinity=3840
    }
    #If process is not found shut down the script udpate the window
    if (Get-Process -Id $server.Id){
		Clear-Host
		#Put the name of the server below
		""
        Get-Process -Id $server.Id
        "Amount of times restarted:"+$restartCounter
    } else {
		Clear-Host
		""
		""
		"Server Not Found"
        "Shutting Down."
		Start-Sleep -Seconds 3
        Break
    }
    Start-Sleep -Seconds 1
}