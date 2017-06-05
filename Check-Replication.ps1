function Check-Replication {
Get-ADReplicationPartnerMetadata -Target * -Partition * -ErrorAction SilentlyContinue|
Select-Object LastReplicationSuccess,Server,Partner,ConsecutiveReplicationFailures,LastRepicationResult |
Out-GridView
}
