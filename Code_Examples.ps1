<# For Loop Example #>
$colors = @("Red", "Blue", "Green", "Orange","Violet", "Indigo")
$listName =@("First","Second","Thrid","Forth", "Fifth", "Sixth")
for ($i=0; $i -lt $colors.Length; $i++){
    $listName[$i] +" is "+ $colors[$i]
}
$colors[0].ToUpper()

<# comparison operators 
-gt (greater than), 
-le (less than),
-ge (greater than or equal to) 
-eq (equal to)
-ne (not equal to) 
  #>

<# Foreach Loop Example #>
$color1s = @("Red", "Blue", "Green", "Orange","Violet", "Indigo")
foreach ($color1 in $color1s){
    $color1
}



<# Foreach Loop with Pipe Example #>
$color2s = @("Red", "Blue", "Green", "Orange","Violet", "Indigo")
$colors2s | foreach {$_}


<# Get-Content and Foreach Loop with Pipe Example #>
$filename = "C:\Users\Frank\Documents\code\PowerShell\dictionary_list.txt"
Get-Content $filename | foreach {$_.ToUpper()}


<# Get-process | Out-File -FilePath C:\Users\Frank\Documents\code\Powershell\test123.txt#>
<# Get-Content -Path C:\Users\Frank\Documents\code\Powershell\test123.txt#>

$filename2 = "C:\Users\Frank\Documents\code\Powershell\test123.txt"
<#
Get-process | Out-File -FilePath C:\Users\Frank\Documents\code\Powershell\test123.txt
#>
Get-process | Out-File -FilePath $filename2
Get-process | Select-Object ProcessName | Out-File -FilePath $filename2 -Append

<#Get data from a CSV file and put it in an array#>

$Datafile = "C:\Users\Frank\Documents\code\Powershell\dataText.txt"
$DB = Get-Content $Datafile
foreach( $Data in $DB){
    $Data =($Data -split(','))
    $Firstname = $Data[0]
    $Lastname = $Data[1]
    $Age = $Data[2]
    $City = $Data[3]
    $State = $Data[4]
   "Firstname: "+ $Firstname +" Lastname: "+$Lastname +" Age: "+ $Age

}



#-------------
Clear-Host
$myname = 'Frank'
write-output "It's a nice day $myname."
write-warning 'It may rain later $myname.'

#https://doc.microsoft.com/en-us/powershell/module/microsoft.powershell
Write-Error -Message 'User not authorized' -ErrorId 99 -Category AuthenticationError
Write-Error -Message 'User not authorized' -ErrorId 99 -Category CloseError

#Progress bar
for ($i = 0 ; $i -le 100; $i+=20)
{
        Write-Progress -Activity "Search in Progress" -Status "$i% Complete:" -PercentComplete $i;
        Start-Sleep 10
}

#Format Table
Get-ChildItem |
    Format_Table -Authorize -Property Name, Lengh -GroupBy #Requires -Module 
    
#Gridview
    Get-ChildItem | Out-Gridview -Title "File List"

#User Input

$uservalue = Read-Host 'Enter your name'
Write-output $uservalue

[int]$uservalue = Read-Host 'Enter your age'
Write-Output $uservalue

# https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/convertto-securstring?view=pow
$uservalue = Read-Host 'Enter your password' -AsSecureString
Write-Output $uservalue

#Secure input
$credin = Get-Credential
Write-Output $credin


# Creating HTML Output

function Out-udfHTML ([string] $p_headingbackcolor, [switch] $AlternateRows)
{
    <#
    #>
    If ($AlternateRows) {$tr_alt = "TR:Nth-Child(EVEN) {Background-Color: #dddddd;} "}
    $format = @"
    <style>
    TABLE {border-width: 1px;border-style: solid; border-color: black;border-collapse: collapse;}
    TH {border-witdth: 1px; padding: 3px;border-style: solid; border-color; black;background-color: $p_headingbackcolor }
    $tr_alt
    TD {border-width: 1px;padding: 3px;border-style: solid;border-color: black;}
    </style>
"@
RETURN $format
}

<#
Get-ChildItem | Select-Object -Property name, LastWriteTime |
ConvertTo-HTML -Head ( Out-udfHTML "lightblue" -AlternateRows) -Pre "<h1>File List</h1>" -Post ("<h1>As of " + (Get-Date)+ "</h1>")|
 Out-File MyReport.HTML
Invoke-Item MyReport.HTML
#>