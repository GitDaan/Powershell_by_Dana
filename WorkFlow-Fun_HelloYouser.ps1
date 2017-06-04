WorkFlow HelloUserTime
{
$Youser = InlineScript { (Get-ChildItem env:username).Value}
 $dateHour = Get-date -UFormat ‘%H’
 if($dateHour -le 12) {“Good morning $Youser”}
 ELSeIF ($dateHour -gt 12 -AND $dateHour -le 18) {“Good afternoon $Youser”}
 ELSE {“Good evening $Youser”}

}