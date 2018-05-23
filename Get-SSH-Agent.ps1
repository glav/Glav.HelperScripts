#############################################
# This simple script will attempt to
# get the SSH Agent process and set SSH specific
# environment variables for the SSH_AGENT_PID and
# SSH_AUTH_SOCK. This should hopefully stop Git
# asking for a passphrase all the damn time.
#############################################
 


function Get_agent
{
    $agent = Get-Process ssh-agent -ErrorAction Ignore | select -Last 1
    return $agent
}

$agentProcess = Get_agent

if (!$agentProcess)
{
    Write-Output "Starting SSH-Agent"
    &Start-SshAgent
    $agentProcess = Get_agent
}

$agent = Get-ChildItem "$env:temp/ssh-*" | select -Last 1 | Get-Childitem
$env:SSH_AUTH_SOCK="/tmp/" + (Split-Path -Path $agent.Directory -Leaf) + "/" + $agent.Name
$env:SSH_AGENT_PID=$agentProcess.Id


