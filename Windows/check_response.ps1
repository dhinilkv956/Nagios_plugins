$url = 'https://saturnme.com'

# track execution time:
$timeTaken = Measure-Command -Expression {
  $site = Invoke-WebRequest -Uri $url -UseBasicParsing
}

$milliseconds = $timeTaken.TotalMilliseconds

$milliseconds = [Math]::Round($milliseconds, 1)

#"This took $milliseconds ms to execute"

if ($milliseconds -lt "3000") { "OK $milliseconds ms to execute |  reponse=$milliseconds" ; exit 0 }
if ($milliseconds -gt "4000") { "Critical $milliseconds ms to execute |  reponse=$milliseconds" ; exit 2 }
if ($milliseconds -eq "UNKNOWN") { "unknown" ; exit 3 }
