@echo on
pip install delvewheel
choco upgrade postgresql

:: type C:\ProgramData\chocolatey\logs\chocolatey.log
:: Infinite long, but it reports PG 14.0.1 installed in the past days
:: dir "C:\program files\PostgreSQL"
:: There's only 14
pg_config
