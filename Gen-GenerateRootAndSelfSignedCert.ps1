# This script generates a self signed root certificate, and then a client certificate from the self signed root certificate.
# These certificates are installed in the local store.
# These certificates are needed when connecting to a VPN gateway in Azure (For example)


# Create a self-signed root certificate. 
param(
    [String]$RootCertificateName = "P2SRootCert",
    [String]$ClientCertificateName = "P2SChildCert",
    [String]$ExportedClientCertPassword = "ClientCertPassword"
)

$params = @{
    Type = 'Custom'
    Subject = "CN=$RootCertificateName"
    KeySpec = 'Signature'
    KeyExportPolicy = 'Exportable'
    KeyUsage = 'CertSign'
    KeyUsageProperty = 'Sign'
    KeyLength = 2048
    HashAlgorithm = 'sha256'
    NotAfter = (Get-Date).AddMonths(24)
    CertStoreLocation = 'Cert:\CurrentUser\My'
}
$rootCert = New-SelfSignedCertificate @params

# Generate a client certificate from the self-signed root certificate, and then export and install the client certificate.
$params = @{
    Type = 'Custom'
    Subject = "CN=$ClientCertificateName"
    DnsName = $ClientCertificateName
    KeySpec = 'Signature'
    KeyExportPolicy = 'Exportable'
    KeyLength = 2048
    HashAlgorithm = 'sha256'
    NotAfter = (Get-Date).AddMonths(18)
    CertStoreLocation = 'Cert:\CurrentUser\My'
    Signer = $rootCert
    TextExtension = @(
     '2.5.29.37={text}1.3.6.1.5.5.7.3.2')
}
$clientCert = New-SelfSignedCertificate @params

$fileNameToUse = "selfSignedRootCertificate.cer"

#Public key only
Write-Host ""
Write-Host "Exporting Public key for Root Certificate: $RootCertificateName"
Export-Certificate -cert $rootCert.PSPath -FilePath $fileNameToUse > $NIL

$cerBytes = Get-Content $fileNameToUse -AsByteStream
$pubKey = [System.Convert]::ToBase64String($cerBytes) 
$pubKeyFileName = "$RootCertificateName.cer"
Set-Content -Path $pubKeyFileName -Value "-----BEGIN CERTIFICATE-----\n$pubKey\n-----END CERTIFICATE-----\n"
Write-Host "Writing Base64 encoded public key for root certificate to file: [$pubKeyFileName]"
Write-Host ""
Write-Host "Public key for Root Certificate: [$RootCertificateName]"
Write-Host $pubKey
Remove-Item $fileNameToUse

#Private key
$fileNameToUse = "$ClientCertificateName.pfx"
Write-Host ""
Write-Host "Exporting Client Certificate with private key to file: [$fileNameToUse]"

$pfxPwd = ConvertTo-SecureString -String $ExportedClientCertPassword -Force -AsPlainText
Export-PfxCertificate -cert $clientCert.PSPath -FilePath "$fileNameToUse" -Password $pfxPwd  > $NIL
Write-Host "Exported Client certificate [$fileNameToUse] using password: [$ExportedClientCertPassword]"
#$pfxBytes = Get-Content "$fileNameToUse" -AsByteStream
#[System.Convert]::ToBase64String($pfxBytes) | Out-File "$ClientCertificateName.txt"



