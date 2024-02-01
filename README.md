# Get-LastLogin

Simple script to get true last login information for a given user.

To perform this feat, it is necessary to get a list of all domain controllers, then query each domain controller for the LastLogon attribute for the user.  The latest date/time is used for output, giving the last true last logon time of the user.