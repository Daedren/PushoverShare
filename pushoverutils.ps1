$variables = Get-Content -Path $PSScriptRoot\pushVars.txt

$apiKey = $variables[1]
$userKey = $variables[0]
function sendNotification {
	param (
		[Parameter(Mandatory=$true)][string]$device,
		[Parameter(Mandatory=$true)][string]$message,
		[Parameter(Mandatory=$false)][uri]$url,
		[Parameter(Mandatory=$true)][string]$currentDevice
	)
	[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

	$Body = @{
		device = $device
		title = $currentDevice
		message = $message
		token = $apiKey
		user = $userKey
	}

		if($url) {
			$Body.Add("url", $url)
			$Body.Add("url_title", 'Link')
		}

	$Body
	

	$LoginResponse = Invoke-WebRequest 'https://api.pushover.net/1/messages.json' -Body $Body -Method 'POST'
	$LoginResponse
}
