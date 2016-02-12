#requires -version 4
<#
.SYNOPSIS
  <Overview of script>

.DESCRIPTION
  <Brief description of script>

.PARAMETER <Parameter_Name>
  <Brief description of parameter input required. Repeat this attribute if required>

.INPUTS
  <Inputs if any, otherwise state None>

.OUTPUTS Log File
  The script log file stored in C:\Windows\Temp\<name>.log

.NOTES
  Version:        1.0
  Author:         <Name>
  Creation Date:  <Date>
  Purpose/Change: Initial script development

.EXAMPLE
  <Example goes here. Repeat this attribute for more than one example>

  <Example explanation goes here>
#>

#---------------------------------------------------------[Initialisations]--------------------------------------------------------

#Set Error Action to Silently Continue
$ErrorActionPreference = 'SilentlyContinue'

#Import PSLogging Module
Import-Module PSLogging

#----------------------------------------------------------[Declarations]----------------------------------------------------------

#Script Version
$sScriptVersion = '1.0'

#Log File Info
$sLogPath = 'C:\Windows\Temp\Showcase'
$sLogName = 'ShowcaseXML.log'
$sLogFile = Join-Path -Path $sLogPath -ChildPath $sLogName

#Temp List
$sTempList = @()

#-----------------------------------------------------------[Functions]------------------------------------------------------------


Function Get-Files {
  Param (
	  [Parameter(Mandatory = $true)]
      [string] $Path
  )

  Begin {
	Write-LogInfo -LogPath $sLogFile -Message 'Compiling a list of files'
  }

  Process {
	Try {
		$sTempList += Get-ChildItem -Path $Path -Recurse | Select FullName | % {
            Write-LogInfo -LogPath $sLogFile -Message $_
        }    
    }
    Catch {
      Write-LogError -LogPath $sLogFile -Message $_.Exception -ExitGracefully
      Break
    }
  }

  End {
	#When Verbose, this will print out the 
	#A list of paths for files found.
	foreach($r in $sTempList) {
		Write-Host $r.FullName
	}

    If ($?) {
      Write-LogInfo -LogPath $sLogFile -Message 'Completed Successfully.'
      Write-LogInfo -LogPath $sLogFile -Message ' '
    }
  }
}


#-----------------------------------------------------------[Execution]------------------------------------------------------------

Start-Log -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion

#Script Execution goes here
Get-Files -Path "\\asitapps\apps\!Brian GauthierDOCS\Showcase\ShowcaseResults\testFiles"

Stop-Log -LogPath $sLogFile