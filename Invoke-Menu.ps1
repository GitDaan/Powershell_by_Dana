$menu=@"
1 Show info about a computer
2 Show info about a mailbox
3 Restart the print spooler
Q Quit
 
Select a task by number or Q to quit
"@
Function Invoke-Menu {
[cmdletbinding()]
Param(
[Parameter(Position=0,Mandatory=$True,HelpMessage="Enter your menu text")]
[ValidateNotNullOrEmpty()]
[string]$Menu,
[Parameter(Position=1)]
[ValidateNotNullOrEmpty()]
[string]$Title = "My Menu",
[Alias("cls")]
[switch]$ClearScreen
)
 
#clear the screen if requested
if ($ClearScreen) { 
 Clear-Host 
}
 
#build the menu prompt
$menuPrompt = $title
#add a return
$menuprompt+="`n"
#add an underline
$menuprompt+="-"*$title.Length
#add another return
$menuprompt+="`n"
#add the menu
$menuPrompt+=$menu
 
Read-Host -Prompt $menuprompt
 
} #end function

Do {
    #use a Switch construct to take action depending on what menu choice
    #is selected.
    Switch (Invoke-Menu -menu $menu -title "My Help Desk Tasks" -clear) {
     "1" {Write-Host "run get info code" -ForegroundColor Yellow
         sleep -seconds 2
         } 
     "2" {Write-Host "run show mailbox code" -ForegroundColor Green
          sleep -seconds 2
          }
     "3" {Write-Host "restart spooler" -ForegroundColor Magenta
         sleep -seconds 2
         }
     "Q" {Write-Host "Goodbye" -ForegroundColor Cyan
         Return
         }
     Default {Write-Warning "Invalid Choice. Try again."
              sleep -milliseconds 750}
    } #switch
} While ($True)
