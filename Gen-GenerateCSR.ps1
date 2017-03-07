#Generate a CSR for use by AppService
#See https://docs.microsoft.com/en-us/azure/app-service-web/web-sites-configure-ssl-certificate#bkmk_certreq

param ([string]$domainName)#, [string]$organisationalUnit, [string]$organisation, [string]$countryCode)

if ($domainName -eq "") {# -or $organisationalUnit -eq "" -or $organisation -eq "" -or $countryCode -eq "") {
    Write-Host "Must specify a domain name. eg. 'contoso.com'"#, organisationalUnit eg. 'Admin', organisation eg. 'Conntoso', and countryCode eg. 'AU'"
    return;
}


#$fileContent = '
#[NewRequest]
# Subject = "CN='+$domainName+', OU='+$organisationalUnit+', O='+$organisation+', C='+$countryCode+'"  ; E.g. "CN=www.contoso.com", or "CN=*.contoso.com" for a wildcard certificate
# Exportable = TRUE
# KeyLength = 2048              ; Required minimum is 2048
# KeySpec = 1
# KeyUsage = 0xA0
# MachineKeySet = FALSE
# ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
# ProviderType = 12
# HashAlgorithm = SHA256

# [EnhancedKeyUsageExtension]
# OID=1.3.6.1.5.5.7.3.1         ; Server Authentication
# '

$fileContent = '
[NewRequest]
 Subject = "CN='+$domainName+'"  ; E.g. "CN=www.contoso.com", or "CN=*.contoso.com" for a wildcard certificate
 Exportable = TRUE
 KeyLength = 2048              ; Required minimum is 2048
 KeySpec = 1
 KeyUsage = 0xA0
 MachineKeySet = FALSE
 ProviderName = "Microsoft RSA SChannel Cryptographic Provider"
 ProviderType = 12
 HashAlgorithm = SHA256

 [EnhancedKeyUsageExtension]
 OID=1.3.6.1.5.5.7.3.1         ; Server Authentication
 '

 function removeFile($filename) {
     if (Test-Path $filename) {
        Remove-Item $filename
     }
 }

 removeFile('csr-details.txt')
 removeFile('csr-request.csr')

 
 Write-host "Generating CSR details for domain:" $domainName
  
 Add-Content 'csr-details.txt' $fileContent

 & certreq -new csr-details.txt csr-request.csr

 #Remove-Item 'csr-details.txt'

 Write-host "Generated CSR for domain: ["$domainName"] in file: csr-request.csr"

 

