Function EnsureInPath {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=0)]
        [string]$PathToMatch = '',
        [Parameter(Mandatory=$false,Position=1)]
        [switch]$SystemPath = $true
    )
    
    # ensure valid parameter
    if (-not [System.String]::IsNullOrWhitespace($PathToMatch)) {

        # Get path info from PathToMatch parameter
        $pathInfo = Get-Item -Path $PathToMatch | Select-Object -First 1
        $literalPath = $pathInfo.FullName
        $lowerLiteralPath = $literalPath.ToLower()

        # scope path level
        $pathLevel = [System.EnvironmentVariableTarget]::Machine
        if ( -not $SystemPath ) {
            $pathLevel = [System.EnvironmentVariableTarget]::User
        }

        # Get path environmental variable
        $actualPath = [Environment]::GetEnvironmentVariable('Path', $pathLevel)
        $lowerActualPath = $actualPath.ToLower()

        # check path
        if (-not ($lowerActualPath -contains $lowerLiteralPath)) {
            Write-Host "PATH environment variable does not have `'$literalPath`' in it. Adding..."

            # format new path for addition to enviroment variable
            $statementTerminator = ';'
            $hasStatementTerminator = ($actualPath -ne $null) -and ($actualPath.EndsWith($statementTerminator))
            if ((-not $hasStatementTerminator) -and ($actualPath -ne $null)) {
              $literalPath = $statementTerminator + $literalPath
            }

            # update path enviroment variable
            [Environment]::SetEnvironmentVariable('Path', $actualPath + $literalPath, $pathLevel)
        }
    }
}

# ensure chocolatey in path
EnsureInPath "$env:SystemDrive\Chocolatey\bin"

# ensure ruby bin in path
EnsureInPath "$env:SystemDrive\ruby*\bin"

# ensure node and npm in path
EnsureInPath "$env:SystemDrive\Program Files*\nodejs"

# ensure npm app data in path
EnsureInPath "$env:UserProfile\AppData\Roaming\npm"

# ensure chef bin in path
EnsureInPath "$env:SystemDrive\opscode\chef\bin"

# ensure chef embedded bin in path
EnsureInPath "$env:SystemDrive\opscode\chef\embedded\bin"

# ensure git in path
EnsureInPath "$env:SystemDrive\Program Files*\Git\cmd"

# ensure mingw in path
EnsureInPath "$env:SystemDrive\MinGW\bin"

# ensure msys commands (rsync) in path
EnsureInPath "$env:SystemDrive\MinGW\msys\*\bin"