# usage ./check_response.ps1 -w 1000 -url https://google.com


Param(
   [Parameter(Position=1)]
   [string]$w,
  
   [Parameter(Position=2)]
   [string]$url 
)




# track execution time:
$timeTaken = Measure-Command -Expression {
  $site = Invoke-WebRequest -Uri $url -UseBasicParsing
}

$milliseconds = $timeTaken.TotalMilliseconds

$milliseconds = [Math]::Round($milliseconds, 1)

#"This took $milliseconds ms to execute"

if ($milliseconds -lt "$w") { "OK $milliseconds ms to execute |  reponse=$milliseconds" ; exit 0 }
if ($milliseconds -gt "$w") { "Critical $milliseconds ms to execute |  reponse=$milliseconds" ; exit 2 }

