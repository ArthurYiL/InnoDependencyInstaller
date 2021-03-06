// requires Windows 7, Windows Server 2003, Windows Server 2008, Windows Server 2008 R2, Windows Vista, Windows XP
// requires Microsoft .NET Framework 3.5 SP 1 or later
// requires Windows Installer 4.5 or later
// https://www.microsoft.com/download/en/details.aspx?id=3743

[CustomMessages]
sql2008express_title=SQL Server 2008 Express R2

sql2008express_size=58 MB
sql2008express_size_x64=74 MB

[Code]
const
	sql2008express_url = 'https://download.microsoft.com/download/5/1/A/51A153F6-6B08-4F94-A7B2-BA1AD482BC75/SQLEXPR32_x86_ENU.exe';
	sql2008express_url_x64 = 'https://download.microsoft.com/download/5/1/A/51A153F6-6B08-4F94-A7B2-BA1AD482BC75/SQLEXPR_x64_ENU.exe';

procedure sql2008express();
var
	version: String;
begin
	// This check does not take into account that a full version of SQL Server could be installed,
	// making Express unnecessary.
	if not RegQueryStringValue(HKLM, 'SOFTWARE\Microsoft\Microsoft SQL Server\SQLEXPRESS\MSSQLServer\CurrentVersion', 'CurrentVersion', version) or (compareversion(version, '10.5') < 0) then begin
		AddProduct('sql2008express' + GetArchitectureString() + '.exe',
			'/QS /IACCEPTSQLSERVERLICENSETERMS /ACTION=Install /FEATURES=All /INSTANCENAME=SQLEXPRESS /SQLSVCACCOUNT="NT AUTHORITY\Network Service" /SQLSYSADMINACCOUNTS="builtin\administrators"',
			CustomMessage('sql2008express_title'),
			CustomMessage('sql2008express_size' + GetArchitectureString()),
			GetString(sql2008express_url, sql2008express_url_x64),
			'', False, False, False);
	end;
end;
