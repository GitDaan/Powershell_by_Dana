### All Things Array ###

#Start by creating an Array. Use Get-Random to save some typing
[array]$array = Get-Random -Count 10 -InputObject(1..1000)

#But we need to know the array contents for a tutorial
[array]$array = @(179,904,469,524,503,549,524,808,328,524) 

#Show the new array using the standard method (which is very VB looking).
For($i=0;$i-le $array.Length-1;$i++) {
    "`$array[{0}] = {1}" -f $i, $array[$i]} #Note formatting with -f for "$array[x] = ..." ($array[x]" was item {0} while the actual number was {1})

#Create a function to provide a better formatted output
function Show-ArrayIndex {$counter = 0; $input | Out-String -Stream | % { ("[{0:0000}] " -f $counter++) + $_.TrimEnd() }} #Much more -Like Powershell
$array | Show-ArrayIndex

#Let's do strings too
$ArrayStrings = @("JimBob","Jeff","Daner","Deanna","Jacob","Heidi","AlWright","User1","User2","User3")
$ArrayStrings | Show-ArrayIndex

### Working With Arrays ###

#Splitting the array
#You can use either Count or Length to determine the number of items in the array.
'$array.Count is ' + $array.Count
'$array.Length is ' + $array.Length

#because arrays start at 0, even number lengths must be rounded to divide properly
"`n " + $array.GetUpperBound(0) + " is not the same as " + $array.Count + "`n UpperBound() divided by 2 will therefor give " + ($array.GetUpperBound(0)/2)

#Getting the Lower Half - While this may seem convoluted, use [int] to round off the number
"The lower half (first 5) is " + $array[0..([int]($array.GetUpperBound(0)/2))]

#Getting the Upper Half - Add .5 to even things up with an odd number (an old VB trick)
"The Upper half (last 5) is " + $array[(($array.GetUpperBound(0)/2)+ .5)..($array.GetUpperBound(0))]

#Adding a member to an array is easy
'$Array.Count is ' + $array.Count        #show original array size
$array += 99
"`$Array.Count is now $($Array.Count)"   #this size should be one larger now
$array | Show-ArrayIndex

#Removing array items is not so easy
#Discussion - Issue here is ArrayType[] is a fixed size. In fact, doing '+=' actually creates a new array (witht the same name as the old array).
# But an ArrayListType[] is of indeterminate size (should say that it is Schrödinger length)
#  Fix then is to re-cast the Array[] to Arraylist[] and then use the Remove method of the object.

[Collections.ArrayList]$array = $array

$array.Remove(99) 

"`$Array.Count is now $($Array.Count)"
$array | Show-ArrayIndex
$array.GetType()

#reset the Type[]
[array]$array = $array
$array.GetType()

#Powershell does not have a method to find the array position of an item. Use the static method of .Net to do this
#  First, identify the item you want to look for
$ItemOfInterest = 524

#Then use the discussed .Net method
[array]::IndexOf($array,$ItemOfInterest)

#What if there are two numbers that are the same? We can find the last one using the same static function System.array but method LastIndexOf
[array]::LastIndexOf($array,524)

#Worse yet, what if we don't know how many duplicates there are? 
#  Do a Where-Object search (where-object is a looping function). Note that the part before the Pipe symbol is to reduce the size of the search (what if there were 100K records?).

(0..([array]::LastIndexOf($array,$ItemOfInterest))) | where {$array[$_] -eq $ItemOfInterest}

#Since an ArrayType[] is of System.object, Sort and Select will work.
$array | Sort-Object -Unique
$array | Select-Object -Unique