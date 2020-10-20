Write-Host "argc: $($args.Length)"
for ($ndx = 0; $ndx -lt $args.Length; $ndx++)
{
    Write-Host "arg$($ndx + 1): $($args[$ndx])"
}
