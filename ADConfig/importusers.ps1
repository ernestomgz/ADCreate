param
(
    [string]$DomainName = "example.local",
    [string]$UsersCSV = "./users.csv",
    [string]$GroupsCSV = "./groups.csv"
)

# wait until we can access the AD. this is needed to prevent errors like:
#   Unable to find a default server with Active Directory Web Services running.
Write-Output "Waiting for the AD to become available... (Can take a long time)"
while ($true) {
    try {
        Get-ADDomain | Out-Null
        break
    } catch {
        Start-Sleep -Seconds 10
    }
}

# Import groups from CSV
$ADGroups = Import-csv $GroupsCSV
Write-Output "Creating Groups..."
foreach ($Group in $ADGroups) {
    if (Get-ADGroup -Filter { Name -eq $Group.Name }) {
        $GroupName = $Group.Name
        Write-Warning "A group account with name $GroupName already exist in Active Directory."
    }
    else {
        $NewGroupParams = @{
            Name        = $Group.Name
            Description = $Group.Description
            GroupScope  = $Group.GroupScope
        }
        New-ADGroup @NewGroupParams
    }
}

# Import users from CSV
$ADUsers = Import-csv $UsersCSV
Write-Output "Creating Users..."
foreach ($User in $ADUsers)
{
    $Username = "$($User.first.SubString(0,1)).$($User.last)".toLower()

    #Check to see if the user already exists in AD
    if (Get-ADUser -F { SamAccountName -eq $Username })
    {
        Write-Warning "A user account with username $Username already exist in Active Directory."
    }
    else
    {
        New-ADUser `
            -SamAccountName $Username `
            -UserPrincipalName "$Username@$domainName" `
            -Name "$( $User.first ) $( $User.last )" `
            -GivenName $User.first `
            -Surname $User.last `
            -Enabled $True `
            -DisplayName "$( $User.first ) $( $User.last )" `
            -AccountPassword (convertto-securestring "Foo_b_ar123!" -AsPlainText -Force) `
            -OfficePhone $User.phone `
            -City $User.city `
            -Company $User.company `
            -Department $User.department `
            -EmailAddress "$Username@example.com" `
            -HomePage $User.homepage `
            -MobilePhone $User.mobile `
            -PostalCode $User.postal_code `
            -StreetAddress $User.street `
            -Title $User.title `
            -PasswordNeverExpires $True

        if ($User.group1)
        {
            Add-ADGroupMember $User.group1 $Username
        }
        if ($User.group2)
        {
            Add-ADGroupMember $User.group2 $Username
        }
        if ($User.group3)
        {
            Add-ADGroupMember $User.group3 $Username
        }
    }
}


# return success, even if there were warnings or errors above
exit 0
