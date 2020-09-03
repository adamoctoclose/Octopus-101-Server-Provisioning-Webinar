$region = $OctopusParameters["Project.AWS.Region.Id"]
$id = $OctopusParameters["Project.AWS.MySQL.Stack.Name"]
$DatabaseEndpoint = aws rds --region $region describe-db-instances --db-instance-identifier $id --query "DBInstances[*].Endpoint.Address" --output text

Set-OctopusVariable -name "DatabaseEndpoint" -value $DatabaseEndpoint